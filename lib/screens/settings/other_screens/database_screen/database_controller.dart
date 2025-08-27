import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DatabaseController extends GetxController {
  static DatabaseController get instance => Get.find();

  final TextEditingController urlController = TextEditingController();
  var url = ''.obs;
  final hasUrl = false.obs;
  final TextEditingController anonKeyController = TextEditingController();
  var anonKey = ''.obs;
  final hasAnonKey = false.obs;

  @override
  void onInit() {
    super.onInit();
       urlController.addListener(() {
      hasUrl.value = isUrlChanged();
    });

       anonKeyController.addListener(() {
      hasAnonKey.value = isAnonKeyChanged();
    });
  }
 bool isUrlChanged() {
    return urlController.text != url.value;
  }

   bool isAnonKeyChanged() {
    return anonKeyController.text != anonKey.value;
  }


}
