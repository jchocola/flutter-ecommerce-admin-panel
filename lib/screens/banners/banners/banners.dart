import 'package:admin_panel/screens/banners/banners/responsive_screen/banners_desktop.dart';
import 'package:admin_panel/screens/banners/banners/responsive_screen/banners_mobile.dart';
import 'package:admin_panel/screens/banners/banners/responsive_screen/banners_tablet.dart';
import 'package:admin_panel/screens/layouts/headers/controller/header_controller.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BannersScreen extends StatefulWidget {
  const BannersScreen({super.key});

  @override
  State<BannersScreen> createState() => _BannersScreenState();
}

bool _canAccessMenu(String? userRole, List<String> allowedRoles) {
  if (userRole == null) return false;
  return allowedRoles.contains(userRole);
}

class _BannersScreenState extends State<BannersScreen> {
  final controllerHed = Get.find<HeaderController>();

  @override
  void initState() {
    super.initState();
    final user = controllerHed.user.value;
    final userRole = user?.userRole;
    if (_canAccessMenu(userRole, [
      'Order Manager',
      'Product Manager',
      'Store Admin',
      'Marketing Manager',
      
    ])) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = controllerHed.user.value;
    final userRole = user?.userRole;

    if (!_canAccessMenu(userRole, [
      'Order Manager',
      'Product Manager',
      'Store Admin',
      'Marketing Manager',
      'Super Admin'
    ])) {
      return const TSiteTemplate(
        desktop: Center(
          child: Text('You dont have permission to mannage banners'),
        ),
      );
    } else {
      return const TSiteTemplate(
        desktop: BannersDesktop(),
        tablet: BannersTablet(),
        mobile: BannersMobile(),
      );
    }
  }
}
