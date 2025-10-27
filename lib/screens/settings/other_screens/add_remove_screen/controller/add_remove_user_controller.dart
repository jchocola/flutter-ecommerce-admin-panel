import 'package:admin_panel/screens/settings/other_screens/add_remove_screen/model/add_remove_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';


class AddRemoveUserController extends GetxController {
  static AddRemoveUserController get instance => Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
      final TextEditingController roleController = TextEditingController();
  final RxList<Map<String, dynamic>> users = <Map<String, dynamic>>[].obs;
  //final supabase = Supabase.instance.client;
 final roles = ['Super Admin', 'Store Admin', 'Product Manager', 'Order Manager', 'Marketing Manager'].obs;

  // Selected role (can be initialized with a default)
  final selectedRole = 'Super Admin'.obs;



  Future<void> fetchUsers() async {
    try {
      // final data = await supabase.from('dashboard_users').select();
      // if (data != null && data is List) {
      //   users.value = List<Map<String, dynamic>>.from(data);
      // } else {
      //   Get.snackbar('Error', 'Failed to fetch users');
      // }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }


Future<void> deleteUser(String email) async {
  try {
    // 1. Get the auth user ID based on the email
    // final userRecord = await supabase
    //     .from('dashboard_users')
    //     .select('auth_id')   // or whatever your column storing auth UID
    //     .eq('email', email)
    //     .maybeSingle();

    // if (userRecord == null) {
    //   Get.snackbar('Error', 'User with email $email not found.');
    //   return;
    // }

    // final authUserId = userRecord['auth_id'];

    // // 2. Delete from dashboard_users
    // await supabase
    //     .from('dashboard_users')
    //     .delete()
    //     .eq('email', email);

    // // 3. Delete from Supabase Auth
    // await supabase.auth.admin.deleteUser(authUserId);

    // Get.snackbar('User Deleted', '$email was deleted');
    // fetchUsers();
  } catch (e) {
    print('Delete user error: ${e.toString()}');
    Get.snackbar('Error', 'Failed to delete user');
  }
}


  Future<void> addNewUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final role = selectedRole;

    try {
      // // Check if user exists
      // final existingUsers = await supabase
      //     .from('dashboard_users')
      //     .select('email')
      //     .eq('email', email);

      // if (existingUsers != null && existingUsers.isNotEmpty) {
      //   Get.snackbar('⚠️ Already Exists', 'A user with this email already exists.');
      //   return;
      // }

      // // Insert new user
      // final newUser = AddRemoveModel(
      //   userEmail: email,
      //   userPassword: password,
      //   userRole: role.value,
      //   name: nameController.text,
      //   created_at: DateTime.now().toString(),
      //   signed_in: false
      // );

      // await supabase.from('dashboard_users').insert(newUser.toJson());

      // emailController.clear();
      // passwordController.clear();
      // nameController.clear();
      // Get.snackbar('✅ Success', 'User added successfully');
      // fetchUsers(); // Refresh list after adding user
    } catch (e) {
      Get.snackbar('❌ Error', e.toString());
    }
  }
}
