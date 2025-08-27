import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/screens/orders/create_order/responsive_design/create_order_desktop.dart';
import 'package:admin_panel/screens/orders/create_order/responsive_design/create_orders_mobile.dart';
import 'package:admin_panel/screens/orders/create_order/responsive_design/create_orders_tablet.dart';
import 'package:flutter/material.dart';

class CreateOrderScreen extends StatelessWidget {
  const CreateOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: CreateOrdersDesktop(), tablet: CreateOrdersTablet(), mobile: CreateOrdersMobile(),);
  }
}