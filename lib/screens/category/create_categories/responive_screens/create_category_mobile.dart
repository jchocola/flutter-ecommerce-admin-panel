import 'package:admin_panel/screens/category/create_categories/widgets/create_catogory_form.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class CreateCategoryMobile extends StatelessWidget {
  const CreateCategoryMobile({super.key});

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

              CreateCategoryForm(),
            ],
          ),
        ),
      )
    );
  }
}