import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/screens/media/responsive-design/media_desktop_screen.dart';
import 'package:admin_panel/screens/media/responsive-design/media_mobile_scren.dart';
import 'package:admin_panel/screens/media/responsive-design/media_tablet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return const TSiteTemplate(useLayout: true, desktop: MediaDesktopScreen(), tablet: MediaTabletScreen(), mobile: MediaMobileScreen(),);
  }
}