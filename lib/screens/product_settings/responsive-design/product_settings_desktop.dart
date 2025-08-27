import 'package:admin_panel/screens/product_settings/controller/product_settings_controller.dart';
import 'package:admin_panel/screens/product_settings/widgets/delivery_time_settings.dart';
import 'package:admin_panel/screens/product_settings/widgets/processing_fee_structure.dart';
import 'package:admin_panel/screens/product_settings/widgets/reviews_and_rating.dart';
import 'package:admin_panel/screens/product_settings/widgets/shipping_settings.dart';
import 'package:admin_panel/screens/product_settings/widgets/t_product_payment_processing_fee.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductSettingsDesktop extends StatelessWidget {
  const ProductSettingsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductSettingsController());

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Settings',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: TSizes.spaceBetwwenSections),

                  /// Shipping & Delivery Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: ShippingSettings()),
                      const SizedBox(width: TSizes.spaceBetwwenItems),
                      Expanded(child: DeliveryTimeSettings()),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBetwwenItems),

                  /// Reviews & Payment Fee Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Expanded(
                        flex: 2,
                        child: TProductPaymentProcessingFee(),
                      ),
                      const SizedBox(width: TSizes.spaceBetwwenItems,),
                      Expanded(
                        flex: 2,
                        child: TReviewsAndRating(),
                      ),
                      const SizedBox(width: TSizes.spaceBetwwenItems),
                          Expanded(
                        flex: 1,
                        child: TProcessingFeeStructure()
                      ),
                     
                    ],
                  ),

                  const SizedBox(height: TSizes.spaceBetwwenItems),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
