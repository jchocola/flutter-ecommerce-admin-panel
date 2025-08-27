import 'package:admin_panel/screens/settings/other_screens/user_activity_screen/controller/user_activity_controller.dart';
import 'package:admin_panel/util/models/category_model.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final supabase = Supabase.instance.client;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;

    var filterCategories = <Map<String, dynamic>>[].obs;
  var allCategories = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  final void Function()? onRefresh;
/// Updates an existing category in Supabase using the CategoryModel
/// 
/// 
/// 
/// 
  Future<void> loadCategories() async {
    try {
      final response = await Supabase.instance.client
          .from('tab_config')
        .select()
        .eq('is_active', true)
        .eq('tab_location', 'store')
        .order('order', ascending: true);

      categories.value = response
          .map((json) => CategoryModel.fromJson(json))
          .toList();
print('📦 Supabase raw response: $response');
print('✅ Categories loaded: ${categories.length}');

      print('✅ Loaded ${categories.length} categories');
    } catch (e) {
      print('❌ Error fetching categories: $e');
    }
  }

CategoryController({this.onRefresh});
   @override
  void onInit() {
    super.onInit();
    fetchCategories();
  //  loadCategories();
  }
Future<void> updateCategory({
  required BuildContext context,
  required String id,      // ID of the category to update
  required String title,
  required bool isIcon,
  required String imageUrl,
  required String tabId,
}) async {
  if (id.trim().isEmpty || title.trim().isEmpty || imageUrl.trim().isEmpty || tabId.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('⚠️ ID, title, image, and tab selection are required')),
    );
    return;
  }

  final updatedCategory = CategoryModel(
    id: id,            // Keep existing ID
    tab_id: tabId,
    title: title,
    isIcon: isIcon,
    imageUrl: imageUrl,
    createdAt: DateTime.now(), // Or updatedAt if you track update time separately
  );

  try {
    await supabase
        .from('tab_categories')
        .update(updatedCategory.toJson())
        .eq('id', id);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Category updated')),
    );
       final logController  = Get.put(UserActivityController());

     logController.updateUserLog('Category', 'Category Updated');
    Get.back(result: true);  // Return true to caller on successful update

  } catch (e) {
    print('Supabase Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('❌ Failed to update category')),
    );
  }
}
Future<void> deleteCategory(String tabId) async {
  try {
    // Delete related categories if necessary
    final deleteCategoriesResponse = await Supabase.instance.client
      .from('tab_categories')
      .delete()
      .eq('id', tabId);

   

    // Check for errors - Supabase flutter returns PostgrestResponse, so errors should be checked like this
    // But if your version does not have response.error, you can check in another way or just trust it

    // Remove from observables
    allCategories.removeWhere((tab) => tab['id'] == tabId);
    filterCategories.removeWhere((tab) => tab['id'] == tabId);
       final logController  = Get.put(UserActivityController());

     logController.updateUserLog('Category', 'Category Deleted');
    // Close dialog and notify user
    Get.back();
    Get.snackbar('Success', 'Tab deleted successfully');
  } catch (e) {
    Get.snackbar('Error', 'Exception: $e');
  }
}
  /// Uploads a new category to Supabase using the CategoryModel
  Future<void> uploadCategory({
    required BuildContext context,
    required String title,
    required bool isIcon,
    required String imageUrl,
    required String tabId, // now required for category linking
  }) async {
    if (title.trim().isEmpty || imageUrl.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('⚠️ Title, image are required')),
      );
      return;
    }

    final category = CategoryModel(
      id: Uuid().v4(),       // Generate unique ID
      tab_id: tabId,         // Use the passed tabId here
      title: title,
      isIcon: isIcon,
      imageUrl: imageUrl,
      createdAt: DateTime.now(),
    );

    try {
      await supabase.from('tab_categories').insert(category.toJson());
      

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Category uploaded')),
      );
         final logController  = Get.put(UserActivityController());
         Get.offAllNamed(TRoutes.categories);

     logController.updateUserLog('Category', 'Category Uploaded');
    } catch (e) {
      print('Supabase Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Failed to upload category')),
      );
    }
 
  }

  

Future<void> fetchCategories() async {
  try {
    isLoading.value = true;

    final response = await supabase
        .from('tab_categories')
        .select()
        .order('created_at', ascending: false);

    final categoryList = (response as List)
        .map((item) => CategoryModel.fromJson(item))
        .toList();

    categories.value = categoryList;
    allCategories.value = response.cast<Map<String, dynamic>>();
    filterCategories.value = allCategories.toList();
  } catch (e) {
    print('❌ Error fetching categories: $e');
  } finally {
    isLoading.value = false; // ✅ make sure it's turned off no matter what
  }
}



void filterCategory(String query) {
  if (query.trim().isEmpty) {
    filterCategories.value = allCategories.toList();
  } else {
    final lowerQuery = query.toLowerCase();
    filterCategories.value = allCategories.where((cat) {
      final title = (cat['title'] ?? '').toString().toLowerCase();
      return title.contains(lowerQuery);
    }).toList();
  }
}
  void resetSearch() {
    filterCategories.assignAll(allCategories);
  }

}
