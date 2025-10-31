import 'package:admin_panel/main.dart';
import 'package:admin_panel/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController  extends GetxController{
  // repository
  final auth_repository = Get.find<AuthRepository>();

  var user = Rx<User?>(null);



  @override
  void onInit() {
    fetchCurrentUser(); 
    super.onInit();

  }


  Future<void> fetchCurrentUser() async {
    try {
      logger.i("Fetching current user");
      User? currentUser = await auth_repository.getCurrentUser();
      user.value = currentUser;
      logger.i('Current user: ${user.value?.email}');
    } catch (e) {
      logger.e('Error fetching current user: $e');
    }
  }
}