import 'package:admin_panel/screens/brands/brands/responsive_design/brands_desktop.dart';
import 'package:admin_panel/screens/brands/brands/responsive_design/brands_mobile.dart';
import 'package:admin_panel/screens/brands/brands/responsive_design/brands_tablet.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:flutter/material.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  TSiteTemplate(desktop: BrandsDesktop(), tablet: BrandsTablet(), mobile: BrandsMobile(),);
  }
}