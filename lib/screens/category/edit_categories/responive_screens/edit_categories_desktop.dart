import 'package:flutter/material.dart';
import 'package:admin_panel/util/models/category_model.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/screens/category/edit_categories/widgets/edit_catogory_form.dart';

class EditCategoriesDesktop extends StatelessWidget {
  final CustomCategoryModel? category;

  const EditCategoriesDesktop({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    if (category == null) {
      return Scaffold(
        body: Center(child: Text('❌ No category data to display.')),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Example title to confirm data is passed
          

              SizedBox(height: TSizes.spaceBetwwenSections),

              EditCategoryForm(category: category!),
            ],
          ),
        ),
      ),
    );
  }
}
