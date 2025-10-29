import 'package:admin_panel/common/widgets/roundend_styles/t_circluar_image.dart';
import 'package:admin_panel/common/widgets/sidebars/menu_item.dart';
import 'package:admin_panel/screens/layouts/headers/controller/header_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/image_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TSidebar extends StatefulWidget {
  const TSidebar({super.key});

  @override
  State<TSidebar> createState() => _TSidebarState();
}

class _TSidebarState extends State<TSidebar> {
  final controllerHed = Get.find<HeaderController>();

  @override
  void initState() {
    super.initState();

  }

  // void _loadCurrentUser() async {
  //   final currentUser = Supabase.instance.client.auth.currentUser;
  //   if (currentUser != null) {
  //     await controllerHed.getUser(currentUser.email!);
  //   } else {
  //     print('🔴 No authenticated user found.');
  //   }
  // }

  // bool _canAccessMenu(String? userRole, List<String> allowedRoles) {
  //   if (userRole == null) return false;
  //   return allowedRoles.contains(userRole);
  // }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ProductImagesController());

    return Drawer(
      shape: BeveledRectangleBorder(),
      child: Container(
        decoration: BoxDecoration(
          color: dark ? Colors.white.withOpacity(0.05) : Colors.white,
          border: Border(
            right: BorderSide(
              color: dark ? TColors.light.withOpacity(0.5) : TColors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Obx(() {
            final user = controllerHed.user.value;
            final userRole = user?.userRole;

            print('🟢 Current userRole: $userRole');

            return Column(
              children: [
                TCircularImage(
                  image: TImages.appLightLogo,
                  height: 100,
                  width: 100,
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(height: TSizes.spaceBetwwenSections),
                Padding(
                  padding: EdgeInsets.all(TSizes.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'MENU',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(letterSpacingDelta: 1.2),
                      ),

                      // Dashboard: All roles can access
                      TMenuItem(
                        route: TRoutes.dashboard,
                        icon: Iconsax.status,
                        itemname: 'Dashboard',
                        isEnabled: true,
                      ),

                       // Orders: Disabled for Product Manager, Marketing Manager
                      TMenuItem(
                        route: TRoutes.orders,
                        icon: Iconsax.box,
                        itemname: 'Orders',
                       // isEnabled: !_canAccessMenu(userRole, ['Product Manager', 'Marketing Manager']),
                      ),

                                       // Customers: Allow all except Order Manager
                      TMenuItem(
                        route: TRoutes.customers,
                        icon: Iconsax.activity,
                        itemname: 'Customers',
                       // isEnabled: !_canAccessMenu(userRole, ['Order Manager','Marketing Manager','Product Manager']),
                      ),

                      // Banners: Only allow if NOT Order Manager or Product Manager
                      TMenuItem(
                        route: TRoutes.discounts,
                        icon: Iconsax.bookmark,
                        itemname: 'Discounts',
                       // isEnabled: !_canAccessMenu(userRole, ['Order Manager', 'Product Manager','Store Admin']),
                      ),
                        TMenuItem(
                        route: TRoutes.reviews,
                        icon: Iconsax.tag,
                        itemname: 'Reviews',
                       // isEnabled: !_canAccessMenu(userRole, ['Product Manager','Order Manager']),
                      ),

                       TMenuItem(
                        route: TRoutes.categories,
                        icon: Iconsax.category,
                        itemname: 'Categories',
                        //isEnabled: !_canAccessMenu(userRole, ['Product Manager','Order Manager',]),
                      ),
                        TMenuItem(
                        route: TRoutes.collections,
                        icon: Iconsax.activity,
                        itemname: 'Collections',
                       // isEnabled: !_canAccessMenu(userRole, ['Order Manager','Marketing Manager','Product Manager']),
                      ),
                        // Products: Only allow Super Admin and Store Admin
                      TMenuItem(
                        route: TRoutes.products,
                        icon: Iconsax.box,
                        itemname: 'Products',
                       // isEnabled: _canAccessMenu(userRole, ['Super Admin', 'Store Admin', 'Product Manager']),
                      ),
                     
                       TMenuItem(
                        route: TRoutes.banners,
                        icon: Iconsax.activity,
                        itemname: 'Banners',
                       // isEnabled: !_canAccessMenu(userRole, ['Order Manager','Marketing Manager','Product Manager']),
                      ),

                     

                      SizedBox(height: TSizes.spaceBetwwenSections),

                      Text(
                        'SETTINGS',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(letterSpacingDelta: 1.2),
                      ),

                      // Settings: Only Super Admin
                      TMenuItem(
                        route: TRoutes.settings,
                        icon: Iconsax.setting,
                        itemname: 'Settings',
                       // isEnabled: _canAccessMenu(userRole, ['Super Admin']),
                      ),

                      // Product Settings: Only Super Admin and Store Admin
                      // TMenuItem(
                      //   route: TRoutes.product_settings,
                      //   icon: Iconsax.box,
                      //   itemname: 'Product Settings',
                      //   //isEnabled: _canAccessMenu(userRole, ['Super Admin', 'Store Admin']),
                      // ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
