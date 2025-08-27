import 'package:admin_panel/screens/customers/edit_customers/responsive_design/edit_customers_desktop.dart';
import 'package:admin_panel/screens/customers/edit_customers/responsive_design/edit_customers_mobile.dart';
import 'package:admin_panel/screens/customers/edit_customers/responsive_design/edit_customers_tablet.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:flutter/material.dart';

class EditCustomersScreen extends StatelessWidget {
  const EditCustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: EditCustomersDesktop(), tablet: EditCustomersTablet(), mobile: EditCustomersMobile(),);
  }
} 