import 'package:admin_panel/screens/layouts/headers/controller/header_controller.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/screens/products/all_products/responsive_design/products_desktop.dart';
import 'package:admin_panel/screens/products/all_products/responsive_design/products_mobile.dart';
import 'package:admin_panel/screens/products/all_products/responsive_design/products_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
   final controller = Get.find<HeaderController>();


@override
void initState() {
  super.initState();
  _loadCurrentUser();
}

void _loadCurrentUser() async {
  // final currentUser = Supabase.instance.client.auth.currentUser;
  // if (currentUser != null) {
  //   await controller.getUser(currentUser.email!);
  // } else {
  //   print('🔴 No authenticated user found.');
  // }
}
  @override
  Widget build(BuildContext context) {

    final user = controller.user.value;

    if(user?.userRole=='Order Manager' && user?.userRole=='Marketing Manager') {
      return TSiteTemplate(desktop: Center(child: Text('You dont have persmission to manage products')),);
    } else {
    return TSiteTemplate(desktop: ProductsDesktop(), tablet: const ProductsTablet(), mobile: const ProductsMobile(),);

    }

  }
}