import 'package:admin_panel/screens/brands/create_brands/responsive_design/create_brands_desktop.dart';
import 'package:admin_panel/screens/brands/create_brands/responsive_design/create_brands_mobile.dart';
import 'package:admin_panel/screens/brands/create_brands/responsive_design/create_brands_tablet.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:flutter/material.dart';

class CreateBrandScreen extends StatelessWidget {
  const CreateBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop: CreateBrandsDesktop(), tablet: const CreateBrandsTablet(), mobile: const CreateBrandsMobile(),);
  }
}