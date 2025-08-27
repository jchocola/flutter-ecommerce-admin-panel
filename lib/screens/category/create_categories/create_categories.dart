import 'package:admin_panel/screens/category/all_categories/responive_screens/category_tablet.dart';
import 'package:admin_panel/screens/category/create_categories/responive_screens/create_category_desktop.dart';
import 'package:admin_panel/screens/category/create_categories/responive_screens/create_category_mobile.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:flutter/material.dart';

class CreateCategoriesScreen extends StatelessWidget {
  const CreateCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: CreateCategoryDesktop(), tablet: CreateCategoryScreenTablet(), mobile: CreateCategoryMobile(),);
  }
}