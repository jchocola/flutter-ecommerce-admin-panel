
import 'package:admin_panel/screens/customers/all_customers/data/customers_rows.dart';
import 'package:admin_panel/screens/dashboard/widgets/paginated_table.dart';
import 'package:admin_panel/screens/orders/all_orders/data/order_row.dart';
import 'package:admin_panel/screens/orders/all_orders/responsive_design/controller/order_controller.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
class OrderTable extends StatelessWidget {
  const OrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderControllerSearch>();

    return Obx(() {
      // Show a loader if loading
      if (controller.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      // Show empty state if no data
      if (controller.filterOrders.isEmpty) {
        return const Center(child: Text('No orders found.'));
      }

      return TPaginatedDataTable(
        minWidth: 700,
        tableHeight: 760,
        dataRowHeight: 64,
        columns: [
          DataColumn2(
            label: const Text('Orders No'),
            fixedWidth: TDeviceUtils.isMobileScreen(Get.context!) ? null : 200,
          ),
          const DataColumn2(label: Text('Total')),
          DataColumn2(label: const Text('Status')),
          DataColumn2(label: const Text('Date')),
          DataColumn2(
              label: const Text('Action'),
              fixedWidth: TDeviceUtils.isMobileScreen(Get.context!) ? null : 100),
        ],
        source: OrderRow(), // your data source that uses controller.filterOrders
      );
    });
  }
}
