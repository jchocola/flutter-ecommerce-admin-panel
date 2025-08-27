import 'package:admin_panel/common/responsive/screens/desktop_layout.dart';
import 'package:admin_panel/common/responsive/screens/mobile_layout.dart';
import 'package:admin_panel/common/responsive/screens/tablet_layout.dart';
import 'package:admin_panel/screens/dashboard/responsive_screens/dashboard_desktop.dart';
import 'package:admin_panel/screens/dashboard/responsive_screens/desktop_mobile.dart';
import 'package:admin_panel/screens/dashboard/responsive_screens/desktop_tablet.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;
      if (session == null) {
      Future.microtask(() => Get.offAllNamed(TRoutes.login));
      return const SizedBox();
    }
    return TSiteTemplate(useLayout: false, desktop: DesktopLayout(body: DashboardDesktopScreen(),), tablet: TabletLayout(body: DashBoardTabletScreen(),), mobile:  MobileLayout(body: DashBoardMobileScreen(),),);
  }
}