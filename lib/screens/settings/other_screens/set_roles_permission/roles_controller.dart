import 'package:admin_panel/screens/layouts/headers/controller/header_controller.dart';
import 'package:get/get.dart';


class RolesController extends GetxController {
  static RolesController get instance => Get.find();

 // final supabase = Supabase.instance.client;

  // Observable list of users fetched from Supabase
  final users = <Map<String, dynamic>>[].obs;

  final roles = [
    'Super Admin',
    'Store Admin',
    'Product Manager',
    'Order Manager',
    'Marketing Manager',
  ];

  // Map email -> selected role
  final selectedRoles = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
  try {
    // final data = await supabase
    //     .from('dashboard_users')
    //     .select('email, role, created_at, name, created_at');

    // // data is List<dynamic>
    // users.value = (data as List).cast<Map<String, dynamic>>();

    // // Initialize selectedRoles from fetched data
    // for (var user in users) {
    //   final email = user['email'] as String?;
    //   final name = user['name'] as String?;

    //   final role = user['role'] as String? ?? roles.first;
    //   if (email != null) {
    //     selectedRoles[email] = role;
    //   }
    //   final headerController = Get.put(HeaderController());
    //   headerController.getUser(email!);
    // }
  } catch (e) {
    Get.snackbar('Error', e.toString());
  }
}


Future<void> updateRole(String role, String email) async {
  try{
    // final updateRole = await supabase.from('dashboard_users').update({'role' : role}).eq('email', email);

    // Get.snackbar('✅ Updated', '$role updated');
  }catch (e) {
    print('🔴🔴🔴🔴 ${e.toString()}');
  }
}

  void updateUserRole(String email, String newRole) {
    selectedRoles[email] = newRole;
    int index = users.indexWhere((u) => u['email'] == email);
    if (index != -1) {
      users[index]['role'] = newRole;
      updateRole(newRole, email);
      users.refresh();
    }
  }
}
