import 'package:admin_panel/screens/brands/brands/data/brand_rows.dart';
import 'package:admin_panel/screens/customers/all_customers/data/customers_rows.dart';
import 'package:admin_panel/screens/dashboard/widgets/paginated_table.dart';
import 'package:admin_panel/screens/settings/other_screens/set_roles_permission/data/roles_row.dart';
import 'package:admin_panel/screens/settings/other_screens/user_activity_screen/data/user_log_row.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class UserActivityLogTable extends StatelessWidget {
  const UserActivityLogTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 700,
      tableHeight: 760,
      dataRowHeight: 64,
      columns: [
        DataColumn2(
          label: const Text('Email'),
          fixedWidth: TDeviceUtils.isMobileScreen(Get.context!) ? null : 300,
        ),
        const DataColumn2(label: Text('Updated'), fixedWidth: 250),
        DataColumn2(label: const Text('Role'),),
        DataColumn2(label: const Text('Updated At')),
      ],
      source: UserLogRow(),
    );
  }
}