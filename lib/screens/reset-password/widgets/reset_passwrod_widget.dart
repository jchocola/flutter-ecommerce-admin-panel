import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final email = Get.parameters['email'] ?? '';
    return Column(
      children: [
    
        Row(
          children: [
            IconButton(onPressed: () => Get.offAllNamed(TRoutes.login), icon: const Icon(CupertinoIcons.clear)),
          ],
        ),
        const SizedBox(height: TSizes.spaceBetwwenItems,),
    
        const Image(image: AssetImage(TImages.productImage1), width: 300, height: 300,),
        const SizedBox(height: TSizes.spaceBetwwenItems,),
    
        Text('Change your Password', style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
        const SizedBox(height: TSizes.spaceBetwwenItems,),
        Text(email, textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelLarge,),
        const SizedBox(height: TSizes.spaceBetwwenItems,),
        Text(
          'Change Your Password',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: TSizes.spaceBetwwenSections,),
    
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: () => Get.offAllNamed(TRoutes.login), child: const Text('Done')),
    
        ),
        const SizedBox(height: TSizes.spaceBetwwenItems,),
        SizedBox(
          width: double.infinity,
          child: TextButton(onPressed: () {}, child: const Text('Resend Email')),
        )
      ],
    );
  }
}