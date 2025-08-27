import 'package:admin_panel/screens/layouts/template/login_template.dart';
import 'package:admin_panel/screens/login/widgets/login_form.dart';
import 'package:admin_panel/screens/login/widgets/login_header.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/constants/text_strings.dart';
import 'package:admin_panel/util/theme/spacing_style.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreenDesktopTablet extends StatelessWidget {
  const LoginScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const TLoginTemplate(child: Column(
      children: [
        TLoginHeader(),

        TLoginForm(),
      ],
    ));
  }
}


