import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/formatters/formatters.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:admin_panel/common/widgets/buttons/tab_action_button.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomersRows extends DataTableSource {
  final List<Map<String, dynamic>> customers;

  CustomersRows(this.customers);

  @override
  DataRow? getRow(int index) {
    if (index >= customers.length) return null;

    final customer = customers[index];

    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              const TRoundedImage(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(TSizes.sm),
                imageUrl: TImages.user_icon, // Update if you have customer image
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(width: TSizes.spaceBetwwenItems),
              Expanded(
                child: Text(
                  customer['customerName'] ?? 'Unknown',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),
                ),
              )
            ],
          ),
        ),
        DataCell(Text(customer['customerEmail'] ?? '-')),
        DataCell(Text(customer['customerPhoneNumber'] ?? '-')),
        DataCell(Text(TFormatters.formatDate(DateTime.parse(customer['created_at']?.toString() ?? '')))),
        DataCell(
          TTabActionButton(
            onEditPressed: () => Get.toNamed(TRoutes.editCustomers, arguments: customer['customerID']),
            onDeletePressed: () {
              // delete logic
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => customers.length;

  @override
  int get selectedRowCount => 0;
}
