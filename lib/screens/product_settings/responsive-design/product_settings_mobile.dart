import 'package:admin_panel/screens/product_settings/controller/product_settings_controller.dart';
import 'package:admin_panel/screens/product_settings/widgets/delivery_time_settings.dart';
import 'package:admin_panel/screens/product_settings/widgets/reviews_and_rating.dart';
import 'package:admin_panel/screens/product_settings/widgets/shipping_settings.dart';
import 'package:admin_panel/screens/product_settings/widgets/toggle_button.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ProductSettingsMobile extends StatelessWidget {
  const ProductSettingsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductSettingsController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Product Settings', style: Theme.of(context).textTheme.headlineLarge,),
              const SizedBox(height: TSizes.spaceBetwwenSections,),
              ShippingSettings(),
              const SizedBox(height: TSizes.spaceBetwwenItems,),
              DeliveryTimeSettings(),
              const SizedBox(height: TSizes.spaceBetwwenItems,),

              const SizedBox(height: TSizes.spaceBetweenInputFields),

              TReviewsAndRating()

            ],
          ),
        
          
        ),
      ),
    );
  }
}