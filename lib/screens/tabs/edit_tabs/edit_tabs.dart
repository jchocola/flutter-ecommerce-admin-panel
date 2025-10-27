import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/screens/tabs/edit_tabs/responsive_design/edit_tabs_desktop.dart';
import 'package:admin_panel/screens/tabs/edit_tabs/responsive_design/edit_tabs_mobile.dart';
import 'package:admin_panel/screens/tabs/edit_tabs/responsive_design/edit_tabs_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class EditTabsScreen extends StatefulWidget {
  const EditTabsScreen({super.key});

  @override
  State<EditTabsScreen> createState() => _EditTabsScreenState();
}

class _EditTabsScreenState extends State<EditTabsScreen> {
  String? tabId;
  String? tabTitle;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTabData();
  }

  Future<void> loadTabData() async {
    // final prefs = await SharedPreferences.getInstance();
    // final args = Get.arguments;

    // if (args != null) {
    //   tabId = args['tabId'];
    //   tabTitle = args['tabTitle'];

    //   await prefs.setString('tabId', tabId!);
    //   await prefs.setString('tabTitle', tabTitle!);
    // } else {
    //   // Try to read from cache
    //   tabId = prefs.getString('tabId');
    //   tabTitle = prefs.getString('tabTitle');
    // }

    // if (tabId == null || tabTitle == null) {
    //   Get.snackbar('Error', 'No Tab data found.');
    // }

    // setState(() {
    //   isLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (tabId == null || tabTitle == null) {
      return const Scaffold(body: Center(child: Text('❌ No tab data found.')));
    }

    return TSiteTemplate(
      desktop: EditTabsDesktop(tabId: tabId!, tabTitle: tabTitle!),
      tablet: EditTabsTablet(tabId: tabId!, tabTitle: tabTitle!),
      mobile: EditTabsMobile(tabId: tabId!, tabTitle: tabTitle!),
    );
  }
}
