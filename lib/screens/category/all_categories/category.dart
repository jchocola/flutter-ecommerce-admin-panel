import 'package:admin_panel/screens/category/all_categories/responive_screens/category_desktop.dart';
import 'package:admin_panel/screens/category/all_categories/responive_screens/category_mobile.dart';
import 'package:admin_panel/screens/category/all_categories/responive_screens/category_tablet.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get_storage/get_storage.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return  TSiteTemplate(desktop: CreateCategoryScreenDesktop(), tablet: CreateCategoryScreenDesktop(), mobile: CreateCategoryScreenMobile(),);
  }
}