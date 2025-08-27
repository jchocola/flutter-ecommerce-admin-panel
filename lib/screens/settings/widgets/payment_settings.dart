import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/settings/widgets/controller/payment_controller.dart';
import 'package:admin_panel/screens/settings/widgets/payment_added_item.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/constants/validator.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/utils.dart';
import 'package:iconsax/iconsax.dart';

class PaymentSettings extends StatelessWidget {
  PaymentSettings({
    super.key,
    this.onSelected,
    TextEditingController? apiController,
    TextEditingController? credentialController,
    TextEditingController? paymentMethodController,
  }) : apiController = apiController ?? TextEditingController(),
       credentialController = credentialController ?? TextEditingController(),
       paymentMethodController =
           paymentMethodController ?? TextEditingController();

  final TextEditingController apiController;
  final TextEditingController credentialController;
  final TextEditingController paymentMethodController;
  final void Function(String)? onSelected;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(PaymentController());

    return Container(
      width: double.infinity,
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
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Settings',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSizes.spaceBetwwenItems),

            // API Key Field
            SizedBox(
              width: TSizes.buttonWidth * 5,
              child: TextFormField(
                controller: controller.aPIKeyController,
                decoration: InputDecoration(
                  labelText: 'API Key',
                  hintText: 'Enter Your API Key',
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color:
                          dark
                              ? Colors.grey.withOpacity(0.5)
                              : TColors.dark.withOpacity(0.2),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color:
                          dark
                              ? Colors.white.withOpacity(1)
                              : TColors.dark.withOpacity(1),
                    ),
                  ),
                ),
                validator:
                    (value) => TValidator.validateEmptyText('API Key', value),
              ),
            ),
            const SizedBox(height: TSizes.spaceBetweenInputFields),

            // Credential Field
            SizedBox(
              width: TSizes.buttonWidth * 5,
              child: TextFormField(
                controller: controller.merchantIDController,
                decoration: InputDecoration(
                  labelText: 'Credential',
                  hintText: 'Enter Your Credential',
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color:
                          dark
                              ? Colors.grey.withOpacity(0.5)
                              : TColors.dark.withOpacity(0.2),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color:
                          dark
                              ? Colors.white.withOpacity(1)
                              : TColors.dark.withOpacity(1),
                    ),
                  ),
                ),
                validator:
                    (value) =>
                        TValidator.validateEmptyText('Credential', value),
              ),
            ),
            const SizedBox(height: TSizes.spaceBetweenInputFields),

            // Payment Method Dropdown
            Obx(
              () => DropdownButtonFormField<String>(
                value: controller.paymentMethod.value,
                decoration: InputDecoration(
                  labelText: 'Payment Method',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color:
                          dark
                              ? Colors.grey.withOpacity(0.5)
                              : TColors.dark.withOpacity(0.2),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color:
                          dark
                              ? Colors.white.withOpacity(1)
                              : TColors.dark.withOpacity(1),
                    ),
                  ),
                ),
                items:
                    controller.paymentMethods.map((method) {
                      return DropdownMenuItem(
                        value: method,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 20,
                          children: [
                            Image.asset(THelperFunctions.getPaymentMethodIcon(
                                method,
                              ),
                              width: 100,
                              height: 50,),
                            Text(method),
                          ],
                        ),
                      );
                    }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.paymentMethod.value = value;
                    if (onSelected != null) onSelected!(value);
                  }
                },
              ),
            ),

            const SizedBox(height: TSizes.spaceBetwwenItems),
            Text('Note: Most of the payment methods have processing fee. You can set the processing fee on Product Settings Screen.', style: Theme.of(context).textTheme.labelLarge,),
            const SizedBox(height: TSizes.spaceBetwwenItems,),

            Obx(() {
              if (controller.hasAPIChanged.value &&
                  controller.hasMerchantIDChanged.value) {
                return GestureDetector(
                  onTap: () => controller.addNewPaymentMethod(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: TColors.primary,
                      border: Border.all(color: Colors.white.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Add Payment Method',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            }),

            const SizedBox(height: TSizes.spaceBetwwenItems,),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.payments.isEmpty) {
                return const Center(child: Text('No payment methods found.'));
              } else {
                return SizedBox(
                  height: 500,
                  child: ListView.builder(
                    itemCount: controller.payments.length,
                    itemBuilder: (context, index) {
                      final payment = controller.payments[index];
                      return TPaymentAddedItem(
                        apiKey: payment.APIKey!,
                        merchantID: payment.MerchantID!,
                        paymentMethod: payment.PaymentProvider!,
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
