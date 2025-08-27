import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserManagement extends StatelessWidget {
  const UserManagement({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color:
            dark
                ? Colors.white.withOpacity(0.05)
                : TColors.dark.withOpacity(0.2),
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
              'User Management',
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: TSizes.spaceBetwwenItems),

            if (TDeviceUtils.isTabletScreen(context))
              TUserManagementTablet(dark: dark),

            if (TDeviceUtils.isDesktopScreen(context))
              TUserManagementDesktop(dark: dark),

            if (TDeviceUtils.isMobileScreen(context))
              TUserManagementMobile(dark: dark),
          ],
        ),
      ),
    );
  }
}

class TUserManagementTablet extends StatelessWidget {
  const TUserManagementTablet({super.key, required this.dark});

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
              onTap: () => Get.toNamed(TRoutes.changePassword),
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
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Iconsax.lock_circle),
                      const SizedBox(width: TSizes.spaceBetwwenItems),
                      Text(
                        'Change Password',
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
             onTap: () => Get.toNamed(TRoutes.manageUsers),
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
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Iconsax.user_add),
                      const SizedBox(width: TSizes.spaceBetwwenItems),
                      Text(
                        'Add/Remove Users',
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
              onTap: () => Get.toNamed(TRoutes.setRoles),
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
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Iconsax.activity),
                      const SizedBox(width: TSizes.spaceBetwwenItems),
                      Text(
                        'Set Roles/Permission',
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
             onTap: () => Get.toNamed(TRoutes.userActivityLog),
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
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Iconsax.user4),
                      const SizedBox(width: TSizes.spaceBetwwenItems),
                      Text(
                        'User Activity Log',
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
      ],
    );
  }
}

class TUserManagementMobile extends StatelessWidget {
  const TUserManagementMobile({super.key, required this.dark});

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.toNamed(TRoutes.changePassword),
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
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Iconsax.lock_circle),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Text(
                    'Change Password',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.apply(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: TSizes.spaceBetwwenItems),

        GestureDetector(
          onTap: () => Get.toNamed(TRoutes.manageUsers),
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
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Iconsax.user_add),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Text(
                    'Add/Remove Users',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.apply(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBetwwenItems),
        GestureDetector(
           onTap: () => Get.toNamed(TRoutes.setRoles),
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
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Iconsax.activity),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Text(
                    'Set Roles/Permission',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.apply(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBetwwenItems),
        GestureDetector(
           onTap: () => Get.toNamed(TRoutes.userActivityLog),
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
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Iconsax.user4),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Text(
                    'User Activity Log',
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

class TUserManagementDesktop extends StatelessWidget {
  const TUserManagementDesktop({super.key, required this.dark});

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.toNamed(TRoutes.changePassword),
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
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Iconsax.lock_circle),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Text(
                    'Change Password',
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
          onTap: () => Get.toNamed(TRoutes.manageUsers),
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
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Iconsax.user_add),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Text(
                    'Add/Remove Users',
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
           onTap: () => Get.toNamed(TRoutes.setRoles),
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
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Iconsax.activity),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Text(
                    'Set Roles/Permission',
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
          onTap: () => Get.toNamed(TRoutes.userActivityLog),
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
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Iconsax.user4),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Text(
                    'User Activity Log',
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
