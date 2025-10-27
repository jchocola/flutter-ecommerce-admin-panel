import 'package:admin_panel/screens/layouts/headers/controller/header_controller.dart';
import 'package:admin_panel/screens/settings/other_screens/user_activity_screen/model/user_activity_log_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uuid/uuid.dart';

class UserActivityController  extends GetxController{
  static UserAccountsDrawerHeader get instance => Get.find();


  Future<void> updateUserLog(String type, String value) async {
  //   final supabase= Supabase.instance.client;

  //   final homeController = Get.put(HeaderController());
  //    final currentUser = Supabase.instance.client.auth.currentUser;
  // if (currentUser != null) {
  //   await homeController.getUser(currentUser.email!);

  //   final user = homeController.user.value!;
  

  //   try{
  //     final newRecord = UserActivityLogModel(userID: supabase.auth.currentUser!.id, userRole: user.userRole, userEmail: user.userEmail, updatedType: type, value: value, created_at: DateTime.now(), logID: Uuid().v4());
  //     final  response = await supabase.from('logs').insert(newRecord.toJson());
  //   }catch (e) {
  //     print('🔴🔴🔴 ${e.toString()}');
  //   }

  //   } else {
  //   print('🔴 No authenticated user found.');
  // }
  }
}