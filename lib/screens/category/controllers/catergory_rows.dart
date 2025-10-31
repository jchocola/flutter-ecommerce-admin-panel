import 'dart:convert';

import 'package:admin_panel/common/widgets/buttons/tab_action_button.dart';
import 'package:admin_panel/common/widgets/dialogs/dialogs.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/category/controllers/category_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/models/category_model.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';


class CategoryRows extends DataTableSource {
  final List<CustomCategoryModel> categories;

  CategoryRows(this.categories);

  @override
  DataRow? getRow(int index) {
    if (index >= categories.length) return null;
    final category = categories[index];
   // final supabase = Supabase.instance.client;
//String formattedDate = DateFormat('yyyy-MM-dd').format(category.createdAt!); // 2025-07-04


    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              TRoundedImage(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(TSizes.sm),
                imageUrl: category.imageUrl ?? '',
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground.withOpacity(0.05),
                isNetworkImage: true,
              ),
              const SizedBox(width: TSizes.spaceBetwwenItems),
              Expanded(
                child: Text(
                  category.title ?? '',
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
     DataCell(
  FutureBuilder<String?>(
    future: getTitle(category.title.toString()), // async call
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator(); // loading indicator
      } else if (snapshot.hasError) {
        return const Text('Error');
      } else if (!snapshot.hasData || snapshot.data == null) {
        return const Text('5');
      } else {
        return Text(snapshot.data!); // display the title
      }
    },
  ),
),

        // DataCell(Icon(
        //   Iconsax.icon3,
        //   color:  TColors.primary ,
        // )),
        //DataCell(Text('data')),
        DataCell(
         TTabActionButton(
  onEditPressed: () async {
  final box = GetStorage();
box.write('cached_category', category.toJson());

    final result = await Get.toNamed(TRoutes.editCategory, arguments: category);
    if (result == true) {
      final controller = Get.find<CategoryController>();
      await controller.fetchCategories();  // Refresh categories list immediately
    }
  },
  onDeletePressed: () {
      TDialogs.defaultDialog(
  context: Get.context!,
  title: 'Delete Category',
  confirmText: 'Delete',
  onConfirm: () async {
    await CategoryController.instance.deleteCategory(category.id ?? '');
    // Optionally close the dialog if not closed inside deleteTab
    // Get.back();
  },
  content: 'Do you want to delete Category ${category.title!.toUpperCase()}?',
  // Add transitionBuilder if supported to fix hero tag issue
);
  }, // TODO: Add deletion logic
),

        )
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => categories.length;

  @override
  int get selectedRowCount => 0;
}

Future<String?> getTitle(String tabId) async {
 // final supabase = Supabase.instance.client;

  // final response = await supabase
  //     .from('tab_config')
  //     .select('title')
  //     .eq('id', tabId)
  //     .maybeSingle();

 

  // if (response == null || response == {}) {
  //   print('No data found');
  //   return null;
  // }

  // Access the title inline — since you can't use `.data`
  // print('Title: ${response['title']}');
  // return response['title'];
}

