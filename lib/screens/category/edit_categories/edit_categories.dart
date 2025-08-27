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
    final box = GetStorage();
final args = Get.arguments ?? box.read('cached_category');

if (args == null) {
  return Scaffold(
    body: Center(child: Text('❌ No category data found.')),
  );
}


    CategoryModel? category;

    if (args is Map<String, dynamic>) {
      try {
        category = CategoryModel.fromJson(args);
      } catch (e) {
        return Scaffold(
          body: Center(child: Text('❌ Invalid category data format.')),
        );
      }
    } else if (args is CategoryModel) {
      category = args;
    } else {
      return Scaffold(
        body: Center(child: Text('❌ Invalid argument type received.')),
      );
    }

    if (category == null) {
      return Scaffold(
        body: Center(child: Text('❌ Category data could not be parsed.')),
      );
    }

    return TSiteTemplate(
      desktop: EditCategoriesDesktop(category: category),
      tablet: EditCategoriesTablet(category: category),
      mobile: EditCategoriesMobile(category: category),
    );
  }
}
