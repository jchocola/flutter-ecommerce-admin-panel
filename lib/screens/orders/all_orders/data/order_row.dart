import 'dart:convert';

import 'package:admin_panel/common/widgets/buttons/tab_action_button.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/formatters/formatters.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_panel/screens/orders/all_orders/responsive_design/controller/order_controller.dart'; // Correct import
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRow extends DataTableSource {
  final OrderControllerSearch controller = Get.find();

  OrderRow();

  @override
  DataRow? getRow(int index) {
    if (controller.isLoading) {
      return DataRow(
        cells: List.generate(5, (index) => const DataCell(Text('Loading...'))),
      );
    }

    if (index >= controller.filterOrders.length) return null;

    final order = controller.filterOrders[index];
    final status = order.orderStatus ?? 'Placed';
    final orderDate = order.orderDate ?? DateTime.now();

    return DataRow2(
      cells: [
        DataCell(
          Text(
            order.orderID ?? 'Unknown',
            style: TextStyle(color: TColors.primary),
          ),
        ),
        DataCell(Text('LKR ${order.totalPrice?.toStringAsFixed(2) ?? '0.00'}')),
        DataCell(
          Container(
            decoration: BoxDecoration(
              color: THelperFunctions.getOrderStatusColorByModel(
                status,
              ).withOpacity(0.1),
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.all(8),
            child: Text(
              status.toUpperCase(),
              style: TextStyle(
                color: THelperFunctions.getOrderStatusColorByModel(status),
              ),
            ),
          ),
        ),
        DataCell(Text(TFormatters.formatDate(orderDate))),
        DataCell(
          TTabActionButton(
            onEditPressed: () async {
              final box = GetStorage();
              await box.write('cached_order', order.toJson());
              Get.toNamed(TRoutes.editOrders, arguments: order.toJson());
            },
            delete: false,
            onDeletePressed: () {
              // implement if needed
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filterOrders.length;

  @override
  int get selectedRowCount => 0;
}
