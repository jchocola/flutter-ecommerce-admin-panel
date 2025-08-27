import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/screens/products/create_products/controller/create_product_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/image_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';

class ProductOfferWidgetEdit extends StatefulWidget {
  const ProductOfferWidgetEdit({super.key, this.selectedOffer});

  final String? selectedOffer;

  @override
  State<ProductOfferWidgetEdit> createState() => _ProductOfferWidgetEditState();
}

class _ProductOfferWidgetEditState extends State<ProductOfferWidgetEdit> {
  final controller = Get.find<CreateProductController>();

    @override
  void initState() {
    super.initState();

   controller.selectedOffer.value = widget.selectedOffer;
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      backgroundColor: dark ? Colors.white.withOpacity(0.05) : Colors.white,
      showBorder: true,
      radius: 5
      ,
      borderColor: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Offers', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: TSizes.spaceBetwwenItems),

              RadioListTile<String>(
                title: const Text('New Arrival'),
                value: 'newArrival',
                groupValue: controller.selectedOffer.value,
                onChanged: (value) => controller.selectedOffer.value = value,
              ),

             

              RadioListTile<String>(
                title: const Text('Top Rated'),
                value: 'topRated',
                groupValue: controller.selectedOffer.value,
                onChanged: (value) => controller.selectedOffer.value = value,
              ),

              RadioListTile<String>(
                title: const Text('Free Delivery'),
                value: 'freeDelivery',
                groupValue: controller.selectedOffer.value,
                onChanged: (value) => controller.selectedOffer.value = value,
              ),

              if (controller.selectedOffer.value != null)
                TextButton(
                  onPressed: () => controller.selectedOffer.value = null,
                  child: const Text('Clear Selection'),
                ),
            ],
          )),
    );
  }
}
