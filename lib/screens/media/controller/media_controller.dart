import 'dart:async';
import 'dart:typed_data';
import 'dart:html' as html; // Only used for drag-and-drop

import 'package:admin_panel/common/widgets/dialogs/dialogs.dart';
import 'package:admin_panel/screens/media/widgets/media_content.dart';
import 'package:admin_panel/screens/media/widgets/media_uploader.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:admin_panel/util/models/image_model.dart';
import 'package:admin_panel/util/formatters/enum.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  late DropzoneViewController dropzoneController;

  final RxBool showImageUploaderSection = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;
  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;

  final RxList<ImageModel> allImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBannersImage = <ImageModel>[].obs;
  final RxList<ImageModel> allProductImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBrandImages = <ImageModel>[].obs;
  final RxList<ImageModel> allCategoryImages = <ImageModel>[].obs;
  final RxList<ImageModel> allUserImages = <ImageModel>[].obs;

  final supabase = Supabase.instance.client;
  final uuid = Uuid();

  /// Handle file picker selection
  Future<void> handleFilePicker(dynamic file) async {
    try {
      final name = await dropzoneController.getFilename(file);
      final bytes = await dropzoneController.getFileData(file);

      selectedImagesToUpload.add(
        ImageModel(
          url: '',
          folder: '',
          fileName: name,
          localImageToDisplay: bytes,
        ),
      );
    } catch (e) {
      print('❌ Picker error: $e');
    }
  }

  /// Handle drag and drop using `html.File`
  Future<void> handleDragAndDrop(html.File file) async {
    try {
      final reader = html.FileReader();
      final completer = Completer<Uint8List>();

      reader.readAsArrayBuffer(file);

      reader.onLoadEnd.listen((_) {
        completer.complete(reader.result as Uint8List);
      });

      reader.onError.listen((_) {
        completer.completeError('Failed to read dropped file');
      });

      final bytes = await completer.future;

      selectedImagesToUpload.add(
        ImageModel(
          url: '',
          folder: '',
          fileName: file.name,
          localImageToDisplay: bytes,
        ),
      );
    } catch (e) {
      print('❌ Drag-and-drop error: $e');
    }
  }

  /// Select local images using dropzone picker
  Future<void> selectLocalImages() async {
    try {
      final files = await dropzoneController.pickFiles(
        multiple: true,
        mime: ['image/jpeg', 'image/png'],
      );
      for (var file in files) {
        await handleFilePicker(file);
      }
    } catch (e) {
      print('❌ Picker failed: $e');
    }
  }

  /// Confirm upload or show snackbar if no folder selected
  void uploadImageConfirmation() {
    final context = Get.context;
    if (selectedPath.value == MediaCategory.folders) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Select Folder: Please select the Folder in order to upload the Images',
            ),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print('❌ Error: BuildContext is null');
      }
    } else {
      if (context != null) {
        TDialogs.defaultDialog(
          context: context,
          title: 'Upload Images',
          confirmText: 'Upload',
          onConfirm: () async => await uploadMultipleImagesConcurrently(),
          content:
              'Are you sure you want to upload all the Images in ${selectedPath.value.name.toUpperCase()} folder?',
        );
      } else {
        print('❌ Error: BuildContext is null');
      }
    }
  }

  /// Upload multiple images concurrently
  Future<void> uploadMultipleImagesConcurrently() async {
    try {
      Get.back(); // close confirmation dialog
      uploadImageLoader(); // show loader

      final selectedCategory = selectedPath.value;
      final targetPath = getSelectedPath();

      final RxList<ImageModel> targetList;
      switch (selectedCategory) {
        case MediaCategory.banners:
          targetList = allBannersImage;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
          break;
        default:
          targetList = allImages;
      }

      final futures = selectedImagesToUpload.asMap().entries.map((entry) async {
        final i = entry.key;
        final image = entry.value;

        final fileName =
            '${DateTime.now().millisecondsSinceEpoch}${image.fileName}';
        final fileBytes = image.localImageToDisplay!;

        final response = await supabase.storage.from('images').uploadBinary(
              '$targetPath/$fileName',
              fileBytes,
              fileOptions: const FileOptions(
                contentType: 'image/jpeg',
                upsert: true,
              ),
            );

          final publicUrl =
              supabase.storage.from('images').getPublicUrl('$targetPath/$fileName');

          final uploadedImage = ImageModel(
            url: publicUrl,
            folder: targetPath,
            id: uuid.v4(),
            isActive: false,
            fileName: fileName,
            
            localImageToDisplay: fileBytes,
          );

          targetList.add(uploadedImage);

          final imageId = uuid.v4();

         try {
  final response = await supabase.from('images').insert({
    'url': uploadedImage.url,
    'filename': fileName,
    'id': imageId,
    'is_active': false,
    'folder': targetPath,
    'created_at': DateTime.now().toIso8601String(),
    'mediaCategory': targetPath,
  });
allImages.add(uploadedImage);         // ✅ Add this line if not already

  // If insert succeeds, response contains inserted rows
  print('✅ Insert success: $response');
} catch (error) {
  // Insert failed
  print('❌ Insert failed: $error');
}


        
      }).toList();

      await Future.wait(futures);

      selectedImagesToUpload.clear();
      Get.back(); // close loader

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text('✅ All images uploaded successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      Get.back(); // close loader
      print('$e');
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('❌ Upload failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
Future<void> deleteImageByFileNameAndFolder(String fileName, String folder) async {
  try {
    final supabase = Supabase.instance.client;

    final filePath = '$folder/$fileName';
    print('🧹 Deleting image at: $filePath');

    // Step 1: Delete from storage
    final storageResponse = await supabase.storage.from('images').remove([filePath]);

    if (storageResponse is List && storageResponse.isEmpty) {
      print('✅ Storage: Deleted $filePath');
    } else {
      print('❌ Storage deletion failed: $storageResponse');
    }

    // Step 2: Delete from images table
    final dbResponse = await supabase
        .from('images')
        .delete()
        .eq('filename', fileName);
MediaController.instance.allImages.removeWhere((img) =>
    img.fileName == fileName && img.folder == folder);

    Get.back();

    if (dbResponse is List && dbResponse.isNotEmpty) {
      print('✅ Database: Deleted record for $fileName');
    } else {
      print('❌ Database: No match found or delete denied. Response: $dbResponse');
    }
  } catch (e) {
    print('❌ Exception deleting image: $e');
  }
}

Future<bool> deleteImageFromStorage(String path) async {
  try {
    final response = await Supabase.instance.client
        .storage
        .from('images')
        .remove([path]);

    if (response is List && response.isEmpty) {
      print('✅ Storage: Deleted $path');
      return true;
    } else {
      print('❌ Storage deletion error: $response');
      return false;
    }
  } catch (e) {
    print('❌ Exception deleting from storage: $e');
    return false;
  }
}



Future<bool> deleteImageFromDatabase(String imageId) async {
  try {
    final response = await Supabase.instance.client
        .from('images')
        .delete()
        .eq('id', imageId);

    if (response is List && response.isNotEmpty) {
      print('✅ Database: Deleted ID $imageId');
      return true;
    } else {
      print('❌ Database: No matching ID or permission denied. Response: $response');
      return false;
    }
  } catch (e) {
    print('❌ Exception deleting from database: $e');
    return false;
  }
}



Future<void> deleteImage(ImageModel image) async {
  if (image.id == null || image.id!.isEmpty) {
    print('❌ Invalid image ID');
    return;
  }

  final path = '${image.folder}/${image.fileName}';
  print('🗑️ Deleting: $path with ID ${image.id}');

  final storageResult = await deleteImageFromStorage(path);
  final dbResult = await deleteImageFromDatabase(image.id!);

  if (storageResult && dbResult) {
    MediaController.instance.allImages.remove(image);
    Get.snackbar('Success', 'Image deleted',
        backgroundColor: Colors.green, colorText: Colors.white);
  } else {
    Get.snackbar('Failed', 'Image not deleted',
        backgroundColor: Colors.red, colorText: Colors.white);
  }
}




  /// Show a loading dialog while uploading
  void uploadImageLoader() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('Uploading Images'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(TImages.uploading_animation, width: 150, height: 150),
              const SizedBox(height: TSizes.spaceBetwwenItems),
              const Text('Sit tight, Your images are uploading...'),
            ],
          ),
        ),
      ),
    );
  }

  /// Map selected media category to folder path string
  String getSelectedPath() {
    switch (selectedPath.value) {
      case MediaCategory.banners:
        return TText.pathBanners;
      case MediaCategory.brands:
        return TText.pathBrands;
      case MediaCategory.categories:
        return TText.pathCategories;
      case MediaCategory.products:
        return TText.pathProducts;
      case MediaCategory.users:
        return TText.pathUsers;
      default:
        return 'Others';
    }
  }

