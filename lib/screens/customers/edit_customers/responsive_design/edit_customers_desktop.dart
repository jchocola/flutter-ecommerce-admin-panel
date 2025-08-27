import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/customers/all_customers/controller/customer_controller.dart';
import 'package:admin_panel/screens/customers/edit_customers/responsive_design/widgets/shipping_address.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/models/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditCustomersDesktop extends StatefulWidget {
  const EditCustomersDesktop({super.key});

  @override
  State<EditCustomersDesktop> createState() => _EditCustomersDesktopState();
}

class _EditCustomersDesktopState extends State<EditCustomersDesktop> {
  final controller = CustomerController.instance;
  CustomerModel? customer;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final customerId = Get.arguments; // Argument passed via navigation
    fetchCustomer(customerId);
  }

  Future<void> fetchCustomer(String customerId) async {
    final fetchedCustomer = await controller.getCustomerById(customerId);
    setState(() {
      customer = fetchedCustomer;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (customer == null) {
      return const Center(child: Text('Customer not found'));
    }

    final shipping =
        customer!.shippingAddress?.isNotEmpty == true
            ? customer!.shippingAddress!.first
            : null;
    final billing =
        customer!.billingAddress?.isNotEmpty == true
            ? customer!.billingAddress!.first
            : null;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer Details',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: TSizes.spaceBetwwenItems),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Customer Info
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          dark ? Colors.white.withOpacity(0.05) : Colors.white,
                      border: Border.all(
                        color:
                            dark
                                ? Colors.grey.withOpacity(0.5)
                                : TColors.dark.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Customer Detail',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: TSizes.spaceBetwwenItems),

                          Row(
                            children: [
                              TRoundedImage(
                                imageUrl: TImages.appDarkLogo,
                                width: 60,
                                height: 60,
                              ),
                              const SizedBox(width: TSizes.spaceBetwwenItems),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(customer!.customerName ?? 'No Name'),
                                  const SizedBox(height: TSizes.sm),
                                  Text(customer!.customerEmail ?? 'No Email'),
                                  const SizedBox(height: TSizes.sm),
                                  Text(
                                    customer!.customerPhoneNumber ?? 'No Phone',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: TSizes.spaceBetwwenItems),

                          // Shipping Address
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: TSizes.spaceBetwwenItems),

                // Order Stats
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          dark ? Colors.white.withOpacity(0.05) : Colors.white,
                      border: Border.all(
                        color:
                            dark
                                ? Colors.grey.withOpacity(0.5)
                                : TColors.dark.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Orders',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: TSizes.spaceBetwwenSections),
                          Text('Total Orders: ${customer!.totalOrder ?? '0'}'),
                          const SizedBox(height: TSizes.spaceBetwwenItems),
                          Text(
                            'Pending Orders: ${customer!.currentOrders ?? '0'}',
                          ),
                          const SizedBox(height: TSizes.spaceBetwwenItems),
                          Text('Total Spent: ${customer!.totalSpent ?? '0.0'}'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                if (shipping != null) ...[
                  ShippingAddressWdiget(
                    street: shipping!.street.toString(),
                    city: shipping!.city.toString(),
                    state: shipping!.state.toString(),
                    country: shipping!.country.toString(),
                    title: 'Shipping Address',
                    model: shipping,
                  ),
                ],



                  if(billing != null) ...[
                    ShippingAddressWdiget(
                    street: billing!.street.toString(),
                    city: billing!.city.toString(),
                    state: billing!.state.toString(),
                    country: billing!.country.toString(),
                    title: 'Billing Address',
                    model: billing,
                  ),
                  ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}
