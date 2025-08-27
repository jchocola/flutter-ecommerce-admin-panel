import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/screens/product_settings/responsive-design/product_settings_desktop.dart';
import 'package:admin_panel/screens/product_settings/responsive-design/product_settings_mobile.dart';
import 'package:admin_panel/screens/product_settings/responsive-design/product_settings_tablet.dart';
import 'package:flutter/material.dart';

class ProductSettingsScreen extends StatelessWidget {
  const ProductSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop: ProductSettingsDesktop(), tablet: ProductSettingsTablet(), mobile: ProductSettingsMobile(),);
  }
}