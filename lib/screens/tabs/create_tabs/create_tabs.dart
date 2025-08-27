import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/screens/tabs/create_tabs/responsive_design/create_tabs_desktop.dart';
import 'package:admin_panel/screens/tabs/create_tabs/responsive_design/create_tabs_mobile.dart';
import 'package:admin_panel/screens/tabs/create_tabs/responsive_design/create_tabs_tablet.dart';
import 'package:flutter/material.dart';

class CreateTabsScreen extends StatelessWidget {
  const CreateTabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: CreateTabsDesktop(), tablet: CreateTabsTablet(), mobile: CreateTabsMobile(),);
  }
}