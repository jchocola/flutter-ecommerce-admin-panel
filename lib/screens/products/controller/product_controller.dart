import 'package:admin_panel/util/models/product_model/product_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsController extends GetxController {
  static ProductsController get instance => Get.find();

  final RxList<Map<String, dynamic>> allProducts = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredProducts =
      <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<bool> deleteProduct(String id) async {
    final supabase = Supabase.instance.client;

    try {
      final response = await supabase.from('products').delete().eq('id', id);

      if (response.error != null) {
        print('Delete Failed 🔴: ${response.error!.message}');
        return false;
      }

      print('Product deleted ✅');
      return true;
    } catch (e) {
      print('Error 🔴🔴🔴 ${e.toString()}');
      return false;
    }
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    try {
      final data = await Supabase.instance.client.from('products').select();
      final fetched = List<Map<String, dynamic>>.from(data);
      allProducts.assignAll(fetched);
      filteredProducts.assignAll(fetched);
    } catch (e) {
      print('❌ Error fetching products: $e');
      allProducts.clear();
      filteredProducts.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void filterProductsByTitle(String query) {
    final search = query.trim().toLowerCase();
    if (search.isEmpty) {
      filteredProducts.assignAll(allProducts);
    } else {
      filteredProducts.assignAll(
        allProducts.where((product) {
          final title = (product['title'] ?? '').toString().toLowerCase();
          return title.contains(search);
        }).toList(),
      );
    }
  }

  void resetSearch() {
    filteredProducts.assignAll(allProducts);
  }

  final Rxn<ProductModel> selectedProduct = Rxn<ProductModel>();
  final storage = GetStorage();

  void setProduct(Map<String, dynamic> productData) {
    final product = ProductModel.fromJson(productData);
    selectedProduct.value = product;

    // Persist to local storage
    storage.write('selected_product', productData);
  }

  void loadSelectedProduct() {
    final data = storage.read('selected_product');
    if (data != null) {
      selectedProduct.value = ProductModel.fromJson(data);
    }
  }

  Future<ProductModel> fetchProductById(String id) async {
    final supabase = Supabase.instance.client;
    final response =
        await supabase.from('products').select().eq('id', id).single();
    return ProductModel.fromJson(response);
  }
}