Future<void> fetchImagesByCategory(String category) async {
    print('📦 Fetching images for category: $category');
  try {
    final data = await supabase
        .from('images')
        .select()
        .eq('mediaCategory', category)
        .order('created_at', ascending: false);

    allImages.value = (data as List<dynamic>)
        .map((json) => ImageModel.fromJson(json))
        .toList();

    print('✅ Loaded ${allImages.length} images for "$category"');
  } catch (e) {
    print('❌ Error fetching images: $e');
  }
}

Future<List<ImageModel>?> selectedImagesFromMedia({
  List<String>? selectedUrls,
  bool allowSelection = true,
  bool multipleSelection = false,
}) async {
  showImageUploaderSection.value = true;

  final context = Get.context!;
  final theme = Theme.of(context);

  return await Get.bottomSheet<List<ImageModel>>(
    isScrollControlled: true,
    backgroundColor: theme.scaffoldBackgroundColor,
    Material(
      color: theme.scaffoldBackgroundColor,
      child: Theme(
        data: theme, // inherit theme from current context
        child: FractionallySizedBox(
          heightFactor: 1,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const MediaUploader(),
                  MediaContent(
                    allowSelection: allowSelection,
                    allowMultipleSelection: multipleSelection,
                    alreadySelectedUrls: selectedUrls ?? [],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}


}



