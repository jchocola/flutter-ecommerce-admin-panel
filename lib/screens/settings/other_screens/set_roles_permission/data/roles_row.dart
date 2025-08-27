import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/screens/settings/other_screens/set_roles_permission/roles_controller.dart';
import 'package:admin_panel/util/formatters/formatters.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RolesAndPermissionRow extends DataTableSource {
  final List<Map<String, dynamic>> users;

  RolesAndPermissionRow(this.users);

  final RolesController controller = Get.find();

  @override
  DataRow? getRow(int index) {
    if (index >= users.length) return null;

    final user = users[index];
    final email = user['email'] ?? '';
    final role = controller.selectedRoles[email] ?? controller.roles.first;

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(user['name'] ?? 'User')),
        DataCell(Text(email)),
        DataCell(
          DropdownButton<String>(
            value: role,
            items: controller.roles.map((r) {
              return DropdownMenuItem(
                value: r,
                child: Row(
                  children: [
                    TRoundedContainer(
                      width: 20,
                      height: 20,
                      backgroundColor: THelperFunctions.getRoleColor(r),
                    ),
                    const SizedBox(width: 10),
                    Text(r),
                  ],
                ),
              );
            }).toList(),
            onChanged: (newRole) {
              if (newRole != null) controller.updateUserRole(email, newRole);
            },
            underline: const SizedBox(),
          ),
        ),
        DataCell(
          Text(
            user['created_at'] != null
                ? TFormatters.formatDate(DateTime.tryParse(user['created_at'])!)
                : '',
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;
}
