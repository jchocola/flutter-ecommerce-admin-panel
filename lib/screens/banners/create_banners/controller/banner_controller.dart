import 'package:admin_panel/screens/settings/other_screens/user_activity_screen/controller/user_activity_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/models/banner_model.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uuid/uuid.dart';

class BannerController extends GetxController {
  //final supabase = Supabase.instance.client;
  final uuid = const Uuid();

  final RxList<BannerModel> banners = <BannerModel>[].obs;
  final RxBool isLoading = false.obs; // ✅ Add this
  var selectedLocation = 'search'.obs;
  RxnString selectedProductId = RxnString(null);
    RxnString selectedCateogryID = RxnString(null);


  @override
  void onInit() {
    super.onInit();
   // fetchBanners();
    fetchCategories();
  }

  // Future<void> fetchBanners() async {
  //   try {
  //     isLoading.value = true; // ✅ Start loading

  //     final response = await supabase
  //         .from('banners')
  //         .select()
  //         .order('created_at', ascending: false);

  //     banners.value =
  //         (response as List).map((item) => BannerModel.fromJson(item)).toList();

  //     print("✅ Fetched ${banners.length} banners.");
  //   } catch (e) {
  //     print('❌ Failed to fetch banners: $e');
  //   } finally {
  //     isLoading.value = false; // ✅ End loading
  //   }
  // }

  
Future<void> updateBanner({
  required BuildContext context,
  required String bannerId,    // <-- existing banner ID
  required String imageUrl,
  required bool isActive,
  required String location,
}) async {
  if (imageUrl.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('⚠️ Please provide image and location')),
    );
    return;
  }

  final updatedBanner = {
    'image_url': imageUrl,
    'location': location,
    'is_active': isActive,
    'value': selectedLocation.value.toString(),
    'redirect_screen': (selectedLocation.value == 'products')
        ? (selectedProductId.value ?? '')
        : 'No',
    'created_at': DateTime.now().toIso8601String(), // optional tracking
  };

  try {
    // await supabase
    //     .from('banners')
    //     .update(updatedBanner)
    //     .eq('id', bannerId); // important: WHERE id = bannerId

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Banner updated successfully')),
    );

   // await fetchBanners(); // Refresh list
  } catch (e) {
    print('❌ Supabase Banner Update Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('❌ Failed to update banner')),
    );
  }
}

  Future<void> uploadBanner({
    required BuildContext context,
    required String imageUrl,
    required bool isActive,
    required String location,
  }) async {
    if (imageUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('⚠️ Please provide image and location')),
      );
      return;
    }

    final bannerId = uuid.v4();

    final newBanner = BannerModel(
      id: bannerId,
      createdAt: DateTime.now(),
      imageUrl: imageUrl,
      location: location,
      isActive: isActive,
      value: selectedLocation.value.toString(),
      redirectScreen:
          (selectedLocation.value == 'products')
              ? (selectedProductId.value ?? '')
              : 'No',
            
    );

    try {
     // await supabase.from('banners').insert(newBanner);

     Get.snackbar('Banner Updated', 'Banner Successfully uploaded',backgroundColor: TColors.primary, colorText: Colors.white);

     final logController  = Get.put(UserActivityController());

     logController.updateUserLog('Banners', 'Uploaded Banner');
     


    //  await fetchBanners(); // Refresh list

      Get.offAllNamed(TRoutes.banners);
      

    } catch (e) {
      print('Supabase Banner Upload Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Failed to upload banner')),
      );
    }
  }

  var products = <Map<String, dynamic>>[].obs;

  Future<void> fetchProducts() async {
    try {
      // final response = await supabase
      //     .from('products')
      //     .select()
      //     .order('created_at', ascending: false);
      // if (response != null) {
      //   products.value = List<Map<String, dynamic>>.from(response);
      // } else {
      //   products.clear();
      // }
    } catch (e) {
      print('Error fetching products: $e');
      products.clear();
    }
  }

    var categories = <Map<String, dynamic>>[].obs;

  Future<void> fetchCategories() async {
    try {
      // final response = await supabase
      //     .from('tab_categories')
      //     .select()
      //     .order('created_at', ascending: false);
      // if (response != null) {
      //   categories.value = List<Map<String, dynamic>>.from(response);
      // } else {
      //   categories.clear();
      // }
    } catch (e) {
      print('Error fetching categories: $e');
      categories.clear();
    }
  }


  Future<void> deleteBanner(String bannerID) async {
   // final supabase = Supabase.instance.client;

    try {
      // final response = await supabase.from('banners').delete().eq('id', bannerID);

      // fetchBanners();

Get.back();
      Get.snackbar('Banner Deleted', 'you have successfully deleted banner', backgroundColor: TColors.primary, colorText: Colors.white);
    }catch (e) {
      print(('🔴🔴🔴 ${e.toString()}'));
    }
  }
}
