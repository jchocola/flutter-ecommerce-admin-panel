import 'package:admin_panel/screens/forgot-password/responsive_layout/forgot_password_dektop.dart';
import 'package:admin_panel/screens/forgot-password/responsive_layout/forgot_password_mobile.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/screens/reset-password/responsive_layout/reset_password_dektop.dart';
import 'package:admin_panel/screens/reset-password/responsive_layout/reset_password_mobile.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(useLayout: false, desktop: ResetPasswordScreenDesktopTablet(), mobile: ResetPasswordScreenMobile(),);
  }
}