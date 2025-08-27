import 'package:admin_panel/screens/banners/create_banners/responsive_screen/create_banner_desktop.dart';
import 'package:admin_panel/screens/banners/create_banners/responsive_screen/create_banner_mobile.dart';
import 'package:admin_panel/screens/banners/create_banners/responsive_screen/create_banner_tablet.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:flutter/material.dart';

class CreateBannerScreen extends StatelessWidget {
  const CreateBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: CreateBannerDesktop(),tablet: CreateBannerTablet(),mobile: CreateBannerMobile(),);
  }
}