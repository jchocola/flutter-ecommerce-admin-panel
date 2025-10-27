import 'package:admin_panel/common/widgets/buttons/tab_action_button.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/orders/edit_orders/responsive_design/edit_order_desktop.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/formatters/enum.dart';
import 'package:admin_panel/util/formatters/formatters.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:iconsax/iconsax.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';

class OrderRows extends DataTableSource {
  List<Map<String, dynamic>> orders = [];

  bool _loading = false;

  OrderRows() {
    fetchOrders();
  } 

 Future<void> fetchOrders() async {
  _loading = true;
  notifyListeners();

 // final supabase = Supabase.instance.client;
  //final response = await supabase.from('orders').select();

  // response here is dynamic — usually a List<Map<String, dynamic>>
  // if (response != null) {
  //   // If response is a list, assign it directly
  //   orders = List<Map<String, dynamic>>.from(response);
  // } else {
  //   orders = [];
  // }

  _loading = false;
  notifyListeners();
}


  @override
  DataRow? getRow(int index) {
    if (_loading) {
      // Optionally, show loading row or empty row
      return DataRow(cells: [
        DataCell(Text('Loading...')),
        DataCell.empty,
        DataCell.empty,
        DataCell.empty,
        DataCell.empty,
        DataCell.empty,
      ]);
    }

    if (index >= orders.length) return null;


    final order = orders[index];
    final status = order['orderStatus'] ?? 'Placed'; // Adjust according to your table schema
    
    final orderDate = order['orderDate'] != null
        ? DateTime.parse(order['orderDate'])
        : DateTime.now();

    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              // You can replace this with actual image url if available in order
           
              Expanded(
                child: Text(
                  order['orderID'] ?? 'Unknown',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: TSizes.sm),
            child: Text('LKR  ${order['totalPrice'].toString() ?? ''}'),
          ),
        ),
        DataCell(
          
          Container(
            decoration: BoxDecoration(
              color: THelperFunctions.getOrderStatusColorByModel(status).withOpacity(0.1),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(status.toString().toUpperCase(), style: TextStyle(color: THelperFunctions.getOrderStatusColorByModel(status)),),
            ),
          ),
        ),
        DataCell(Text(TFormatters.formatDate(orderDate))),
       
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => orders.length;

  @override
  int get selectedRowCount => 0;
}
