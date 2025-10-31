import 'package:admin_panel/main.dart';
import 'package:admin_panel/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  // repository
  final auth_repository = Get.find<AuthRepository>();

  var user = Rx<User?>(null);
  var isLoading = false.obs;

  @override
  void onInit()async {
     await fetchCurrentUser();
    super.onInit();
    
  }

  Future<void> fetchCurrentUser() async {
    try {
      isLoading.value = true;
      logger.i("Fetching current user");
      User? currentUser = await auth_repository.getCurrentUser();
      user.value = currentUser;
      logger.i('Current user: ${user.value?.email}');
    } catch (e) {
      logger.e('Error fetching current user: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      logger.i("Attempting login for $email");
      User? loggedInUser = await auth_repository.signInWithEmail(
        email,
        password,
      );
      //fetchCurrentUser();
      user.value = loggedInUser;
      logger.i('Login successful: ${user.value?.email}');

      update();
    } catch (e) {
      logger.e('Login failed: $e');
      rethrow;
    }
  }


  Future<void> logout() async {
    try {
      logger.i("Attempting logout");
      await auth_repository.signOut();
      user.value = null;
      logger.i('Logout successful');
      update();
    } catch (e) {
      logger.e('Logout failed: $e');
      rethrow;
    }
  }
}
