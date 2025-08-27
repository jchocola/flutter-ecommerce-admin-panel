import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/screens/tabs/all_tabs/responsive_design/tabs_desktop.dart';
import 'package:admin_panel/screens/tabs/all_tabs/responsive_design/tabs_mobile.dart';
import 'package:admin_panel/screens/tabs/all_tabs/responsive_design/tabs_tablet.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  TSiteTemplate(desktop: TabsDesktop(),tablet: TabsTablet(), mobile: TabsMobile(),);
  }
}