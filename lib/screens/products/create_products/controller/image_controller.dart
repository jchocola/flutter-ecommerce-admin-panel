import 'package:admin_panel/screens/media/controller/media_controller.dart';
import 'package:admin_panel/util/models/image_model.dart';
import 'package:admin_panel/util/models/product_model/variation_model.dart';
import 'package:get/get.dart';

class ProductImagesController extends GetxController {
  static ProductImagesController get instance => Get.find();

  Rx<String?> selectedThumbnailImageUrl = Rx<String?>(null);

  final RxList<String> additionalProductImagesUrls = <String>[].obs;

  // Use Get.find to avoid creating duplicates of MediaController
  final MediaController _mediaController = Get.find<MediaController>();

  Future<void> selectThumbnailImage() async {
    List<ImageModel>? selectedImages = await _mediaController.selectedImagesFromMedia();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      selectedThumbnailImageUrl.value = selectedImages.first.url;
    }
  }

  Future<void> selectMultipleProductImages() async {
    List<ImageModel>? selectedImages = await _mediaController.selectedImagesFromMedia(
      multipleSelection: true,
      selectedUrls: additionalProductImagesUrls,
    );
    if (selectedImages != null && selectedImages.isNotEmpty) {
      additionalProductImagesUrls.assignAll(selectedImages.map((e) => e.url));
      additionalProductImagesUrls.refresh(); // important for web UI update
    }
  }

  Future<void> removeImage(int index) async {
    if (index >= 0 && index < additionalProductImagesUrls.length) {
      additionalProductImagesUrls.removeAt(index);
      additionalProductImagesUrls.refresh(); // force UI update on web
    } else {
      print('Invalid index $index for removal');
    }
  }

  Future<void> removeImageEdit(int index) async {
    // You can merge this with removeImage if desired
    return removeImage(index);
  }

  Future<void> selectVariationImage(ProductVariantionsModel variation) async {
    List<ImageModel>? selectedImages = await _mediaController.selectedImagesFromMedia();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      variation.image.value = selectedImages.first.url;
    }
  }
}
