import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/constants/validator.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: PasswordChangeScreen(),
      tablet: PasswordChangeScreen(),
      mobile: PasswordChangeScreen(),
    );
  }
}

class PasswordChangeScreen extends StatelessWidget {
  const PasswordChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Container(
          decoration: BoxDecoration(
            color: dark ? Colors.white.withOpacity(0.05) : Colors.white,
            border: Border.all(
              color:
                  dark
                      ? Colors.grey.withOpacity(0.5)
                      : TColors.dark.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  'Change Password',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: TSizes.spaceBetwwenItems),

                Container(
                  width: TSizes.buttonWidth * 3,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Current Password',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color:
                              dark
                                  ? Colors.grey.withOpacity(0.5)
                                  : TColors.dark.withOpacity(0.2),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color:
                              dark
                                  ? Colors.white.withOpacity(1)
                                  : TColors.dark.withOpacity(1),
                        ),
                      ),
                      hintText: 'Enter Your Current Password',
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator:
                        (value) => TValidator.validateEmptyText(
                          'Current Password',
                          value,
                        ),
                  ),
                ),

                const SizedBox(height: TSizes.spaceBetweenInputFields,),
                Container(
                  width: TSizes.buttonWidth * 3,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color:
                              dark
                                  ? Colors.grey.withOpacity(0.5)
                                  : TColors.dark.withOpacity(0.2),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color:
                              dark
                                  ? Colors.white.withOpacity(1)
                                  : TColors.dark.withOpacity(1),
                        ),
                      ),
                      hintText: 'Enter Your New Password',
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator:
                        (value) => TValidator.validateEmptyText(
                          'New Password',
                          value,
                        ),
                  ),
                ),

                const SizedBox(height: TSizes.spaceBetweenInputFields,),
                Container(
                  width: TSizes.buttonWidth * 3,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color:
                              dark
                                  ? Colors.grey.withOpacity(0.5)
                                  : TColors.dark.withOpacity(0.2),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color:
                              dark
                                  ? Colors.white.withOpacity(1)
                                  : TColors.dark.withOpacity(1),
                        ),
                      ),
                      hintText: 'Enter Your Confirm Password',
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator:
                        (value) => TValidator.validateEmptyText(
                          'Confirm Password',
                          value,
                        ),
                  ),
                ),



                const SizedBox(height: TSizes.spaceBetwwenSections,),

                Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: TColors.primary,
                    border: Border.all(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Center(child: Text('Change Password', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
