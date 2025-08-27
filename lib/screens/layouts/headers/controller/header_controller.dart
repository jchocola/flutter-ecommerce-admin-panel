import 'package:admin_panel/screens/settings/other_screens/add_remove_screen/model/add_remove_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HeaderController extends GetxController {
  static HeaderController get instance => Get.find();

  final user = Rxn<AddRemoveModel>();
  final supabase = Supabase.instance.client;

  @override
  void onInit() {
    super.onInit();
   
  }

  Future<void> getUser(String email) async {
    final storage = GetStorage();
    try {
     
     
     print('asad ${storage.read('email')}');

      final response = await supabase
          .from('dashboard_users')
          .select()
          .eq('email', storage.read('email'))
          .maybeSingle();

      if (response != null) {
        user.value = AddRemoveModel.fromJson(response);
        print('🟢 User Loaded: ${user.value!.userRole}');
        print('email ${user.value!.userEmail}');
      } else {
        print('🟡 No user found for $email');
      }
    } catch (e) {
      print('🔴 Error loading user: ${e.toString()}');
    }
  }
}
