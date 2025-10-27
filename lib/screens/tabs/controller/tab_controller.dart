import 'package:admin_panel/screens/settings/other_screens/user_activity_screen/controller/user_activity_controller.dart';
import 'package:get/get.dart';


class TabsController extends GetxController {
  static TabsController get instance => Get.find();

  var allTabs = <Map<String, dynamic>>[].obs;
  var filteredTabs = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
final void Function()? onRefresh;

  TabsController({this.onRefresh});

  @override
  void onInit() {
    super.onInit();
    fetchTabs();
  }

  Future<void> fetchTabs() async {
    try {
      // isLoading.value = true;
      // final tabsResponse = await Supabase.instance.client
      //     .from('tab_config')
      //     .select('id, title, created_at')
      //     .order('created_at', ascending: false);

      // List<Map<String, dynamic>> tabs = List<Map<String, dynamic>>.from(tabsResponse);

      // // Fetch categories for each tab
      // for (var tab in tabs) {
      //   final tabId = tab['id'];
      //   final categoriesResponse = await Supabase.instance.client
      //       .from('tab_categories')
      //       .select('title')
      //       .eq('tab_id', tabId);

      //   tab['categories'] = List<String>.from(
      //     categoriesResponse.map<String>((c) => c['title']?.toString() ?? ''),
      //   );
      // }

      // allTabs.value = tabs;
      // filteredTabs.value = tabs;
    } catch (e) {
      print('Error fetching tabs: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void filterTabs(String query) {
    if (query.trim().isEmpty) {
      filteredTabs.value = allTabs.toList();
    } else {
      final lowerQuery = query.toLowerCase();
      filteredTabs.value = allTabs.where((tab) {
        final title = (tab['title']?.toString() ?? '').toLowerCase();
        final categories = (tab['categories'] as List<String>?)
                ?.join(' ')
                .toLowerCase() ??
            '';
        return title.contains(lowerQuery) || categories.contains(lowerQuery);
      }).toList();
    }
  }
void resetSearch() {
  if (allTabs.isNotEmpty) {
    filteredTabs.assignAll(allTabs);
    fetchTabs();
  } else {
    print("Warning: allTabs is empty.");
  }
}

Future<void> deleteTab(String tabId) async {
  try {
    // Delete related categories if necessary
  //   final deleteCategoriesResponse = await Supabase.instance.client
  //     .from('tab_categories')
  //     .update({'tab_id' : null})
  //     .eq('tab_id', tabId);

  //   // Delete the tab itself
  //   final deleteTabResponse = await Supabase.instance.client
  //     .from('tab_config')
  //     .delete()
  //     .eq('id', tabId);

  //     final deleteProductsTabs = await Supabase.instance.client
  //     .from('products')
  //     .update({'home_tab_id' : null})
  //     .eq('home_tab_id', tabId);
  //   // Check for errors - Supabase flutter returns PostgrestResponse, so errors should be checked like this
  //   // But if your version does not have response.error, you can check in another way or just trust it

  //   // Remove from observables
  //   allTabs.removeWhere((tab) => tab['id'] == tabId);
  //   filteredTabs.removeWhere((tab) => tab['id'] == tabId);
  //  final logController  = Get.put(UserActivityController());

  //    logController.updateUserLog('Tab', 'Tab Deleted');
  //   // Close dialog and notify user
  //   Get.back();
  //   Get.snackbar('Success', 'Tab deleted successfully');
  } catch (e) {
    Get.snackbar('Error', 'Exception: $e');
  }
}


}
