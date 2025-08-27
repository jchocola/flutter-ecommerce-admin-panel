import 'package:admin_panel/screens/brands/create_brands/widgets/brand_form.dart';
import 'package:admin_panel/screens/brands/create_brands/widgets/edit_brand_form.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class EditBrandsDesktop extends StatelessWidget {
  const EditBrandsDesktop({super.key, required this.brandModel});

  final BrandModel brandModel;

  @override
  Widget build(BuildContext context) {

     return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: TSizes.spaceBetwwenSections,),

             EditBrandForm(title: 'Update Brand', brandModel: brandModel),
            ],
          ),
        ),
      )
    );
  }
}