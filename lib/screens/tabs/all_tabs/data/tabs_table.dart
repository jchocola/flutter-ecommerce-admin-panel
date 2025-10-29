
import 'package:admin_panel/screens/dashboard/widgets/paginated_table.dart';
import 'package:admin_panel/screens/tabs/all_tabs/rows/tabs_rows.dart';
import 'package:admin_panel/screens/tabs/controller/tab_controller.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class TabsTable extends StatelessWidget {
  final List<Map<String, dynamic>> tabs;

  const TabsTable({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    final controller= Get.put(TabsController());
    return TPaginatedDataTable(
      minWidth: 700,
      tableHeight: 760,
      dataRowHeight: 64,
      columns: [
        DataColumn2(label: const Text('Tabs'),),
        DataColumn2(label: const Text('Categories')),
        DataColumn2(label: const Text('Date')),
        DataColumn2(label: const Text('Action'), fixedWidth: 100),
      ],
      source: TabsRows(tabs, ),
    );
  }
}
