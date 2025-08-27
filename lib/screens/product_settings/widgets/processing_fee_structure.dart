import 'package:admin_panel/screens/product_settings/controller/product_settings_controller.dart';
import 'package:admin_panel/screens/product_settings/widgets/toggle_button.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TProcessingFeeStructure extends StatefulWidget {
  const TProcessingFeeStructure({super.key});

  @override
  State<TProcessingFeeStructure> createState() =>
      _TProcessingFeeStructureState();
}

class _TProcessingFeeStructureState extends State<TProcessingFeeStructure> {
  final controller = Get.put(ProductSettingsController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: dark ? Colors.white.withOpacity(0.05) : Colors.white,
        border: Border.all(
          color:
              dark
                  ? Colors.grey.withOpacity(0.5)
                  : TColors.dark.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(TSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Processing Fee Structure',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSizes.spaceBetwwenItems),

            Obx(() {
              return Column(
                spacing: 10,
                children: [
                  RadioListTile<String>(
                    title: const Text('Include in Product'),
                    value: 'include',
                    groupValue: controller.selectedFeeStructure.value,
                    onChanged: (value) {
                      controller.selectedFeeStructure.value = value;
                      controller.updateProcessingFeeStructure(value!);
                    },
                  ),

                  RadioListTile<String>(
                    title: const Text('Exculude in Product'),
                    value: 'exclude',
                    groupValue: controller.selectedFeeStructure.value,
                    onChanged: (value) {
                      controller.selectedFeeStructure.value = value;
                      controller.updateProcessingFeeStructure(value!);
                    },
                  ),
                ],
              );
            }),
            Text(
              "Note: Processing fee will be applied on total amount in cart",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
