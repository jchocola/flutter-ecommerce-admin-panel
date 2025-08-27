import 'package:admin_panel/screens/forgot-password/widgets/header_form.dart';
import 'package:admin_panel/screens/layouts/template/login_template.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';


class ForgotPasswordScreenDesktopTablet extends StatelessWidget {
  const ForgotPasswordScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return TLoginTemplate(
      child: HeaderAndForm(),
    );
  }
  }

