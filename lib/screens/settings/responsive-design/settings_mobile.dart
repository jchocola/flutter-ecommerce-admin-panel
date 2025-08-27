import 'package:admin_panel/common/widgets/heading/section_heading.dart';
import 'package:admin_panel/screens/settings/widgets/email_settings.dart';
import 'package:admin_panel/screens/settings/widgets/general_settings.dart';
import 'package:admin_panel/screens/settings/widgets/payment_settings.dart';
import 'package:admin_panel/screens/settings/widgets/user_management.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class SettingsMobile extends StatelessWidget {
  const SettingsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Settings', style: Theme.of(context).textTheme.headlineLarge,),
                  const SizedBox(height: TSizes.spaceBetwwenItems,),
                   GeneralSettings(),
                   const SizedBox(height: TSizes.spaceBetwwenSections,),
                   UserManagement(),
                   const SizedBox(height: TSizes.spaceBetwwenSections,),
                   EmailSettings(),
                    const SizedBox(height: TSizes.spaceBetwwenSections,),
                   PaymentSettings(),
                ],
              ),
            ),
        
           
          ],
        ),
      ),
    );
  }
}