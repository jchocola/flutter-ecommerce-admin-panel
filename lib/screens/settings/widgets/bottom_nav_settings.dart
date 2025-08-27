import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';

class BottomNavSettings extends StatelessWidget {
  const BottomNavSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: dark ? Colors.white.withOpacity(0.05) : Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: dark ? Colors.white.withOpacity(0.05) : Colors.white,
                  border: Border.all(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Cancel', style: TextStyle(color: Colors.red),),
                ),
              ),
            ),

            const SizedBox(width: TSizes.spaceBetwwenItems,),

            
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: TColors.primary,
                  border: Border.all(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Save Changes', style: TextStyle(color: Colors.white),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}