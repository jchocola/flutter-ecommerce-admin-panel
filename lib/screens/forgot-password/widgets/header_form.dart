import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class HeaderAndForm extends StatelessWidget {
  const HeaderAndForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    
        IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.arrow_left)),
        const SizedBox(height: TSizes.spaceBetwwenItems,),
        Text('Forgot Password', style: Theme.of(context).textTheme.headlineMedium,),
        const SizedBox(height: TSizes.spaceBetwwenItems,),
        Text('Forgot Password Sub', style: Theme.of(context).textTheme.headlineMedium,),
        const SizedBox(height: TSizes.spaceBetwwenItems * 2,),
    
        Form(
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'email', prefixIcon: Icon(Iconsax.direct_right)),
          ),
        ),
        const SizedBox(height: TSizes.spaceBetwwenSections,),
    
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: () => Get.toNamed(TRoutes.resetPassword, parameters:{'email': 'afras@dev.com'}), child: const Text('Submit')),
        )
      ],
    );
  }
}
