import 'package:admin_panel/screens/product_settings/controller/product_settings_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/constants/validator.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DeliveryTimeSettings extends StatefulWidget {
  const DeliveryTimeSettings({super.key});

  @override
  State<DeliveryTimeSettings> createState() => _DeliveryTimeSettingsState();
}

class _DeliveryTimeSettingsState extends State<DeliveryTimeSettings> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductSettingsController());
    final dark = THelperFunctions.isDarkMode(context);
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
            Text('Delivery', style: Theme.of(context).textTheme.headlineSmall),

            const SizedBox(height: TSizes.spaceBetwwenSections),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery Time',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: TSizes.spaceBetwwenItems),
                Container(
                  width: TSizes.buttonWidth * 2.7,
                  child: TextFormField(
                    controller: controller.deliveryInDistrictController,
                    decoration: InputDecoration(
                      labelText: 'In District',
                      hintText: 'Enter Your number of days',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color:
                              dark
                                  ? Colors.grey.withOpacity(0.5)
                                  : TColors.dark.withOpacity(0.2),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color:
                              dark
                                  ? Colors.white.withOpacity(1)
                                  : TColors.dark.withOpacity(1),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator:
                        (value) => TValidator.validateEmptyText(
                          'Number of Days',
                          value,
                        ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.spaceBetwwenItems),
                Container(
                  width: TSizes.buttonWidth * 2.7,
                  child: TextFormField(
                    controller: controller.deliveryOutOfDistrictController,
                    decoration: InputDecoration(
                      labelText: 'In Province / Out of District',
                      hintText: 'Enter Your number of days',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color:
                              dark
                                  ? Colors.grey.withOpacity(0.5)
                                  : TColors.dark.withOpacity(0.2),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color:
                              dark
                                  ? Colors.white.withOpacity(1)
                                  : TColors.dark.withOpacity(1),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator:
                        (value) => TValidator.validateEmptyText(
                          'Number of Days',
                          value,
                        ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                   Obx(() {
                  if (controller.hasDeliveryChanged.value) {
                    return Column(
                      children: [
                        const SizedBox(height: TSizes.spaceBetwwenItems,),
                        Row(
                          children: [
                        
                            //Discard Button
                            GestureDetector(
                              onTap: () => controller.discardChangesDelivery(controller.deliveryInDistrictController.text, controller.deliveryOutOfDistrictController.text),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.1),
                                  border: Border.all(color: Colors.redAccent),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('Discard' , style: TextStyle(color: Colors.red),),
                                ),
                              ),
                            ),
                            const SizedBox(width: TSizes.spaceBetwwenItems,),
                               //Save Button
                            GestureDetector(
                              onTap: () => controller.updateDeliverySettings(controller.deliveryInDistrictController.text, controller.deliveryOutOfDistrictController.text),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: TColors.primary,
                                  
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('Save' , style: TextStyle(color: Colors.white),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  return SizedBox.shrink();
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
