import 'package:admin_panel/screens/settings/widgets/user_management.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EmailSettings extends StatelessWidget {
  const EmailSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
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
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email Settings',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSizes.spaceBetwwenItems),

            if(TDeviceUtils.isDesktopScreen(context))
            TEmailSettingDesktop(dark: dark),


            if(TDeviceUtils.isTabletScreen(context))
            TEmailSettingTablet(dark: dark),


            if(TDeviceUtils.isMobileScreen(context))
            TEmailSettingMobile(dark: dark),
          ],
        ),
      ),
    );
  }
}
class TEmailSettingTablet extends StatelessWidget {
  const TEmailSettingTablet({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color:
                  dark ? Colors.white.withOpacity(0.05) : Colors.white,
              border: Border.all(
                color:
                    dark
                        ? Colors.grey.withOpacity(0.5)
                        : TColors.dark.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Iconsax.direct_right),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Text(
                    'SMTP Configuration',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.apply(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
    
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color:
                  dark ? Colors.white.withOpacity(0.05) : Colors.white,
              border: Border.all(
                color:
                    dark
                        ? Colors.grey.withOpacity(0.5)
                        : TColors.dark.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Iconsax.send),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Text(
                    'Sender,Name & Address',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.apply(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
          ],
        ),
    
       Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color:
                  dark ? Colors.white.withOpacity(0.05) : Colors.white,
              border: Border.all(
                color:
                    dark
                        ? Colors.grey.withOpacity(0.5)
                        : TColors.dark.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Iconsax.check),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Text(
                    'Test Email Functionally',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.apply(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color:
                  dark ? Colors.white.withOpacity(0.05) : Colors.white,
              border: Border.all(
                color:
                    dark
                        ? Colors.grey.withOpacity(0.5)
                        : TColors.dark.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Iconsax.card),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Text(
                    'Email Template',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.apply(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        ],
       )
      ],
    );
  }
}

class TEmailSettingDesktop extends StatelessWidget {
  const TEmailSettingDesktop({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color:
                  dark ? Colors.white.withOpacity(0.05) : Colors.white,
              border: Border.all(
                color:
                    dark
                        ? Colors.grey.withOpacity(0.5)
                        : TColors.dark.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Iconsax.direct_right),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Text(
                    'SMTP Configuration',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.apply(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
    
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color:
                  dark ? Colors.white.withOpacity(0.05) : Colors.white,
              border: Border.all(
                color:
                    dark
                        ? Colors.grey.withOpacity(0.5)
                        : TColors.dark.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Iconsax.send),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Text(
                    'Sender,Name & Address',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.apply(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
    
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color:
                  dark ? Colors.white.withOpacity(0.05) : Colors.white,
              border: Border.all(
                color:
                    dark
                        ? Colors.grey.withOpacity(0.5)
                        : TColors.dark.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Iconsax.check),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Text(
                    'Test Email Functionally',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.apply(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color:
                  dark ? Colors.white.withOpacity(0.05) : Colors.white,
              border: Border.all(
                color:
                    dark
                        ? Colors.grey.withOpacity(0.5)
                        : TColors.dark.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Iconsax.card),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Text(
                    'Email Template',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.apply(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class TEmailSettingMobile extends StatelessWidget {
  const TEmailSettingMobile({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color:
                  dark ? Colors.white.withOpacity(0.05) : Colors.white,
              border: Border.all(
                color:
                    dark
                        ? Colors.grey.withOpacity(0.5)
                        : TColors.dark.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Iconsax.direct_right),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Text(
                    'SMTP Configuration',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.apply(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: TSizes.spaceBetwwenItems,),
    
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color:
                  dark ? Colors.white.withOpacity(0.05) : Colors.white,
              border: Border.all(
                color:
                    dark
                        ? Colors.grey.withOpacity(0.5)
                        : TColors.dark.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Iconsax.send),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Text(
                    'Sender,Name & Address',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.apply(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
    const SizedBox(height: TSizes.spaceBetwwenItems,),
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color:
                  dark ? Colors.white.withOpacity(0.05) : Colors.white,
              border: Border.all(
                color:
                    dark
                        ? Colors.grey.withOpacity(0.5)
                        : TColors.dark.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Iconsax.check),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Text(
                    'Test Email Functionally',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.apply(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBetwwenItems,),
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color:
                  dark ? Colors.white.withOpacity(0.05) : Colors.white,
              border: Border.all(
                color:
                    dark
                        ? Colors.grey.withOpacity(0.5)
                        : TColors.dark.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Iconsax.card),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Text(
                    'Email Template',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.apply(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
