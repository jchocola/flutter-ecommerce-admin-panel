import 'package:admin_panel/util/models/app_config_model.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';


class ProductSettingsController extends GetxController {
  var enableproductreview = false.obs;
  var allowverifiedreviewonly = false.obs;
  var allowGuestReview = false.obs;
  var feeStructureOption = false.obs;

  //Shipping Settings
  final TextEditingController shippingCostInDistrictController =
      TextEditingController();
  final TextEditingController shippingCostOutOfDistrictController =
      TextEditingController();
  // Reactive shipping cost value
  var outOfDistrictText = ''.obs;
  var inDistrictText = ''.obs;

  //Delivery Settings
  final TextEditingController deliveryOutOfDistrictController =
      TextEditingController();
  final TextEditingController deliveryInDistrictController =
      TextEditingController();
  // Reactive shipping cost value
  var outOfDistrictTextDelivery = ''.obs;
  var inDistrictTextDelivery = ''.obs;
  var hasShippingChanged = false.obs;

  var hasDeliveryChanged = false.obs;


final Rx<String?> selectedFeeStructure = Rx<String?>(null);  // null means no offer selected

  @override
  void onInit() {
    super.onInit();

    // Fetch initial values
    getExistingShippingValues();
    getExistingDeliveryValue();

    getExistingFeeStructure();

    // Track changes for "In District"
    shippingCostInDistrictController.addListener(() {
      hasShippingChanged.value = _isShippingChanged();
    });

    // Track changes for "Out of District"
    shippingCostOutOfDistrictController.addListener(() {
      hasShippingChanged.value = _isShippingChanged();
    });

    deliveryInDistrictController.addListener(() {
      hasDeliveryChanged.value = isDeliveryChanged();
    });

    // Track changes for "Out of District"
    deliveryOutOfDistrictController.addListener(() {
      hasDeliveryChanged.value = isDeliveryChanged();
    });
  }

  bool _isShippingChanged() {
    return shippingCostInDistrictController.text != inDistrictText.value ||
        shippingCostOutOfDistrictController.text != outOfDistrictText.value;
  }

  bool isDeliveryChanged() {
    return deliveryInDistrictController.text != inDistrictTextDelivery.value ||
        deliveryOutOfDistrictController.text != outOfDistrictTextDelivery.value;
  }

  Future<bool> checkToggleButtons(String title) async {
    // final supabase = Supabase.instance.client;

    // final data =
    //     await supabase
    //         .from('app_config')
    //         .select()
    //         .eq('title', title)
    //         .maybeSingle();

    // if (data != null) {
    //   return data['value'] == 'true';
    // }
    return false;
  }

  Future<void> updateProcessingFeeStructure(String value)async {
   // final supabase = Supabase.instance.client;

  //  await supabase.from('app_config').upsert({
  //     'title': 'Processing Fee Structure',
  //     'value': value,
  //     'description': 'Toggle setting for Processing Fee Structure',
  //     'created_at': DateTime.now().toIso8601String(),
  //   }, onConflict: 'title');
  }

  Future<void> updateToggleSetting(String title, String value) async {
    // final supabase = Supabase.instance.client;

    // await supabase.from('app_config').upsert({
    //   'title': title,
    //   'value': value,
    //   'description': 'Toggle setting for $title',
    //   'created_at': DateTime.now().toIso8601String(),
    // }, onConflict: 'title');
  }

   Future<void> getExistingFeeStructure() async {
  //   final supabase = Supabase.instance.client;

  //   final feeStructure =
  //       await supabase
  //           .from('app_config')
  //           .select()
  //           .eq('title', 'Processing Fee Structure')
  //           .maybeSingle();

  //   if (feeStructure != null) {
  //     final value = feeStructure['value'] ?? '';
  // //    feeStructureOption = value;
  //     selectedFeeStructure.value = value;
  //   }

   
  }

  Future<void> getExistingShippingValues() async {
    // final supabase = Supabase.instance.client;

    // final inDistrict =
    //     await supabase
    //         .from('app_config')
    //         .select()
    //         .eq('title', 'shippingCostInDistrict')
    //         .maybeSingle();

    // final outDistrict =
    //     await supabase
    //         .from('app_config')
    //         .select()
    //         .eq('title', 'shippingCostOutOfDistrict')
    //         .maybeSingle();

    // if (inDistrict != null) {
    //   final value = inDistrict['value'] ?? '';
    //   shippingCostInDistrictController.text = value;
    //   inDistrictText.value = value;
    // }

    // if (outDistrict != null) {
    //   final value = outDistrict['value'] ?? '';
    //   shippingCostOutOfDistrictController.text = value;
    //   outOfDistrictText.value = value;
    // }

    // hasShippingChanged.value = false;
  }

Future<void> getExistingDeliveryValue() async {
  // final supabase = Supabase.instance.client;

  // final existingDeliveryInDistrict =
  //     await supabase
  //         .from('app_config')
  //         .select()
  //         .eq('title', 'deliveryInDistrict')
  //         .maybeSingle();

  // final existingDeliveryOutDistrict =
  //     await supabase
  //         .from('app_config')
  //         .select()
  //         .eq('title', 'deliveryOutDistrict')
  //         .maybeSingle();

  // if (existingDeliveryInDistrict != null) {
  //   final value = existingDeliveryInDistrict['value'] ?? '';
  //   deliveryInDistrictController.text = value;
  //   inDistrictTextDelivery.value = value;
  // }

  // if (existingDeliveryOutDistrict != null) {
  //   final value = existingDeliveryOutDistrict['value'] ?? '';
  //   deliveryOutOfDistrictController.text = value;
  //   outOfDistrictTextDelivery.value = value;
  // }

  // hasDeliveryChanged.value = false;
}


