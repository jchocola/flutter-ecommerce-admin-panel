import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/screens/orders/all_orders/responsive_design/orders_desktop.dart';
import 'package:admin_panel/screens/orders/all_orders/responsive_design/orders_mobile.dart';
import 'package:admin_panel/screens/orders/all_orders/responsive_design/orders_tablet.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop: OrdersDesktop(), tablet: OrdersTablet(), mobile: OrdersMobile(),);
  }
}