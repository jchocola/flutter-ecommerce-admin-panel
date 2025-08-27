import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/products/create_products/controller/image_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

class ProductThumnailImage extends StatelessWidget {
  const ProductThumnailImage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final ProductImagesController controller = Get.put(ProductImagesController());
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: dark ? Colors.white.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: dark ? TColors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2))
      ),
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product Thumbnail', style: Theme.of(context).textTheme.headlineSmall,),
            const SizedBox(height: TSizes.spaceBetwwenItems,),
            TRoundedContainer(
              width: double.infinity,
              backgroundColor: dark? Colors.white.withOpacity(0.05) : Colors.white,
              showBorder: true,
              radius: 5,
             
              borderColor: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Expanded(
                          child: Obx(
                            () => TRoundedImage(
                              width: 220,
                              backgroundColor: Colors.transparent,
                              height: 220,
                              isNetworkImage: true,
                              imageProvider: controller.selectedThumbnailImageUrl.value != null 
                                  ? NetworkImage(controller.selectedThumbnailImageUrl.value!) 
                                  : AssetImage(TImages.placeholder),

                            )
                          ),
                        )
                      ],
                    ),
                
                    GestureDetector(
                      onTap: () => controller.selectThumbnailImage(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: dark ? Colors.white.withOpacity(0.05) : Colors.transparent,
                          border: Border.all(
                            color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(5)
                          
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(controller.selectedThumbnailImageUrl.value != null ? 'Change Thumbnail' : 'Add Thumbnail', style: TextStyle(color: dark ? Colors.white : TColors.dark),),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}