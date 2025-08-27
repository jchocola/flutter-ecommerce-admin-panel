import 'package:admin_panel/screens/banners/create_banners/widgets/create_banners_form.dart';
import 'package:admin_panel/screens/banners/edit_banners/widgets/editBannerForm.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/models/banner_model.dart';
import 'package:flutter/material.dart';

class EditBannersDesktop extends StatelessWidget {
  const EditBannersDesktop({super.key, required this.banner});

  final BannerModel banner;

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

              Editbannerform(title: 'Update Banner', banner: banner),
            ],
          ),
        ),
      )
    );
  }
}