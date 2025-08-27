import 'package:admin_panel/screens/product_settings/controller/product_settings_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TToggleButton extends StatefulWidget {
  const TToggleButton({
    super.key,
    required this.title,
    required this.controller,
  });

  final String title;
  final RxBool controller;

  @override
  State<TToggleButton> createState() => _TToggleButtonState();
}

class _TToggleButtonState extends State<TToggleButton> {
  final productController = Get.put(ProductSettingsController());

  @override
  void initState() {
    super.initState();
    // Fetch toggle state from Supabase on init
    productController.checkToggleButtons(widget.title).then((value) {
      widget.controller.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: dark ? Colors.white.withOpacity(0.05) : Colors.white,
        border: Border.all(
          color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(TSizes.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),

            Obx(() {
              return ToggleButtons(
                borderRadius: BorderRadius.circular(8),
                selectedColor: Colors.white,
                fillColor: TColors.primary,
                isSelected: [
                  !widget.controller.value, // OFF
                  widget.controller.value,  // ON
                ],
                onPressed: (index) {
                  final newValue = index == 1;
                  widget.controller.value = newValue;

                  productController.updateToggleSetting(
                    widget.title,
                    newValue.toString(), // 'true' or 'false'
                  );

                  print('${widget.title} is ${newValue ? "ON" : "OFF"}');
                },
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text('OFF'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text('ON'),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
