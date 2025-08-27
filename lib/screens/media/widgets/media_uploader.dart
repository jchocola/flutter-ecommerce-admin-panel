import 'dart:html';
import 'dart:io' as html show File;
import 'dart:typed_data';
import 'package:admin_panel/screens/media/widgets/select_folder.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/media/controller/media_controller.dart';
import 'package:admin_panel/screens/media/widgets/folder_drop.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/formatters/enum.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    final dark = THelperFunctions.isDarkMode(context);
    final user = Supabase.instance.client.auth.currentUser;
if (user == null) {
  print('❌ Not logged in');
} else {
  print ('Loged ✅');
}
    return Obx(() {
      if (!controller.showImageUploaderSection.value)
        return const SizedBox.shrink();

      return Column(
        children: [
          /// Dropzone Area
          TRoundedContainer(
            showBorder: true,
            radius: 5,
            width: double.infinity,
            height: 250,
            borderColor: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
            backgroundColor: dark ? Colors.white.withOpacity(0.05) : TColors.primaryBackground,
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Stack(
              alignment: Alignment.center,
              children: [
                DropzoneView(
                  mime: const ['image/jpeg', 'image/png'],
                  operation: DragOperation.copy,
                  cursor: CursorType.Default,
                  onCreated: (ctrl) => controller.dropzoneController = ctrl,
                 onDrop: (file) async {
  try {
    // Check if it's a real drag-and-drop HTML file
    if (file.runtimeType.toString() == 'File') {
      // Import html as: import 'dart:html' as html;
      await controller.handleDragAndDrop(file as File);
    } else {
      // Picked using file picker
      await controller.handleFilePicker(file);
    }
  } catch (e) {
    print('❌ Error in onDrop: $e');
  }
},

                  onDropInvalid: (ev) => print('Invalid drop: $ev'),
                  onError: (err) => print('Dropzone error: $err'),
                  onLoaded: () => print('Dropzone ready'),
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(TImages.placeholder, width: 50, height: 50, color: dark ? Colors.white : TColors.primary,),
                    const SizedBox(height: TSizes.spaceBetwwenItems),
                    const Text('Drag and Drop Images here'),
                    const SizedBox(height: TSizes.spaceBetwwenItems),
                    GestureDetector(
                      onTap: () => controller.selectLocalImages(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: dark ? Colors.white.withOpacity(0.15) : TColors.primary,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Select Images', textAlign: TextAlign.center,),
                        )),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: TSizes.spaceBetwwenItems),

          /// Preview & Upload Section
          if (controller.selectedImagesToUpload.isNotEmpty)
            TSelectFolder(),
        ],
      );
    });
  }
}

