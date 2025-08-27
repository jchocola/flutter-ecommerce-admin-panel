import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';


class ConnectivitySettings extends StatefulWidget {
  const ConnectivitySettings({super.key});

  @override
  State<ConnectivitySettings> createState() => _ConnectivitySettingsState();
}

class _ConnectivitySettingsState extends State<ConnectivitySettings> {
  @override
  Widget build(BuildContext context) {
    final dark  = THelperFunctions.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: dark ? Colors.white.withOpacity(0.05) : Colors.white,
        border: Border.all(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Database Connection', style: Theme.of(context).textTheme.headlineSmall,),
            const SizedBox(height: TSizes.spaceBetwwenItems,),
            Row(
              children: [
                Image.asset(TImages.supabase_icon, width: 120, height: 120),
                 const SizedBox(width: TSizes.spaceBetwwenItems,),
                 Text('🟢 Connected')
              ],
            ),
          ],
        ),
      ),
    );
  }
}