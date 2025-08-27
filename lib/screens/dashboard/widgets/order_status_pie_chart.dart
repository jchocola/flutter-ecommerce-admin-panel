import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/controllers/dashboard/dashboard_controller.dart';
import 'package:admin_panel/screens/dashboard/dahsboard.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/formatters/enum.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class OrderStatusPieChart extends StatelessWidget {
  const OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
final controller = DashboardController.to; // or Get.find<DashboardController>();

    return TRoundedContainer(
      backgroundColor: dark ? Colors.white.withOpacity(0.05) : Colors.white,
      showBorder: true,
      radius: 5,
      borderColor: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Status',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSizes.spaceBetwwenSections),

            // Wrap PieChart with Obx
            Obx(() {
              if (controller.orderStatusData.isEmpty) {
                return const Center(child: Text('No order data'));
              }
              return SizedBox(
                height: 400,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 5.0,
                    sections: controller.orderStatusData.entries.map((entry) {
                      final status = entry.key;
                      final count = entry.value;

                      return PieChartSectionData(
                        title: count.toString(),
                        radius: 100,
                        value: count.toDouble(),
                        color: THelperFunctions.getOrderStatusColor(status),
                        titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    }).toList(),
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {},
                      enabled: true,
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: TSizes.spaceBetwwenSections),

            // Wrap DataTable with Obx
            Obx(() {
              if (controller.orderStatusData.isEmpty) {
                return const Center(child: Text('No order data'));
              }
              return SizedBox(
                width: double.infinity,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Status'), ),
                 
                    DataColumn(label: Text('Total')),
                       DataColumn(label: Text('Orders'),),
                  ],
                  rows: controller.orderStatusData.entries.map((entry) {
                    final OrderStatus status = entry.key;
                    final int count = entry.value;
                    final totalAmount = controller.totalAmounts[status] ?? 0;

                    return DataRow(
                      cells: [
                        DataCell(
                          SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                TRoundedContainer(
                                  width: 15,
                                  height: 15,
                                  backgroundColor: THelperFunctions.getOrderStatusColor(status),
                                ),
                                const SizedBox(width: 8,),
                                Flexible(child: Text(controller.getDisplayStatusName(status), overflow: TextOverflow.ellipsis, softWrap: true,)),
                              ],
                            ),
                          ),
                        ),
                                                DataCell(Center(child: Text('LKR${totalAmount}'))),

                        DataCell(Text(count.toString())),
                      ],
                    );
                  }).toList(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
