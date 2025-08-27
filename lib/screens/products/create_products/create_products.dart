import 'package:admin_panel/screens/layouts/headers/controller/header_controller.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/screens/products/create_products/responsive_design/create_products_desktop.dart';
import 'package:admin_panel/screens/products/create_products/responsive_design/create_products_mobile.dart';
import 'package:admin_panel/screens/products/create_products/responsive_design/create_products_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateProductsScreen extends StatefulWidget {
  const CreateProductsScreen({super.key});

  @override
  State<CreateProductsScreen> createState() => _CreateProductsScreenState();
}

class _CreateProductsScreenState extends State<CreateProductsScreen> {
     final controller = Get.find<HeaderController>();


@override
void initState() {
  super.initState();
  _loadCurrentUser();
}

void _loadCurrentUser() async {
  final currentUser = Supabase.instance.client.auth.currentUser;
  if (currentUser != null) {
    await controller.getUser(currentUser.email!);
  } else {
    print('🔴 No authenticated user found.');
  }
}
  @override
  Widget build(BuildContext context) {

    final user = controller.user.value;

    if(user?.userRole=='Order Manager' && user?.userRole=='Marketing Manager') {
      return TSiteTemplate(desktop: Center(child: Text('You dont have persmission to create products')),);

    } else {
    return const TSiteTemplate(desktop: CreateProductsDesktop(), tablet: CreateProductsTablet(), mobile: CreateProductsMobile(),);

    }
  }
}