import 'package:admin_panel/screens/banners/edit_banners/responsive_banner/edit_banners_desktop.dart';
import 'package:admin_panel/screens/banners/edit_banners/responsive_banner/edit_banners_mobile.dart';
import 'package:admin_panel/screens/banners/edit_banners/responsive_banner/edit_banners_tablet.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/util/models/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBannersScreen extends StatelessWidget {
  const EditBannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final banner = Get.arguments as BannerModel;
    return  TSiteTemplate(
      desktop: EditBannersDesktop(banner: banner,),
      tablet: EditBannersTablet(banner: banner,),
      mobile: EditBannersMobile(banner: banner,),
    );
  }
}
