// import 'package:admin_panel/common/widgets/sidebars/sidebar_controller.dart';
// import 'package:admin_panel/util/routes/routes.dart';
// import 'package:flutter/src/widgets/navigator.dart';
// import 'package:get/get.dart';

// class RouteObservers extends GetObserver {
//   @override
//   void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
//   final sideBarController = Get.put(SidebarController());

//   if(previousRoute != null) {
//     for (var routename in TRoutes.sideMenuItems) {
//       if (previousRoute.settings.name == routeName) {
//         sideBarController.activeItem.value = routeName;
//       }
//     }
//   }
//   }


//   @override
//   void didPush(Route<dynamic>? route, Route<dynamic>? previousRoute) {
//     // TODO: implement didPush
//     if(route != null) {
//       for(var routeName in TRoutes.sideMenuItems)
//     }
//   }
// }