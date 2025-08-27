import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/media/controller/media_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/models/image_model.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:iconsax/iconsax.dart';

class TImagePopup extends StatelessWidget {
  const TImagePopup({super.key, required this.image});

  final ImageModel image;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(MediaController());
    return SingleChildScrollView(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
        ),
        child: TRoundedContainer(
          backgroundColor: dark ? TColors.dark.withOpacity(0.5) : Colors.white,
          width:
              TDeviceUtils.isDesktopScreen(context)
                  ? MediaQuery.of(context).size.width * 0.4
                  : double.infinity,
          padding: const EdgeInsets.all(TSizes.spaceBetwwenItems),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Stack(
                  children: [
                    TRoundedContainer(
                      backgroundColor: dark ? Colors.white.withOpacity(0.05) : Colors.white,
                      child: TRoundedImage(
                        imageUrl: image.url,
                        applyImageRadius: true,
                        backgroundColor: dark ? Colors.white.withOpacity(0.05) : Colors.white,
                        height: MediaQuery.of(context).size.height * 0.4,
                        width:
                            TDeviceUtils.isDesktopScreen(context)
                                ? MediaQuery.of(context).size.width * 0.4
                                : double.infinity,
                        isNetworkImage: true,
                      ),
                    ),

                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Iconsax.close_circle),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: TSizes.spaceBetwwenItems),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Image Name',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      image.fileName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Image URL: ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      image.url,
                      style: Theme.of(context).textTheme.labelLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: TSizes.lg,),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                          FlutterClipboard.copy(image.url).then(
                            (value) =>
                                ScaffoldMessenger.of(Get.context!).showSnackBar(
                                  SnackBar(
                                    content: Text('URL Copied'),
                                    backgroundColor: Colors.blue,
                                  ),
                                ),
                          );
                        },
                      child: Container(   
                        decoration: BoxDecoration(
                          color: dark ? Colors.white.withOpacity(0.05) : Colors.white,
                          border: Border.all(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(5)
                        ),                   
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: const Text('Copy Url', textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBetwwenSections,),

              Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    SizedBox(
      width: 300,
      child: TextButton(
        onPressed: () => controller.deleteImageByFileNameAndFolder(image.fileName,image.folder),
        child: const Text('Delete Image', style: TextStyle(color: Colors.red)),
      ),
    ),
  ],
)

            ],
          ),
        ),
      ),
    );
  }
}
