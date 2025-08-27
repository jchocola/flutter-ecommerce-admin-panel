import 'package:admin_panel/common/widgets/buttons/tab_action_button.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/settings/other_screens/set_roles_permission/roles_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/formatters/formatters.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserLogRow extends DataTableSource {
  final supabase = Supabase.instance.client;

  List<Map<String, dynamic>> logs = [];

  UserLogRow() {
    fetchUserLogs();
  }

  Future<void> fetchUserLogs() async {
    final response = await supabase
        .from('logs')
        .select()
        .order('created_at', ascending: false);

    if (response != null && response is List) {
      logs = List<Map<String, dynamic>>.from(response);
      notifyListeners(); // Refresh the DataTable
    }
  }

  @override
  DataRow? getRow(int index) {
    final controller = Get.put(RolesController());
       if (index >= logs.length) return null;

    final log = logs[index];
    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              Expanded(
                child: Text(
                  log['userEmail'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge!.apply(color: TColors.primary),
                ),
              ),
            ],
          ),
        ),
           DataCell(Text(log['updatedType'])),
    

        DataCell(
          Container(
            decoration: BoxDecoration(
              color: THelperFunctions.getRoleColor(
                log['userRole'],
              ).withOpacity(0.1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                log['userRole'],
                style: TextStyle(
                  color: THelperFunctions.getRoleColor(log['userRole']),
                ),
              ),
            ),
          ),
        ),
    DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: TSizes.sm),
            child: Text(TFormatters.formatDate(DateTime.tryParse(log['created_at'])!)),
          ),
        ),
     
      ],
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => logs.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
