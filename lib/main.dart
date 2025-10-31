import 'package:admin_panel/app.dart';
import 'package:admin_panel/controllers/dashboard/dashboard_controller.dart';
import 'package:admin_panel/di.dart';
import 'package:admin_panel/firebase_options.dart';
import 'package:admin_panel/repositories/auth_repository.dart';
import 'package:admin_panel/screens/dashboard/controller/monthly_stats_controller.dart';
import 'package:admin_panel/screens/layouts/headers/controller/header_controller.dart';
import 'package:admin_panel/screens/media/controller/media_controller.dart';
import 'package:admin_panel/screens/products/controller/product_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/create_product_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/product_repositpry.dart';
import 'package:admin_panel/screens/settings/other_screens/set_roles_permission/roles_controller.dart';

import 'package:admin_panel/util/constants/supabase.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import 'package:url_strategy/url_strategy.dart';


  ///
  ///  Logger instance
  ///
var logger = Logger();

Future<void> main() async {
 

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

///
///  Load .env file
///
  await dotenv.load(fileName: ".env");


///
/// Initialize Firebase
///
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  setPathUrlStrategy();


///
///  Setup Dependency Injection
///
  await DI();

  runApp(const App());
}