  Future<void> updateDeliverySettings(
    String deliveryInDistrict,
    String deliveryOutOfDistrict,
  ) async {
   // final supabase = Supabase.instance.client;

    final newDeliveryInDistrict = AppConfigModel(
      title: 'deliveryInDistrict',
      value: deliveryInDistrict,
      description: 'Delivery Time in District',
      created_at: DateTime.now().toString(),
    );

    final newDeliveryOutOfDistrict = AppConfigModel(
      title: 'deliveryOutDistrict',
      value: deliveryOutOfDistrict,
      description: 'Delivery Time out of District',
      created_at: DateTime.now().toString(),
    );

    try {
      // final existingDeliveryOutOfDistrict =
      //     await supabase
      //         .from('app_config')
      //         .select()
      //         .eq('title', 'deliveryOutDistrict')
      //         .maybeSingle(); //

      // final existingDeliveryInDistrict =
      //     await supabase
      //         .from('app_config')
      //         .select()
      //         .eq('title', 'deliveryInDistrict')
      //         .maybeSingle(); //

      // if (existingDeliveryOutOfDistrict == null) {
      //   await supabase
      //       .from('app_config')
      //       .insert(newDeliveryOutOfDistrict.toJson());
      // } else {
      //   await supabase
      //       .from('app_config')
      //       .update({'value': deliveryOutOfDistrict.toString()})
      //       .eq('title', 'deliveryOutDistrict');
      // }

      // if (existingDeliveryInDistrict == null) {
      //   await supabase
      //       .from('app_config')
      //       .insert(newDeliveryInDistrict.toJson());
      // } else {
      //   await supabase
      //       .from('app_config')
      //       .update({'value': deliveryInDistrict.toString()})
      //       .eq('title', 'deliveryInDistrict');
      // }
      // discardChangesDelivery(deliveryInDistrict, deliveryOutOfDistrict);
    } catch (e) {
      print('🔴🔴🔴🔴 ${e.toString()}');
    }
  }

  Future<void> updateShippingSettings(
    String shippingCostOutOfDistrict,
    String shippingCostInOfDistrict,
  ) async {
   // final supabase = Supabase.instance.client;

    // Create model
    final newConfigShippingCostOutOfDistrict = AppConfigModel(
      title: 'shippingCostOutOfDistrict',
      value: shippingCostOutOfDistrict,
      description: 'Shipping Cost for Out of District',
      created_at: DateTime.now().toIso8601String(),
    );

    final newConfigShippingCostInOfDistrict = AppConfigModel(
      title: 'shippingCostInDistrict',
      value: shippingCostInOfDistrict,
      description: 'Shipping Cost for in District',
      created_at: DateTime.now().toIso8601String(),
    );

    try {
      // final existingShippingCostOutOfDistrict =
      //     await supabase
      //         .from('app_config')
      //         .select()
      //         .eq('title', 'shippingCostOutOfDistrict')
      //         .maybeSingle(); // Returns null if not found

      // if (existingShippingCostOutOfDistrict == null) {
      //   await supabase
      //       .from('app_config')
      //       .insert(newConfigShippingCostOutOfDistrict.toJson());
      // } else {
      //   await supabase
      //       .from('app_config')
      //       .update({'value': shippingCostOutOfDistrict.toString()})
      //       .eq('title', 'shippingCostOutOfDistrict');
      // }

      // // ✅ Must use .toJson()
      // final existingShippingCostInDistrict =
      //     await supabase
      //         .from('app_config')
      //         .select()
      //         .eq('title', 'shippingCostInDistrict')
      //         .maybeSingle(); // Returns null if not found

      // if (existingShippingCostInDistrict == null) {
      //   await supabase
      //       .from('app_config')
      //       .insert(newConfigShippingCostInOfDistrict.toJson());
      // } else {
      //   await supabase
      //       .from('app_config')
      //       .update({'value': shippingCostInOfDistrict.toString()})
      //       .eq('title', 'shippingCostInDistrict');
      // }
      // discardChangesShipping(shippingCostInOfDistrict, shippingCostOutOfDistrict);
      print('Shipping config inserted successfully.');
    } catch (error) {
      print('Insert failed: $error');
    }
  }

  void discardChangesShipping(String inDistrict, String outDistrict) {
    shippingCostInDistrictController.text = inDistrict;
    shippingCostOutOfDistrictController.text = outDistrict;
    hasShippingChanged.value = false;

  }

  
  void discardChangesDelivery(String inDistrict, String outDistrict) {
   

    deliveryInDistrictController.text = inDistrict;
    deliveryOutOfDistrictController.text = outDistrict;
    hasDeliveryChanged.value = false;
  }
}
