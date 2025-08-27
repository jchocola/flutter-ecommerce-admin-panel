import 'package:admin_panel/screens/customers/all_customers/responsive_design/customers_desktop.dart';
import 'package:admin_panel/screens/customers/all_customers/responsive_design/customers_mobile.dart';
import 'package:admin_panel/screens/customers/all_customers/responsive_design/customers_tablet.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:flutter/material.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  TSiteTemplate(desktop: CustomersDesktop(), tablet: CustomersTablet(), mobile: CustomersMobile(),);
  }
} 