import 'package:admin_panel/common/widgets/heading/section_heading.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/dashboard/controller/monthly_stats_controller.dart';
import 'package:admin_panel/screens/orders/edit_orders/controller/order_controller.dart';
import 'package:admin_panel/screens/orders/edit_orders/widgets/t_product_item_list.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/formatters/enum.dart';
import 'package:admin_panel/util/formatters/formatters.dart';
import 'package:admin_panel/util/formatters/product_pdf_creator.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/models/customer_model.dart';
import 'package:admin_panel/util/models/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

class EditOrdersDesktop extends StatefulWidget {
  EditOrdersDesktop({super.key, required this.orders});

  final Map<String, dynamic> orders;

  @override
  State<EditOrdersDesktop> createState() => _EditOrdersDesktopState();
}

class _EditOrdersDesktopState extends State<EditOrdersDesktop> {
  final OrderController controller = Get.put(OrderController());

  @override
  void initState() {
    super.initState();

    /// Safely access the arguments
    final args = Get.arguments;
    if (args != null && args['orderID'] != null) {
      if (widget.orders['orderID'] != null) {
        controller.fetchShippingAddress(widget.orders['orderID']);
      }
    } else if (widget.orders['orderID'] != null) {
      if (widget.orders['orderID'] != null) {
        controller.fetchShippingAddress(widget.orders['orderID']);
        controller.fetchUserByID(widget.orders['userID']);
      }
    } else {
      /// Optionally navigate back or show an error
      Future.delayed(Duration.zero, () {
        Get.snackbar('Error', 'Order not found. Redirecting to home.');
        Get.offAllNamed('/home');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(
      context,
    ); // Replace with theme check if needed
    final List<Map<String, dynamic>> orderedItems =
        (widget.orders['products'] as List?)
            ?.map((e) => Map<String, dynamic>.from(e))
            .toList() ??
        [];

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TSectionHeading(title: widget.orders['orderID'] ?? ''),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// LEFT SIDE
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Header Row
                        ///
                        const SizedBox(height: TSizes.spaceBetwwenItems),
                        TOrderSummaryStats(dark: dark, orders: widget.orders),
                        const SizedBox(height: 10),

                        /// Items List Container
                        TOrderItemList(
                          dark: dark,
                          controller: controller,
                          orders: widget.orders,
                        ),

                        const SizedBox(height: TSizes.spaceBetwwenItems),
                        TTransactionMethod(dark: dark, orders: widget.orders),
                      ],
                    ),
                  ),

                  const SizedBox(width: TSizes.spaceBetwwenItems),

                  /// RIGHT SIDE (Static)
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color:
                                dark
                                    ? Colors.white.withOpacity(0.05)
                                    : Colors.white,
                            border: Border.all(
                              color:
                                  dark
                                      ? Colors.grey.withOpacity(0.5)
                                      : TColors.dark.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder<CustomerModel?>(
                                  future: controller.fetchUserByID(
                                    widget.orders['userID'],
                                  ),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (!snapshot.hasData ||
                                        snapshot.data == null) {
                                      return Text('No user found');
                                    } else {
                                      final customer = snapshot.data!;
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Customer'),
                                          const SizedBox(
                                            height: TSizes.spaceBetwwenItems,
                                          ),

                                          Row(
                                            children: [
                                              TRoundedImage(
                                                imageUrl: TImages.appDarkLogo,
                                                width: 60,
                                                height: 60,
                                              ),
                                              const SizedBox(width: TSizes.sm),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Name : ${customer.customerName}',
                                                  ),
                                                  Text(
                                                    'Email : ${customer.customerEmail}',
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBetwwenItems),

                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:
                                dark
                                    ? Colors.white.withOpacity(0.05)
                                    : Colors.white,
                            border: Border.all(
                              color:
                                  dark
                                      ? Colors.grey.withOpacity(0.5)
                                      : TColors.dark.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder<CustomerModel?>(
                                  future: controller.fetchUserByID(
                                    widget.orders['userID'],
                                  ),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (!snapshot.hasData ||
                                        snapshot.data == null) {
                                      return Text('No user found');
                                    } else {
                                      final customer = snapshot.data!;
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Contact Info'),
                                          const SizedBox(
                                            height: TSizes.spaceBetwwenItems,
                                          ),

                                          Text(
                                            'Phone Number : ${customer.customerPhoneNumber}',
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBetwwenItems),

                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:
                                dark
                                    ? Colors.white.withOpacity(0.05)
                                    : Colors.white,
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
                            child: Obx(() {
                              final address =
                                  controller.shippingAddressList.isNotEmpty
                                      ? controller.shippingAddressList.first
                                      : {};

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Shipping Address',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 8),

                                  Text('Street: ${address['street'] ?? '-'}'),
                                  Text('State: ${address['state'] ?? '-'}'),
                                  Text('Country: ${address['country'] ?? '-'}'),
                                ],
                              );
                            }),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:
                                dark
                                    ? Colors.white.withOpacity(0.05)
                                    : Colors.white,
                            border: Border.all(
                              color:
                                  dark
                                      ? Colors.grey.withOpacity(0.5)
                                      : TColors.dark.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Billing Address'),
                                const SizedBox(
                                  height: TSizes.spaceBetwwenItems,
                                ),

                                Text('Street'),
                                Text('State'),
                                Text('Country'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBetwwenItems),
                        FutureBuilder<CustomerModel?>(
                          future: controller.fetchUserByID(
                            widget.orders['userID'],
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data == null) {
                              return Text('No user found');
                            } else {
                              final customer = snapshot.data!;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      final address =
                                          controller
                                                  .shippingAddressList
                                                  .isNotEmpty
                                              ? controller
                                                  .shippingAddressList
                                                  .first
                                              : {};
                                      previewAndPrintLabel(
                                        orderedItems,
                                        widget.orders['orderID'],
                                        customer.customerName!,
                                        customer.customerPhoneNumber!,
                                        "${address['street']} ${address['state']} ${address['country']}",
                                        widget.orders,
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            dark
                                                ? Colors.white.withOpacity(0.05)
                                                : Colors.white,
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
                                        child: const Text('Get Label'),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard(bool dark, String title) {
    return Container(
      decoration: BoxDecoration(
        color: dark ? Colors.white.withOpacity(0.05) : Colors.white,
        border: Border.all(
          color:
              dark
                  ? Colors.grey.withOpacity(0.5)
                  : Colors.black12.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(height: 10),
          Row(
            children: [
              Image.network(
                "data:image/png;base64,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",
                width: 60,
                height: 60,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [Text('Customer Name'), Text('Customer Email')],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TTransactionMethod extends StatelessWidget {
  const TTransactionMethod({
    super.key,
    required this.dark,
    required this.orders,
  });

  final bool dark;

  final Map<String, dynamic> orders;

  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transaction Method',
              style: Theme.of(context).textTheme.titleSmall,
            ),

            const SizedBox(height: TSizes.spaceBetwwenItems),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TRoundedImage(
                  imageUrl: TImages.appDarkLogo,
                  width: 60,
                  height: 60,
                ),

                Text(
                  '${orders['paymentMethod'] ?? 'Unknown'}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                Text(
                  'Total Amount',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TOrderItemList extends StatefulWidget {
  const TOrderItemList({
    super.key,
    required this.dark,
    required this.controller,
    required this.orders,
  });

  final bool dark;
  final OrderController controller;
  final Map<String, dynamic> orders;
  @override
  State<TOrderItemList> createState() => _TOrderItemListState();
}

class _TOrderItemListState extends State<TOrderItemList> {
  @override
  void initState() {
    super.initState();

    final orderID = widget.orders['orderID'];

    if (orderID != null) {
      widget.controller.fetchOrderProducts(orderID);
    } else {
      print('⚠️ Order ID is null, cannot fetch products.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.dark ? Colors.white.withOpacity(0.05) : Colors.white,
        border: Border.all(
          color:
              widget.dark
                  ? Colors.grey.withOpacity(0.5)
                  : Colors.black12.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Items'),
          const SizedBox(height: 10),

          /// Product List from Controller
          SizedBox(
            height: 400,
            child: Obx(() {
              return ListView.builder(
                itemCount: widget.controller.orderItems.length,
                itemBuilder: (context, index) {
                  final item = widget.controller.orderItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TProductItemList(
                      name: item['title'] ?? 'Unknown',
                      price: (item['price'] ?? 0).toString(),
                      qty: (item['quantity'] ?? 0).toString(),
                      total: ((item['price'] ?? 0) * (item['quantity'] ?? 0))
                          .toStringAsFixed(2),
                      imageUrl: item['image'] ?? '',
                      currency: item['currencySymbol'] ?? '',
                    ),
                  );
                },
              );
            }),
          ),

          TOrderBillAmount(dark: widget.dark, orders: widget.orders),
        ],
      ),
    );
  }
}

class TOrderBillAmount extends StatelessWidget {
  const TOrderBillAmount({super.key, required this.dark, required this.orders});

  final bool dark;
  final Map<String, dynamic> orders;

  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sub total'),
                Text('${orders['currencySymbol']} ${orders['subTotal']}'),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shipping Fee'),
                Text('${orders['currencySymbol']} ${orders['shippingCost']}'),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total'),
                Text('${orders['currencySymbol']} ${orders['totalPrice']}'),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('paid'), Text('paid amount')],
            ),
          ],
        ),
      ),
    );
  }
}

class TOrderSummaryStats extends StatefulWidget {
  const TOrderSummaryStats({
    super.key,
    required this.dark,
    required this.orders,
  });

  final bool dark;
  final Map<String, dynamic> orders;

  @override
  State<TOrderSummaryStats> createState() => _TOrderSummaryStatsState();
}

class _TOrderSummaryStatsState extends State<TOrderSummaryStats> {
  late String orderStatus;
  late OrderStatus selectedStatus;

  final controller = Get.put(OrderController());
  final currencyController = Get.put(MonthlyStatsController());

  final RxString currencySymbol = ''.obs;

  @override
  void initState() {
    super.initState();

    // ✅ Ensure orderStatus is assigned before conversion
    orderStatus = widget.orders['orderStatus'] ?? 'pending';

    // ✅ Validate orderStatus before parsing to enum
    if (!OrderStatus.values.map((e) => e.name).contains(orderStatus)) {
      orderStatus = 'pending';
    }

    selectedStatus = orderStatusFromString(orderStatus);

    currencyController.getAppCurrencySymbol().then((value) {
      currencySymbol.value = value;
    });
  }

  void updateStatus(String newStatus) {
    setState(() {
      orderStatus = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = THelperFunctions.getOrderStatusColorByModel(orderStatus);

    return Container(
      decoration: BoxDecoration(
        color: widget.dark ? Colors.white.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: widget.dark
              ? Colors.grey.withOpacity(0.5)
              : Colors.black.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Date
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Date'),
                Text(
                  TFormatters.formatDate(
                    DateTime.parse(widget.orders['orderDate']),
                  ),
                ),
              ],
            ),

            /// Total Items (You may want to fix this later)
            Column(
              children:  [
                Text('Total Item'),
Text('${(widget.orders['products'] as List).length} items'),
              ],
            ),

            /// Status Dropdown
            Container(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Status'),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: color.withOpacity(1),
                              ),
                            ),
                            child: DropdownButtonFormField<String>(
                              value: selectedStatus.name,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              items: OrderStatus.values.map((status) {
                                final statusColor =
                                    THelperFunctions.getOrderStatusColor(
                                        status);
                                return DropdownMenuItem<String>(
                                  value: status.name,
                                  child: Text(
                                    StringExtension(status.name).capitalize(),
                                    style: TextStyle(color: statusColor),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  final newStatus =
                                      orderStatusFromString(value);
                                  setState(() {
                                    selectedStatus = newStatus;
                                    updateStatus(value);
                                    controller.updateOrder(
                                      widget.orders['orderID'],
                                      value,
                                    );
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Total Amount
            Obx(
              () => Column(
                children: [
                  const Text('Total Amount'),
                  Text(
                    '${currencySymbol.value} ${widget.orders['totalPrice'].toString()}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Optional: extension to capitalize enum names for display
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

void previewAndPrintLabel(
  List<Map<String, dynamic>> orderedItems,
  String orderID,
  String name,
  String phoneNumber,
  String address,
   Map<String, dynamic> orders,
) async {
  final pdfData = await ProductPdfCreator.generateParcelPdf(
    phoneNumber: phoneNumber,
    name: name,
    orders: orders,
    address: address,
    billingInfo: "Total: \$199.99",
    reviewUrl: orderID,
    orderedItems: orderedItems,
  );

  await Printing.layoutPdf(onLayout: (format) => pdfData);
}
