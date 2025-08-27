import 'package:admin_panel/screens/category/edit_categories/widgets/edit_catogory_form.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/models/category_model.dart';
import 'package:flutter/material.dart';

class EditCategoriesMobile extends StatelessWidget {
  const EditCategoriesMobile({super.key, required this.category});
final CategoryModel category;
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: TSizes.spaceBetwwenSections,),

              EditCategoryForm(category: category),
            ],
          ),
        ),
      )
    );
  }
}