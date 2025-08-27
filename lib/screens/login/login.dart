import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/screens/login/responsive_layout/login_desktop.dart';
import 'package:admin_panel/screens/login/responsive_layout/login_mobile.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(useLayout: false, desktop: LoginScreenDesktopTablet(), mobile: LoginScreenMobile(),);
  }
}