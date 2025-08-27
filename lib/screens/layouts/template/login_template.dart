import 'package:admin_panel/screens/login/widgets/login_form.dart';
import 'package:admin_panel/screens/login/widgets/login_header.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/theme/spacing_style.dart';
import 'package:flutter/material.dart';

class TLoginTemplate extends StatelessWidget {
  const TLoginTemplate({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);   
    return  Center(
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: Container(
            padding: TSpacingStyle.paddingWithAppBarHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: dark ? Colors.white.withOpacity(0.05) : Colors.white,
              border: Border.all(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2))
            ),
            child: child
          ),
        ),
      ),
    );
  }
}