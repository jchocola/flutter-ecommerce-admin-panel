import 'dart:convert';

import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/screens/orders/edit_orders/responsive_design/edit_order_desktop.dart';
import 'package:admin_panel/screens/orders/edit_orders/responsive_design/edit_orders_mobile.dart';
import 'package:admin_panel/screens/orders/edit_orders/responsive_design/edit_orders_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EditOrdersScreen extends StatelessWidget {
  const EditOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;

    // fallback to storage if args is null
    Map<String, dynamic>? order = args;

    if (order == null) {
      final box = GetStorage();
      final cachedOrder = box.read('cached_order');
      if (cachedOrder != null) {
        order = Map<String, dynamic>.from(cachedOrder);
      }
    }

    if (order == null || order.isEmpty) {
      return Scaffold(body: Center(child: Text('Order data not found')));
    }

    return TSiteTemplate(
      desktop: EditOrdersDesktop(orders: order),
      tablet: EditOrdersTablet(orders: order),
      mobile: EditOrdersMobile(orders: order),
    );
  }
}
