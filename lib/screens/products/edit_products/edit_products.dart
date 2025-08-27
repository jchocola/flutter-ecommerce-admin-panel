import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/screens/products/controller/product_controller.dart';
import 'package:admin_panel/screens/products/edit_products/responsive_design/edit_products_desktop.dart';
import 'package:admin_panel/screens/products/edit_products/responsive_design/edit_products_mobile.dart';
import 'package:admin_panel/screens/products/edit_products/responsive_design/edit_products_tablet.dart';
import 'package:admin_panel/util/models/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditProductsScreen extends StatelessWidget {
  const EditProductsScreen({super.key});

 @override
Widget build(BuildContext context) {
  final ProductsController productsController = Get.find();

  ProductModel? product;

  if (Get.arguments != null) {
    try {
      product = ProductModel.fromJson(Get.arguments);
      productsController.setProduct(Get.arguments);
    } catch (_) {}
  }

  // Try loading from storage
  product ??= productsController.selectedProduct.value;
  if (product == null) {
    productsController.loadSelectedProduct();
    product = productsController.selectedProduct.value;
  }

  if (product == null) {
    return const Scaffold(
      body: Center(child: Text('❌ No product data available.')),
    );
  }

  return TSiteTemplate(
    desktop: EditProductsDesktop(productModel: product),
    tablet: EditProductsTablet(productModel: product),
    mobile: EditProductsMobile(productModel: product),
  );
}

}
