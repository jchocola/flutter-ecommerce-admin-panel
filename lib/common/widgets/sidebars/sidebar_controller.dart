import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SidebarController extends GetxController {

  final activeItem = TRoutes.dashboard.obs;
  final hoverItem = ''.obs;

  void changeActiveItem(String route) => activeItem.value = route;


  void changeHoverItem(String route) {
    if(!isActive(route)) hoverItem.value = route;
  }


  bool isActive(String route) => activeItem.value == route;
  bool isHovering(String route) => hoverItem.value == route;


 void menuOnTap(String route) {
  if (!isActive(route)) {
    print("menuOnTap: navigating to $route");

    changeActiveItem(route);

    final context = Get.context;
    if (context != null && TDeviceUtils.isMobileScreen(context)) {
      Get.back();
    }

    // Safely delay navigation to avoid context/overlay issues
    Future.delayed(const Duration(milliseconds: 100), () {
      try {
        Get.toNamed(route);
      } catch (e, st) {
        print("Navigation error: $e\n$st");
        Get.snackbar("Error", "Failed to navigate to $route");
      }
    });
  }
}


}