import 'package:admin_panel/common/widgets/images/image_uploader.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/customers/all_customers/controller/customer_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/constants/validator.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:iconsax/iconsax.dart';

class CreateCustomersDesktop extends StatelessWidget {
  const CreateCustomersDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            TCreateCustomerForm(dark: dark),
            const SizedBox(height: TSizes.spaceBetwwenItems),
            TCreateCustomerAddress(dark: dark),
          ],
        ),
      ),
    );
  }
}

class TCreateCustomerAddress extends StatelessWidget {
  const TCreateCustomerAddress({super.key, required this.dark});

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: dark ? Colors.white.withOpacity(0.05) : Colors.white,
              border: Border.all(
                color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shipping Address',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBetwwenItems),
                  Container(
                    width: TSizes.buttonWidth * 3,
                    child: TextFormField(
                      controller: controller.shippingStreetController,
                      decoration: InputDecoration(
                        labelText: 'Street',
                        prefixIcon: Icon(Iconsax.path5),
                        hintText: 'Enter Your Customer Street',
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
                            'Customer Street',
                            value,
                          ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBetwwenItems),
                  Container(
                    width: TSizes.buttonWidth * 3,
                    child: TextFormField(
                      controller: controller.shippingCityController,
                      decoration: InputDecoration(
                        labelText: 'City',
                        prefixIcon: Icon(Iconsax.building),
                        hintText: 'Enter Your Customer City',
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
                            'Customer City',
                            value,
                          ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBetwwenItems),
                  Container(
                    width: TSizes.buttonWidth * 3,
                    child: TextFormField(
                      controller: controller.shippingStateController,
                      decoration: InputDecoration(
                        labelText: 'State',
                        prefixIcon: Icon(Iconsax.status),
                        hintText: 'Enter Your Customer State',
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
                            'Customer State',
                            value,
                          ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBetwwenItems),
                  Container(
                    width: TSizes.buttonWidth * 3,
                    child: TextFormField(
                      controller: controller.shippingCountryController,
                      decoration: InputDecoration(
                        labelText: 'Country',
                        prefixIcon: Icon(Iconsax.direct),
                        hintText: 'Enter Your Customer Country',
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
                            'Customer Country',
                            value,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: TSizes.spaceBetwwenItems),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: dark ? Colors.white.withOpacity(0.05) : Colors.white,
              border: Border.all(
                color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Billing Address',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBetwwenItems),
                  Container(
                    width: TSizes.buttonWidth * 3,
                    child: TextFormField(
                      controller: controller.billingStreetController,
                      decoration: InputDecoration(
                        labelText: 'Street',
                        prefixIcon: Icon(Iconsax.path5),
                        hintText: 'Enter Your Customer Street',
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
                            'Customer Street',
                            value,
                          ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBetwwenItems),
                  Container(
                    width: TSizes.buttonWidth * 3,
                    child: TextFormField(
                      controller: controller.billingCityController,
                      decoration: InputDecoration(
                        labelText: 'City',
                        prefixIcon: Icon(Iconsax.building),
                        hintText: 'Enter Your Customer City',
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
                            'Customer City',
                            value,
                          ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBetwwenItems),
                  Container(
                    width: TSizes.buttonWidth * 3,
                    child: TextFormField(
                      controller: controller.billingStateController,
                      decoration: InputDecoration(
                        labelText: 'State',
                        prefixIcon: Icon(Iconsax.status),
                        hintText: 'Enter Your Customer State',
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
                            'Customer State',
                            value,
                          ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBetwwenItems),
                  Container(
                    width: TSizes.buttonWidth * 3,
                    child: TextFormField(
                      controller: controller.billingCountryController,
                      decoration: InputDecoration(
                        labelText: 'Country',
                        prefixIcon: Icon(Iconsax.direct),
                        hintText: 'Enter Your Customer Country',
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
                            'Customer Country',
                            value,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TCreateCustomerForm extends StatelessWidget {
  const TCreateCustomerForm({super.key, required this.dark});

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
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
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Customers Detail',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBetwwenItems),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TImageUploader(
                        image: TImages.appDarkLogo,
                        width: 60,
                        height: 60,
                      ),
                      const SizedBox(width: TSizes.spaceBetwwenItems),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: TSizes.buttonWidth * 3,
                            child: TextFormField(
                              controller: controller.customerNameController,
                              decoration: InputDecoration(
                                labelText: 'Customer Name',
                                hintText: 'Enter Your Customer Name',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  borderSide: BorderSide(
                                    color:
                                        dark
                                            ? Colors.grey.withOpacity(0.5)
                                            : TColors.dark.withOpacity(0.2),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  borderSide: BorderSide(
                                    color:
                                        dark
                                            ? Colors.white.withOpacity(1)
                                            : TColors.dark.withOpacity(1),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              validator:
                                  (value) => TValidator.validateEmptyText(
                                    'Customer Name',
                                    value,
                                  ),
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBetwwenItems),
                          Container(
                            width: TSizes.buttonWidth * 3,
                            child: TextFormField(
                              controller: controller.customerEmailController,
                              decoration: InputDecoration(
                                labelText: 'Customer Email',
                                hintText: 'Enter Your Customer Email',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  borderSide: BorderSide(
                                    color:
                                        dark
                                            ? Colors.grey.withOpacity(0.5)
                                            : TColors.dark.withOpacity(0.2),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  borderSide: BorderSide(
                                    color:
                                        dark
                                            ? Colors.white.withOpacity(1)
                                            : TColors.dark.withOpacity(1),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              validator:
                                  (value) => TValidator.validateEmptyText(
                                    'Customer Email',
                                    value,
                                  ),
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBetwwenItems),
                          Container(
                            width: TSizes.buttonWidth * 3,
                            child: TextFormField(
                              controller:
                                  controller.customerPhoneNumberController,
                              decoration: InputDecoration(
                                labelText: 'Customer Phone Number',
                                hintText: 'Enter Your Customer Phone Number',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  borderSide: BorderSide(
                                    color:
                                        dark
                                            ? Colors.grey.withOpacity(0.5)
                                            : TColors.dark.withOpacity(0.2),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  borderSide: BorderSide(
                                    color:
                                        dark
                                            ? Colors.white.withOpacity(1)
                                            : TColors.dark.withOpacity(1),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              validator:
                                  (value) => TValidator.validateEmptyText(
                                    'Customer Phone Number',
                                    value,
                                  ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                          Obx(() {
                            if (controller.hasCustomerNameChanged.value &&
                                controller.hasCustomerEmailChanged.value &&
                                controller.hasPhoneNumberChanged.value) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: TSizes.spaceBetwwenItems,
                                  ),
                                  GestureDetector(
                                    onTap: () => controller.checkAndCreateCustomer(),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: TColors.primary,
                                        border: Border.all(
                                          color:
                                              dark
                                                  ? Colors.grey.withOpacity(0.5)
                                                  : TColors.dark.withOpacity(
                                                    0.2,
                                                  ),
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          'Create Customer',
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.titleMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
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
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
