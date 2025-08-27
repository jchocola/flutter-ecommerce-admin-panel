import 'package:admin_panel/screens/media/controller/media_controller.dart';
import 'package:admin_panel/screens/media/widgets/media_content.dart';
import 'package:admin_panel/screens/media/widgets/media_uploader.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MediaTabletScreen extends StatelessWidget {
  const MediaTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
       body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text('Media', style: Theme.of(context).textTheme.headlineLarge,),
                   GestureDetector(
                      onTap: () => controller.showImageUploaderSection.value = !controller.showImageUploaderSection.value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: dark ? Colors.white.withOpacity(0.15) : TColors.primary,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2))
                        ),
                        
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            spacing: 10,
                            children: [
                              Icon(controller.selectedImagesToUpload.isNotEmpty ? Iconsax.call_incoming : Iconsax.cloud_add),
                              Text(controller.selectedImagesToUpload.isNotEmpty ? 'Cancel' : 'Upload Images', textAlign: TextAlign.center,),
                            ],
                          ),
                        )),
                    ),
                ],
              ),

              const SizedBox(height: TSizes.spaceBetwwenSections,),

              MediaUploader(),
              const SizedBox(height: TSizes.spaceBetwwenItems,),
              MediaContent(allowMultipleSelection: false, allowSelection: false,)


            ],
          ),
        ),
      ),
    );
  }
}