import 'package:admin_panel/screens/settings/other_screens/database_screen/database_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/constants/validator.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class DataBaseSetting extends StatefulWidget {
  const DataBaseSetting({super.key});

  @override
  State<DataBaseSetting> createState() => _DataBaseSettingState();
}

class _DataBaseSettingState extends State<DataBaseSetting> {
  final controller = Get.put(DatabaseController());
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
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Database Settings',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSizes.spaceBetwwenItems,),
            Container(
              width: TSizes.buttonWidth * 3,
              child: TextFormField(
                controller: controller.urlController,
                decoration:  InputDecoration(
                  labelText: 'Supabase URL',
                  hintText: 'Enter Your Supabase URL',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2))
                  ),
                   focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(color: dark ? Colors.white.withOpacity(1) : TColors.dark.withOpacity(1))
                  ),
                ),
                validator:
                    (value) =>
                        TValidator.validateEmptyText('URL', value),
              ),
            ),

             const SizedBox(height: TSizes.spaceBetwwenItems,),
            Container(
              width: TSizes.buttonWidth * 3,
              child: TextFormField(
                controller: controller.anonKeyController,
                decoration:  InputDecoration(
                  labelText: 'Supabase Anon Key',
                  hintText: 'Enter Your Supabase Anon Key',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2))
                  ),
                   focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(color: dark ? Colors.white.withOpacity(1) : TColors.dark.withOpacity(1))
                  ),
                ),
                validator:
                    (value) =>
                        TValidator.validateEmptyText('ANON KEY', value),
              ),
            ),
            const SizedBox(height: TSizes.spaceBetwwenItems,),
            Obx(() {
              if(controller.hasAnonKey.value && controller.hasUrl.value){
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: TColors.primary,
                      border: Border.all(color: dark  ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('Save', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }
}
