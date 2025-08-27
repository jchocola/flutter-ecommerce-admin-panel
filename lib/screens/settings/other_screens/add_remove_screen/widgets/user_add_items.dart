import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/settings/other_screens/add_remove_screen/controller/add_remove_user_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAddRemoveItem extends StatelessWidget {
  const UserAddRemoveItem({
    super.key,
    required this.email,
    required this.role,
    required this.controller,
  });

  final String email, role;
  final AddRemoveUserController controller;

  @override
  Widget build(BuildContext context) {
    if(TDeviceUtils.isDesktopScreen(context) || TDeviceUtils.isTabletScreen(context)) {
      return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Text(email),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: THelperFunctions.getRoleColor(
                      role,
                    ).withOpacity(0.1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      role,
                      style: TextStyle(
                        color: THelperFunctions.getRoleColor(role),
                      ),
                    ),
                  ),
                ),
                   const SizedBox(width: TSizes.spaceBetwwenItems),
          
              ],
            ),
        
    
       
       
        ],
      ),
    );
    } else {
      return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(email),
            const SizedBox(height: TSizes.spaceBetwwenItems,),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: THelperFunctions.getRoleColor(
                      role,
                    ).withOpacity(0.1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      role,
                      style: TextStyle(
                        color: THelperFunctions.getRoleColor(role),
                      ),
                    ),
                  ),
                ),
                   const SizedBox(width: TSizes.spaceBetwwenItems),
          
              ],
            ),
        
    
       
       
        ],
      ),
    );
    }
  }
}
