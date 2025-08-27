import 'package:admin_panel/screens/login/widgets/login_form.dart';
import 'package:admin_panel/screens/login/widgets/login_header.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:flutter/material.dart';


class LoginScreenMobile extends StatelessWidget {
  const LoginScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(

            children: [
              TLoginHeader(),

              TLoginForm()
            ],
          ),
        ),
      ),
    );
  }
}