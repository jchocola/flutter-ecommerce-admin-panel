import 'package:admin_panel/screens/forgot-password/widgets/header_form.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:flutter/material.dart';


class ForgotPasswordScreenMobile extends StatelessWidget {
  const ForgotPasswordScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: HeaderAndForm(),
        )
      ),
    );
  }
}