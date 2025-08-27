import 'package:admin_panel/common/widgets/buttons/tab_action_button.dart';
import 'package:admin_panel/common/widgets/dialogs/dialogs.dart';
import 'package:admin_panel/screens/tabs/controller/tab_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class TabsRows extends DataTableSource {
  final List<Map<String, dynamic>> tabs;

  TabsRows(this.tabs);

  @override
  DataRow? getRow(int index) {
    if (index >= tabs.length) return null;

    final tab = tabs[index];
    final title = tab['title'] ?? 'No Title';
    final categories = tab['categories'] ?? <String>[];
    final createdAt = tab['created_at'] ?? DateTime.now().toString();
    DateTime date = DateTime.parse(tab['created_at'] ?? createdAt);
    String formattedDate = DateFormat('yyyy-MM-dd').format(date); // 2025-07-04
    return DataRow2(
      cells: [
        DataCell(
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              Get.context!,
            ).textTheme.bodyLarge!.apply(color: TColors.primary),
          ),
        ),
        DataCell(
          SizedBox(
            height: 50, // Fixed height to avoid RenderFlex unbounded errors
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: TSizes.xs,
                direction:
                    TDeviceUtils.isMobileScreen(Get.context!)
                        ? Axis.vertical
                        : Axis.horizontal,
                children:
                    categories.map<Widget>((cat) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom:
                              TDeviceUtils.isMobileScreen(Get.context!)
                                  ? 0
                                  : TSizes.xs,
                        ),
                        child: Chip(
                          label: Text(cat),
                          padding: const EdgeInsets.all(TSizes.xs),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        ),
        DataCell(Text(formattedDate)),
        DataCell(
          TTabActionButton(
            onEditPressed:
                () => Get.toNamed(
                  TRoutes.editTabs,
                  arguments: {
                    'tabId': tab['id'],
                    'tabTitle': tab['title'],
                    'someOtherData': 123,
                  },
                ),
            onDeletePressed:
                () => TDialogs.defaultDialog(
                  context: Get.context!,
                  title: 'Delete Tab',
                  confirmText: 'Delete',
                  onConfirm: () async {
                    await TabsController.instance.deleteTab(tab['id']);
                    // Optionally close the dialog if not closed inside deleteTab
                    // Get.back();
                  },
                  content:
                      'Do you want to delete tab ${title.toString().toUpperCase()}?',
                  // Add transitionBuilder if supported to fix hero tag issue
                ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => tabs.length;

  @override
  int get selectedRowCount => 0;
}
