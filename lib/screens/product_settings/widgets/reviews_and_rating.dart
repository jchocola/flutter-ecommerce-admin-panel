import 'package:admin_panel/screens/product_settings/controller/product_settings_controller.dart';
import 'package:admin_panel/screens/product_settings/widgets/toggle_button.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TReviewsAndRating extends StatelessWidget {
  const TReviewsAndRating({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductSettingsController());
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: dark ? Colors.white.withOpacity(0.05) : Colors.white,
        border: Border.all(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Padding(
        padding: const EdgeInsets.all(TSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reviews & Rating',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSizes.spaceBetwwenItems,),

            if(TDeviceUtils.isMobileScreen(context))
             Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TToggleButton(
                  controller: controller.enableproductreview,
                  title: 'Enable Product Review',

                ),
                
                 TToggleButton(
                  controller: controller.allowverifiedreviewonly,
                  title: 'Allow Verified Review Only',
                ),
                
             
                
              ],
            ),


            if(TDeviceUtils.isDesktopScreen(context) | TDeviceUtils.isTabletScreen(context))
            Row(
              spacing: 10,
              children: [
                TToggleButton(
                  controller: controller.enableproductreview,
                  title: 'Enable Product Review',
                ),
                
                 TToggleButton(
                  controller: controller.allowverifiedreviewonly,
                  title: 'Allow Verified Review only',
                ),
              
                
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
