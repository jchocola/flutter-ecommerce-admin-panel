import 'package:admin_panel/common/widgets/buttons/tab_action_button.dart';
import 'package:admin_panel/common/widgets/dialogs/dialogs.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/brands/create_brands/controller/brand_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/models/brand_model.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class BrandRows extends DataTableSource {
  final List<BrandModel> brands;
  final void Function(String id) onDelete;
  final void Function(BrandModel brand) onEdit;

  BrandRows({
    required this.brands,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= brands.length) return null;
    final brand = brands[index];

    //final supabase = Supabase.instance.client;

String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(brand.createdAt!)); //
    return DataRow2(cells: [
      /// Brand Image + Name
      DataCell(
        Row(
          children: [
            TRoundedImage(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(TSizes.sm),
              imageUrl: brand.imageUrl!,
              isNetworkImage: true,
              applyImageRadius: true,
              borderRadius: 10,
              backgroundColor: Colors.white.withOpacity(0.05),
            ),
            const SizedBox(width: TSizes.spaceBetwwenItems),
            Expanded(
              child: Text(
                brand.title!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),
              ),
            ),
          ],
        ),
      ),

      /// Category Name
   //  DataCell(
  // FutureBuilder(
  //   future: supabase
  //       .from('tab_categories')
  //       .select('title')
  //       .eq('id', brand.category)
  //       .single(),
  //   builder: (context, snapshot) {
  //     if (snapshot.connectionState == ConnectionState.waiting) {
  //       return Chip(
  //         label: Text('Loading...'),
  //         padding: const EdgeInsets.all(TSizes.xs),
  //       );
  //     } else if (snapshot.hasError) {
  //       return Chip(
  //         label: Text('Error'),
  //         padding: const EdgeInsets.all(TSizes.xs),
  //       );
  //     } else if (snapshot.hasData) {
  //       final data = snapshot.data as Map<String, dynamic>;
  //       return Chip(
  //         label: Text(data['title'] ?? 'Unknown'),
  //         padding: const EdgeInsets.all(TSizes.xs),
  //       );
  //     } else {
  //       return Chip(
  //         label: Text('Unknown'),
  //         padding: const EdgeInsets.all(TSizes.xs),
  //       );
  //     }
  //   },
  // ),
//),


      /// Featured
      DataCell(
        brand.isFeatured!
            ? const Icon(Iconsax.heart5, color: TColors.primary)
            : const Icon(Iconsax.heart, color: Colors.grey),
      ),

      /// Date Created
      DataCell(Text(
        formattedDate, // remove milliseconds
        style: Theme.of(Get.context!).textTheme.bodySmall,
      )),

      /// Actions
      DataCell(
        TTabActionButton(
          onEditPressed: () => Get.toNamed(TRoutes.editBrand, arguments: brand),
          onDeletePressed: () {
             TDialogs.defaultDialog(
                  context: Get.context!,
                  title: 'Delete Tab',
                  confirmText: 'Delete',
                  onConfirm: () async {
                    await BrandController.instance.deleteBrand(brand.id);
                    // Optionally close the dialog if not closed inside deleteTab
                    // Get.back();
                  },
                  content:
                      'Do you want to delete tab ${brand.title.toString().toUpperCase()}?',
                  // Add transitionBuilder if supported to fix hero tag issue
                );
          },
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => brands.length;

  @override
  int get selectedRowCount => 0;
}
