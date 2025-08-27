import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/common/widgets/sidebars/sidebar.dart';
import 'package:admin_panel/screens/layouts/headers/controller/header_controller.dart';
import 'package:admin_panel/screens/layouts/headers/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DesktopLayout extends StatelessWidget {
   DesktopLayout({super.key, this.body});

  final Widget? body;


  @override
  Widget build(BuildContext context) {
    Get.put(HeaderController());
    return Scaffold(
      body: Row(
        children: [
          const Expanded(child: TSidebar()),

          Expanded(
            flex: 5,
            child: Column(
              children: [
                 
                 THeader(),
                
                Expanded(child: body ?? const SizedBox()),
              ],
            ),
          )
        ],
      ),
    );
  }
}