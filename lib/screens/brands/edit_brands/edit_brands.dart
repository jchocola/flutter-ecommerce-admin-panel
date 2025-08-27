import 'package:admin_panel/screens/brands/edit_brands/responsive_desgin/edit_brands_desktop.dart';
import 'package:admin_panel/screens/brands/edit_brands/responsive_desgin/edit_brands_mobile.dart';
import 'package:admin_panel/screens/brands/edit_brands/responsive_desgin/edit_brands_tablet.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/util/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EditBrandScreen extends StatefulWidget {
  const EditBrandScreen({super.key});

  @override
  State<EditBrandScreen> createState() => _EditBrandScreenState();
}

class _EditBrandScreenState extends State<EditBrandScreen> {
  BrandModel? brandModel;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _loadBrandData();
  }

  void _loadBrandData() {
    final args = Get.arguments;

    if (args != null && args is BrandModel) {
      brandModel = args;
      box.write('cached_brand', brandModel!.toJson());
    } else {
      final cached = box.read('cached_brand');
      if (cached != null) {
        brandModel = BrandModel.fromJson(Map<String, dynamic>.from(cached));
      }
    }

    setState(() {}); // refresh the widget once data is loaded
  }

  @override
  Widget build(BuildContext context) {
    if (brandModel == null) {
      return Scaffold(
        body: Center(child: Text('❌ No brand data found.')),
      );
    }

    return TSiteTemplate(
      desktop: EditBrandsDesktop(brandModel: brandModel!),
      tablet: EditBrandsTablet(brandModel: brandModel!),
      mobile: EditBrandsMobile(brandModel: brandModel!),
    );
  }
}
