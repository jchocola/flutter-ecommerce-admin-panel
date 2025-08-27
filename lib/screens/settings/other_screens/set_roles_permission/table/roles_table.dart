import 'package:admin_panel/screens/dashboard/widgets/paginated_table.dart';
import 'package:admin_panel/screens/settings/other_screens/set_roles_permission/data/roles_row.dart';
import 'package:admin_panel/screens/settings/other_screens/set_roles_permission/roles_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:data_table_2/data_table_2.dart';


class RolesAndPermisionTable extends StatelessWidget {
  const RolesAndPermisionTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RolesController());

    if (controller.users.isEmpty) {
      controller.fetchUsers();
    }

    return Obx(() {
      return TPaginatedDataTable(
        minWidth: 700,
        tableHeight: 760,
        dataRowHeight: 64,
        columns: [
          DataColumn2(
            label: const Text('Users'),
            fixedWidth: Get.width < 600 ? null : 200,
          ),
          const DataColumn2(label: Text('Email')),
          const DataColumn2(label: Text('Role'), fixedWidth: 400),
          const DataColumn2(label: Text('Registered')),
        ],
        source: RolesAndPermissionRow(controller.users.toList()), // pass data
      );
    });
  }
}
