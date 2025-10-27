import 'package:admin_panel/screens/settings/other_screens/user_activity_screen/controller/user_activity_controller.dart';
import 'package:admin_panel/util/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  //final supabase = Supabase.instance.client;
  static BrandController get instance => Get.find();

  final RxList<BrandModel> brands = <BrandModel>[].obs;
  final RxList<Map<String, dynamic>> allBrands = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filterBrands = <Map<String, dynamic>>[].obs;
  
  final RxBool isLoading = false.obs; // ✅ Add this line

  @override
  void onInit() {
    super.onInit();
   // loadBrands();
  }

  // Future<void> loadBrands() async {
  //   try {
  //     isLoading.value = true; // ✅ Start loading

  //     final response = await supabase
  //         .from('brands')
  //         .select()
  //         .order('created_at', ascending: false);

  //     final parsed = (response as List)
  //         .map((e) => BrandModel.fromJson(e))
  //         .toList();

  //     brands.value = parsed;
  //     allBrands.value = response.cast<Map<String, dynamic>>();
  //     filterBrands.value = allBrands.toList();
  //   } catch (e) {
  //     print("❌ Error fetching brands: $e");
  //   } finally {
  //     isLoading.value = false; // ✅ Stop loading
  //   }
  // }

  void filterBrand(String query) {
    if (query.trim().isEmpty) {
      filterBrands.value = allBrands.toList();
    } else {
      final lower = query.toLowerCase();
      filterBrands.value = allBrands.where((brand) {
        final title = (brand['title'] ?? '').toString().toLowerCase();
        final category = (brand['category'] ?? '').toString().toLowerCase();
        return title.contains(lower) || category.contains(lower);
      }).toList();
    }
  }
  void resetSearch() {
    filterBrands.assignAll(allBrands);
  }
  Future<void> uploadBrand({
    required BuildContext context,
    required String title,
    required String imageUrl,
    required String category,
    required String id,
    required bool isFeatured,
  }) async {
    try {
      // await supabase.from('brands').insert({
      //   'id': id,
      //   'title': title,
      //   'image_url': imageUrl,
      //   'is_featured': isFeatured,
      //   'category': category,
      //   'created_at': DateTime.now().toIso8601String(),
      // });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Brand created successfully')),
      );
         final logController  = Get.put(UserActivityController());

     logController.updateUserLog('Brand', 'Brand Updated');
      Get.back(result: true);
    //  await loadBrands(); // Refresh list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
Future<void> updateBrand({
  required BuildContext context,
  required String id,
  required String title,
  required String imageUrl,
  required String category,
  required bool isFeatured,
}) async {
  try {
    // await supabase.from('brands').update({
    //   'title': title,
    //   'image_url': imageUrl,
    //   'is_featured': isFeatured,
    //   'category': category,
    //   'created_at': DateTime.now().toIso8601String(),  // optional
    // }).eq('id', id);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Brand updated successfully')),
    );

    final logController = Get.put(UserActivityController());
    logController.updateUserLog('Brand', 'Brand Updated');

    Get.back(result: true);
   // await loadBrands();  // Refresh brand list

  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error updating brand: $e')),
    );
  }
}


  Future<void> deleteBrand(String brandID) async {
  try {
    // Delete related categories if necessary



    // Delete the tab itself
    // final deleteTabResponse = await Supabase.instance.client
    //   .from('brands')
    //   .delete()
    //   .eq('id', brandID);

    
    // Check for errors - Supabase flutter returns PostgrestResponse, so errors should be checked like this
    // But if your version does not have response.error, you can check in another way or just trust it

    // Remove from observables
    allBrands.removeWhere((tab) => tab['id'] == brandID);
    filterBrands.removeWhere((tab) => tab['id'] == brandID);
   final logController  = Get.put(UserActivityController());

     logController.updateUserLog('Brands', 'Brand Deleted');
    // Close dialog and notify user
    Get.back();
    Get.snackbar('Success', 'Brand deleted successfully');
  } catch (e) {
    Get.snackbar('Error', 'Exception: $e');
  }
}
}


