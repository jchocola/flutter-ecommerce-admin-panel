import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/screens/settings/responsive-design/settings_desktop.dart';
import 'package:admin_panel/screens/settings/responsive-design/settings_mobile.dart';
import 'package:admin_panel/screens/settings/responsive-design/settings_tablet.dart';
import 'package:flutter/material.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop: SettingsDesktop(), tablet: SettingsTablet(), mobile: SettingsMobile(),);
  }
}