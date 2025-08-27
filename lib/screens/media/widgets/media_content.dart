// media_content.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/formatters/enum.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/models/image_model.dart';
import 'package:admin_panel/screens/media/controller/media_controller.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/common/widgets/popup/image_popup.dart';
import 'package:admin_panel/screens/media/widgets/folder_drop.dart';
import 'package:iconsax/iconsax.dart';

class MediaContent extends StatelessWidget {
  MediaContent({
    super.key,
    this.allowSelection = false,
    this.allowMultipleSelection = false,
    this.alreadySelectedUrls,
    this.onImageSelected,
  });

  final bool? allowSelection;
  final bool? allowMultipleSelection;
  final List<String>? alreadySelectedUrls;
  final List<ImageModel>? selectedImages = [];
  final Function(List<ImageModel> selectedImages)? onImageSelected;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    final dark = THelperFunctions.isDarkMode(context);
    bool loadedPreviousSelection = false;

    return TRoundedContainer(
      radius: 5,
      backgroundColor: dark ? Colors.white.withOpacity(0.05) : Colors.white,
      showBorder: true,
      borderColor:
          dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Folder Dropdown
            Row(
              children: [
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
                const SizedBox(width: TSizes.defaultSpace,),
                if (allowSelection!) buildAddSelectedImagesButton(dark),
              ],
            ),
            const SizedBox(height: TSizes.spaceBetwwenSections),

            /// Images Grid
            Obx(() {
              final images = controller.allImages;
              if (images.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text('🖼️ No images found for this category'),
                );
              }

              if(!loadedPreviousSelection) {
                if(alreadySelectedUrls != null && alreadySelectedUrls!.isNotEmpty) {

                final selectedUrlsSet = Set<String>.from(alreadySelectedUrls!);

                for(var image in images) {
                  image.isSelected.value = selectedUrlsSet.contains(image.url);
                  if(image.isSelected.value) {
                    selectedImages?.add(image);
                  }
                }
              } else {
                for (var image in images) {
                  image.isSelected.value = false;
                }
              }
              loadedPreviousSelection = true;
              }


              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children:
                        images.map((image) => GestureDetector(
  onTap: () => Get.back(),
  child: SizedBox(
    width: 140,
    height: 180,
    child: Column(
      children: [
        (allowSelection ?? false)
          ? _buildListWithCheckBox(image, dark)
          : _buildWithSimpleList(image, dark),
      ],
    ),
  ),
))

                            .toList(),
                  ),
                ],
              );
            }),

            /// Load More Button
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: TSizes.spaceBetwwenSections,
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    final category = controller.selectedPath.value.name;
                    controller.fetchImagesByCategory(category);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: TSizes.buttonWidth,
                    decoration: BoxDecoration(
                      color:
                          dark
                              ? Colors.white.withOpacity(0.15)
                              : TColors.primary,
                      border: Border.all(
                        color:
                            dark
                                ? Colors.grey.withOpacity(0.5)
                                : TColors.dark.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text('Load More', textAlign: TextAlign.center),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddSelectedImagesButton(bool dark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: dark ? Colors.white.withOpacity(0.05) : Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2))
          ),
          child: GestureDetector(
            onTap: ()=> Get.back(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Close', style: TextStyle(color: Colors.white),),
            )),
        ),
        const SizedBox(width: TSizes.spaceBetwwenItems),
       GestureDetector(
        onTap: ()=> Get.back(result: selectedImages),
         child: Container(
            decoration: BoxDecoration(
              color: dark ? TColors.primary.withOpacity(0.9) : TColors.primary,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2))
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Add +', style: TextStyle(color: Colors.white),),
            ),
          ),
       ),
      ],
    );
  }

  Widget _buildWithSimpleList(ImageModel image, bool dark) {
    return   Container(
        decoration: BoxDecoration(
        color: dark ? TColors.dark : Colors.white
      ),
      child: TRoundedImage(
          width: 90,
          height: 90,
          
          imageUrl: image.url,
          padding: const EdgeInsets.all(10),
          isNetworkImage: true,
          backgroundColor: dark ? TColors.dark : Colors.white,
          border: Border.all(
            color:
                dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
          ),
          onPressed: () {
            if (onImageSelected != null) {
              onImageSelected!([image]);
            } else {
              Get.dialog(TImagePopup(image: image));
            }
          },
        ),
    );
  }

  Widget _buildListWithCheckBox(ImageModel image, bool dark) {
    return Container(
      decoration: BoxDecoration(
        color: dark ? TColors.dark : Colors.white
      ),
      child: Stack(
        children: [
          TRoundedImage(
          width: 90,
          height: 90,
          imageUrl: image.url,
          padding: const EdgeInsets.all(10),
          isNetworkImage: true,
          backgroundColor: dark ? TColors.dark : Colors.white,
          border: Border.all(
            color:
                dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
          ),
          onPressed: () {
            if (onImageSelected != null) {
              onImageSelected!([image]);
            } else {
              Get.dialog(TImagePopup(image: image));
            }
          },
        ),
        Positioned(
          top: TSizes.md,
          right: TSizes.md,
          child: Obx(
            () => Checkbox(
              value: image.isSelected.value,
              onChanged: (selected) {
                if(selected != null) {
                  image.isSelected.value = selected;
      
                  if(selected) {
                    if(!allowMultipleSelection!) {
                      for(var otherImage in selectedImages!) {
                        if(otherImage != image) {
                          otherImage.isSelected.value = false;
                        }
                      }
                      selectedImages!. clear();
                    }
      
                    selectedImages?.add(image);
                  } else {
                    selectedImages?.remove(image);
                  }
                }
              },
            )))
        ],
      ),
    );
  }
}
