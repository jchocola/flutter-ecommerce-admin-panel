import 'package:admin_panel/screens/banners/create_banners/widgets/create_banners_form.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class CreateBannerTablet extends StatelessWidget {
  const CreateBannerTablet({super.key});

  @override
  Widget build(BuildContext context) {
     return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: TSizes.spaceBetwwenSections,),

               CreateBannersForm(title: 'Create New Banner',),
            ],
          ),
        ),
      )
    );
  }
}