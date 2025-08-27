import 'package:admin_panel/screens/reset-password/reset_password.dart';
import 'package:admin_panel/screens/reset-password/widgets/reset_passwrod_widget.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:flutter/material.dart';


class ResetPasswordScreenMobile extends StatelessWidget {
  const ResetPasswordScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child: ResetPasswordWidget(),),
      ),
    );
  }
}