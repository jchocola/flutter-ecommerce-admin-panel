import 'package:admin_panel/screens/products/create_products/controller/create_product_controller.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/formatters/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductTypeWidgetEdit extends StatefulWidget {
  const ProductTypeWidgetEdit({super.key, this.type});

  final String? type;

  @override
  State<ProductTypeWidgetEdit> createState() => _ProductTypeWidgetEditState();
}

class _ProductTypeWidgetEditState extends State<ProductTypeWidgetEdit> {
  late TextEditingController productTypeController;
  final productType = ProductType.single.obs;

      @override
  void initState() {
    super.initState();
    productTypeController = TextEditingController(text: widget.type);
  }

  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;

    if(widget.type == 'ProductType.single') {
      controller.productType.value = ProductType.single;
    } else {
      controller.productType.value = ProductType.variable;
    }

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
