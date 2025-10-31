import 'package:admin_panel/controllers/category_controller.dart';
import 'package:admin_panel/main.dart';
import 'package:admin_panel/screens/category/edit_categories/responive_screens/edit_categories_desktop.dart';
import 'package:admin_panel/screens/category/edit_categories/responive_screens/edit_categories_mobile.dart';
import 'package:admin_panel/screens/category/edit_categories/responive_screens/edit_categories_tablet.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';

import 'package:admin_panel/util/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EditCategoriesScreen extends StatelessWidget {
  const EditCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Get.find<CategoryControllerCustom>().editingCategory;
    return TSiteTemplate(
      desktop: EditCategoriesDesktop(category: category.value),
      tablet: EditCategoriesTablet(category: category.value),
      mobile: EditCategoriesMobile(category: category.value),
    );
  }
}
