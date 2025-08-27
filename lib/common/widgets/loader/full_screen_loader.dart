import 'package:admin_panel/util/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TFullScreenLoader {

  static void openLoadingDialog(String text, String animations) {
    showDialog(context: Get.overlayContext!,
    barrierDismissible: false,
    builder: (_) => PopScope(
      canPop: false,
      child: Container(
        color: TColors.dark,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 250,),
            
          ],
        ),
      ),
    ));
  }
  static void popupCircular() {
  Get.defaultDialog(
    title: '',
    onWillPop: () async => false,
    backgroundColor: Colors.transparent
  );
}
}

