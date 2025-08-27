import 'package:admin_panel/screens/category/controllers/category_controller.dart';
import 'package:admin_panel/screens/category/controllers/catergory_rows.dart';
import 'package:admin_panel/screens/dashboard/widgets/paginated_table.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/models/category_model.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:admin_panel/screens/dashboard/widgets/paginated_table.dart';
import 'package:lottie/lottie.dart';

class CategoryTable extends StatelessWidget {
  final controller = Get.put(CategoryController());

  CategoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: Lottie.asset(
            TImages.loading_animation,
            width: 500,
            height: 500,
          ),
        );
      }

      final categories =
          controller.filterCategories
              .map((json) => CategoryModel.fromJson(json))
              .toList();

      if (categories.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                TImages.no_data_animation,
                width: 300,
                height: 300,
                repeat: false,
              ),
              Text(
                'No Categories Found..',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        );
      }

      return TPaginatedDataTable(
        minWidth: 700,
        tableHeight: 760,
        dataRowHeight: 64,
        columns: const [
          DataColumn2(label: Text('Name')),
          DataColumn2(label: Text('Parent')),
          DataColumn2(label: Text('Icon')),
          DataColumn2(label: Text('Date')),
          DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: CategoryRows(categories),
      );
    });
  }
}
