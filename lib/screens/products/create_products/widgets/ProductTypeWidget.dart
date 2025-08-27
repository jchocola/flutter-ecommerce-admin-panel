import 'package:admin_panel/screens/products/create_products/controller/create_product_controller.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/formatters/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;

    return Obx(() => Row(
          children: [
            Text('Product Type', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(width: TSizes.spaceBetwwenItems),

            /// Single Product
            RadioMenuButton<ProductType>(
              value: ProductType.single,
              groupValue: controller.productType.value,
              onChanged: (value) {
                if (controller.productType.value == ProductType.single) {
                  // Already selected
                  print("Single already selected");
                  // Perform any other logic here if needed
                } else {
                  controller.productType.value = value!;
                }
              },
              child: const Text('Single'),
            ),

            /// Variable Product
            RadioMenuButton<ProductType>(
              value: ProductType.variable,
              groupValue: controller.productType.value,
              onChanged: (value) {
                if (controller.productType.value == ProductType.variable) {
                  print("Variable already selected");
                } else {
                  controller.productType.value = value!;
                }
              },
              child: const Text('Variable'),
            ),
          ],
        ));
  }
}
