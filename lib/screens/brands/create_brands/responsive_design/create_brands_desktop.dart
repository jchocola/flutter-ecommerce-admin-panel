import 'package:admin_panel/screens/brands/create_brands/widgets/brand_form.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class CreateBrandsDesktop extends StatelessWidget {
  const CreateBrandsDesktop({super.key});

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

              CreateBrandForm(title: 'Create New Brand',),
            ],
          ),
        ),
      )
    );
  }
}