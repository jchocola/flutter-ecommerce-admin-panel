import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';


class TRouteMiddleware extends GetMiddleware {


  @override
  RouteSettings? redirect(String? route) {
    print('-----Middleware Called------');
    final isAuthenticated = false;
    return isAuthenticated ? null : const RouteSettings(name: TRoutes.login);
  }
}