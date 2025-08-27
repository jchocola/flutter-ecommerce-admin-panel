import 'package:admin_panel/util/models/product_model/product_category_model.dart';
import 'package:admin_panel/util/models/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepositpry extends GetxController {
  static ProductRepositpry get instance => Get.find();

  final supabase = Supabase.instance.client;
Future<void> deleteProductCategories(String productId) async {
  try {
    final response = await supabase
        .from('product_categories')
        .delete()
        .eq('product_id', productId);

    if (response.error != null) {
      print('Error deleting product categories: ${response.error!.message}');
    }
  } catch (e) {
    print('Exception in deleteProductCategories: $e');
  }
}

Future<String> uploadProduct(ProductModel product) async {
  final supabase = Supabase.instance.client;

  final response = await supabase
      .from('products')
      .insert(product.toJson())
      .select('id') // return inserted id
      .single();

  return response['id'];
}
Future<String> updateProduct(ProductModel product) async {
  final supabase = Supabase.instance.client;
print('➡️ product.id: ${product.id}');
print('➡️ product.id type: ${product.id.runtimeType}');

  if (product.id == null || product.id!.isEmpty) {
    throw Exception('❌ Product ID is null or empty. Cannot update.');
  }

  print('📦 Payload to update: ${product.toJson()}');
  print('🆔 Updating product with ID: ${product.id}');

  final response = await supabase
      .from('products')
      .update(product.toJson())
      .eq('id', product.id!) // Safe because we checked above
      .select('id')
      .single();

      Get.back(result: true);

  return response['id'];
}



Future<void> uploadProductCategory(ProductCategoryModel model) async {
  final supabase = Supabase.instance.client;

  try {
    await supabase.from('product_categories').insert([model.toJson()]);

    print('✅ Product-Category link uploaded');
  } catch (e) {
    print('❌ Upload failed: $e');
  }
}


}