import 'package:admin_panel/controllers/category_controller.dart';
import 'package:admin_panel/controllers/dashboard/dashboard_controller.dart';
import 'package:admin_panel/controllers/user_controller.dart';
import 'package:admin_panel/repositories/auth_repository.dart';
import 'package:admin_panel/repositories/category_repository.dart';
import 'package:admin_panel/screens/dashboard/controller/monthly_stats_controller.dart';
import 'package:admin_panel/screens/layouts/headers/controller/header_controller.dart';
import 'package:admin_panel/screens/media/controller/media_controller.dart';
import 'package:admin_panel/screens/products/controller/product_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/create_product_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/product_repositpry.dart';
import 'package:admin_panel/screens/settings/other_screens/set_roles_permission/roles_controller.dart';
import 'package:get/get.dart';

Future<void> DI() async {
  Get.put(ProductRepositpry()); // 👈 Register here
  Get.lazyPut(() => CreateProductController());

  //Get.lazyPut(() => TabsController());

  // repositories
  Get.lazyPut(() => AuthRepository.instance);
  Get.lazyPut(() => CategoryRepository());

  // controllers
  Get.lazyPut(() => UserController());
  Get.lazyPut(()=> CategoryController());

  Get.lazyPut(() => MediaController());
  Get.lazyPut(() => ProductsController());
  Get.lazyPut(() => RolesController());
  Get.lazyPut(() => HeaderController());
  Get.lazyPut(() => MonthlyStatsController());

  Get.put(MediaController());

  Get.lazyPut(() => DashboardController());
}
