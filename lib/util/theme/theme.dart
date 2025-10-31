import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/theme/custom_themes/app_bar_theme.dart';
import 'package:admin_panel/util/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:admin_panel/util/theme/custom_themes/checkbox_theme.dart';
import 'package:admin_panel/util/theme/custom_themes/chip_theme.dart';
import 'package:admin_panel/util/theme/custom_themes/elevated_button_theme.dart';
import 'package:admin_panel/util/theme/custom_themes/outlined_button_theme.dart';
import 'package:admin_panel/util/theme/custom_themes/text_field_theme.dart';
import 'package:admin_panel/util/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins', // If added manually
    brightness: Brightness.light,
    primaryColor: Color(0xffff8200),
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    scaffoldBackgroundColor: TColors.light,
    appBarTheme: TAppBarTheme.lightAppBartheme,
    checkboxTheme: TCheckBoxTheme.lightCheckBoxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlineButtonTheme.lightOutlineButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
   useMaterial3: true,
    fontFamily: 'Poppins', // If added manually
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    scaffoldBackgroundColor: TColors.dark,
    appBarTheme: TAppBarTheme.darkAppBartheme,
    checkboxTheme: TCheckBoxTheme.darkCheckBoxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlineButtonTheme.darkOutlineButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );}