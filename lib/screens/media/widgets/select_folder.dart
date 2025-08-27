import 'dart:typed_data';

import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/media/controller/media_controller.dart';
import 'package:admin_panel/screens/media/widgets/folder_drop.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/formatters/enum.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TSelectFolder extends StatelessWidget {
  const TSelectFolder({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    final dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      backgroundColor: dark ? Colors.white.withOpacity(0.05) : Colors.white,
      showBorder: true,
      borderColor: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Bar: Folder & Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Folder Select
              Row(
                children: [
                  Text(
                    'Select Folder',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  MediaFolderDropdown(
                    onChanged: (MediaCategory? newValue) {
                      if (newValue != null) {
                        controller.selectedPath.value = newValue;
                                                  controller.fetchImagesByCategory(newValue.name);

                      }
                    },
                  ),
                ],
              ),
    
              /// Buttons
              Row(
                children: [
                  TextButton(
                    onPressed:
                        () => controller.selectedImagesToUpload.clear(),
                    child: const Text('Remove All'),
                  ),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  if (!TDeviceUtils.isMobileScreen(context))
                
                    SizedBox(
                      width: TSizes.buttonWidth,
                      child: ElevatedButton(
                        onPressed: () => controller.uploadImageConfirmation(),
                        child: const Text('Upload'),
                        
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBetwwenSections),
    
          /// Image Preview Wrap
          Wrap(
            spacing: TSizes.spaceBetwwenItems / 2,
            runSpacing: TSizes.spaceBetwwenItems / 2,
            children:
                controller.selectedImagesToUpload.map((image) {
                  return TRoundedImage(
                    width: 90,
                    height: 90,
                    padding: const EdgeInsets.all(TSizes.sm),
                    imageProvider: MemoryImage(
                      image.localImageToDisplay ?? Uint8List(0),
                    ),
                    backgroundColor: dark ? Colors.white.withOpacity(0.10) : Colors.white,
                    border: Border.all(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2)),
                    imageUrl: image.url,
                  );
                }).toList(),
          ),
    
          const SizedBox(height: TSizes.spaceBetwwenSections),
    
          /// Upload button for mobile
          if (TDeviceUtils.isMobileScreen(context))
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Upload'),
              ),
            ),
            const SizedBox(height: TSizes.spaceBetwwenItems,),
        ],
      ),
    );
  }
}
