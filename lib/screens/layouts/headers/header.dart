import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/layouts/headers/controller/header_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/image_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';

class THeader extends StatefulWidget implements PreferredSizeWidget {
  THeader({super.key, this.scaffoldKey});

  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  State<THeader> createState() => _THeaderState();
  
 @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight() + 20);
}

class _THeaderState extends State<THeader> {
  final controller = Get.find<HeaderController>();


@override
void initState() {
  super.initState();
  _loadCurrentUser();
}

void _loadCurrentUser() async {
  // final currentUser = Supabase.instance.client.auth.currentUser;
  // if (currentUser != null) {
  //   await controller.getUser(currentUser.email!);
  // } else {
  //   print('🔴 No authenticated user found.');
  // }
}


String _getGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning!';
  } else if (hour < 17) {
    return 'Good Afternoon!';
  } else {
    return 'Good Evening!';
  }
}

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controllerImage = Get.put(ProductImagesController());

    return Container(
      decoration: BoxDecoration(
        color: dark ? TColors.primary.withOpacity(1) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: dark
                ? TColors.grey.withOpacity(0.5)
                : TColors.dark.withOpacity(0.2),
            width: 0.5,
          ),
        ),
      ),
      padding: TDeviceUtils.isDesktopScreen(context)
          ? EdgeInsets.symmetric(horizontal: TSizes.md, vertical: TSizes.md)
          : null,
      child: AppBar(
        
        backgroundColor: Colors.transparent,
        leading: !TDeviceUtils.isDesktopScreen(context)
            ? IconButton(
                onPressed: () => widget.scaffoldKey?.currentState?.openDrawer(),
                icon: const Icon(Iconsax.menu),
              )
            :null,
        title: SizedBox(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              if(TDeviceUtils.isMobileScreen(context) || TDeviceUtils.isTabletScreen(context))
              const SizedBox(height: TSizes.spaceBetwwenItems,),
              
              Text(
                _getGreeting(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Obx(() {
                final user = controller.user.value;
                if (user == null) {
                  return Text('Loading...',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: TColors.dark));
                }

                return Row(
                  children: [
                    Text(
                      user.name ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: TColors.dark),
                    ),
                    const SizedBox(width: TSizes.spaceBetwwenItems),
                    TRoundedContainer(
                      width: 15,
                      height: 15,
                      backgroundColor: THelperFunctions.getRoleColor(
                        user.userRole ?? 'Super Admin',
                      ),
                    ),
                    const SizedBox(width: TSizes.sm),
                    Text(
                      user.userRole ?? 'Super Admin',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
        actions: [
          Row(
            children: [
               GestureDetector(
               onTap: () async {
  try {
   // await Supabase.instance.client.auth.signOut();

    /// Reset the HeaderController user observable
    final headerController = Get.find<HeaderController>();
    headerController.user.value = null;

    /// Clear any other controller state as needed

    /// Navigate to login
    Get.offAllNamed(TRoutes.login);
  } catch (e) {
    Get.snackbar('Error', e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
  }
},

                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(1),
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text('Log Out', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
              const SizedBox(width: TSizes.spaceBetwwenItems,),
           
            ],
          ),
        ],
      ),
    );
  }


}
