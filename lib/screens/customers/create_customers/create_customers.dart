import 'package:admin_panel/screens/customers/create_customers/responsive_design/create_customers_desktop.dart';
import 'package:admin_panel/screens/customers/create_customers/responsive_design/create_customers_mobile.dart';
import 'package:admin_panel/screens/customers/create_customers/responsive_design/create_customers_tablet.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:flutter/material.dart';

class CreateCustomersScreen extends StatelessWidget {
  const CreateCustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: CreateCustomersDesktop(), tablet: CreateCustomersTablet(), mobile: CreateCustomersMobile(),);
  }
} 