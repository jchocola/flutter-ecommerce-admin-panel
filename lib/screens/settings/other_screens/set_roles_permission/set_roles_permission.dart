import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/screens/settings/other_screens/set_roles_permission/table/roles_table.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';

class SetRolesPermissionScreen extends StatelessWidget {
  const SetRolesPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop: SetRolesPermissionResp(), tablet: SetRolesPermissionResp(), mobile: SetRolesPermissionResp(),);
  }
}


class SetRolesPermissionResp extends StatelessWidget {
  const SetRolesPermissionResp({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Set Roles & Permission', style: Theme.of(context).textTheme.headlineLarge,),
              const SizedBox(height: TSizes.spaceBetwwenItems,),
        
              Container(
                decoration: BoxDecoration(
                  color: dark ? Colors.white.withOpacity(0.05) : Colors.white,
                  border: Border.all(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                   children: [
                    Column(
                      children: [

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TRoundedContainer(
                              width: 20,
                              height: 20,
                              backgroundColor: THelperFunctions.getRoleColor('Super Admin'),
                            ),
                            const SizedBox(width: TSizes.spaceBetwwenItems,),
                            Flexible(child: Text('Super Admin \nFull access to all features (including platform settings, users, analytics, etc.)'))
                          ],
                        ),

                        const SizedBox(height: TSizes.spaceBetwwenItems,),

                        
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TRoundedContainer(
                              width: 20,
                              height: 20,
                              backgroundColor: THelperFunctions.getRoleColor('Store Admin'),
                            ),
                            const SizedBox(width: TSizes.spaceBetwwenItems,),
                            Flexible(child: Text('Store Admin \nFull access to their own store (products, orders, users, settings)'))
                          ],
                        ),

                        const SizedBox(height: TSizes.spaceBetwwenItems,),

                         Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TRoundedContainer(
                              width: 20,
                              height: 20,
                              backgroundColor: THelperFunctions.getRoleColor('Product Manager'),
                            ),
                            const SizedBox(width: TSizes.spaceBetwwenItems,),
                            Flexible(child: Text('Product Manager \nManages inventory, products, and pricing'))
                          ],
                        ),

                        const SizedBox(height: TSizes.spaceBetwwenItems,),

                          Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TRoundedContainer(
                              width: 20,
                              height: 20,
                              backgroundColor: THelperFunctions.getRoleColor('Order Manager'),
                            ),
                            const SizedBox(width: TSizes.spaceBetwwenItems,),
                            Flexible(child: Text('Order Manager \nManages all order-related operations'))
                          ],
                        ),

                        const SizedBox(height: TSizes.spaceBetwwenItems,),

                          Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TRoundedContainer(
                              width: 20,
                              height: 20,
                              backgroundColor: THelperFunctions.getRoleColor('Marketing Manager'),
                            ),
                            const SizedBox(width: TSizes.spaceBetwwenItems,),
                            Text('Marketing Manager \nHandles promotions and customer engagement')
                          ],
                        ),

                        const SizedBox(height: TSizes.spaceBetwwenItems,),
                      ],
                    ),
                     RolesAndPermisionTable(),
                   ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}