import 'package:admin_panel/screens/settings/model/payment_add_model.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/models/app_config_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class PaymentController extends GetxController {
  final List<String> paymentMethods = [
    'PayHere',
    
  ];

  final TextEditingController aPIKeyController = TextEditingController();
  var apiKey = ''.obs;
  final hasAPIChanged = false.obs;
  final TextEditingController merchantIDController = TextEditingController();
  var merchantID = ''.obs;
  final hasMerchantIDChanged = false.obs;
  final TextEditingController paymentMethodController = TextEditingController();
  var paymentMethod = 'PayHere'.obs;
  final hasPaymentMethodChanged = false.obs;
 var isLoading = true.obs;
 var payments = <PaymentAddModel>[].obs;

final isSandBox = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPayments();
    aPIKeyController.addListener(() {
      hasAPIChanged.value = isAPI();
    });

     merchantIDController.addListener(() {
      hasMerchantIDChanged.value = isMerhchantID();
    });

    processingFeeController.addListener(() {
      hasProcessingFeeChanged.value = isProcessing();
    });

   
  }
  
  Future<void> fetchPayments() async {
    try {
      final data = await Supabase.instance.client
          .from('payment_credentials')
          .select()
          .order('created_at', ascending: false);

      payments.value =
          (data as List).map((e) => PaymentAddModel.fromJson(e)).toList();
    } catch (e) {
      print('❌ Error fetching payments: $e');
    } finally {
      isLoading.value = false;
    }
  }
  bool isAPI() {
    return aPIKeyController.text != apiKey.value;
  }
bool isProcessing() {
    return processingFeeController.text != processingFee.value;
  }
   bool isMerhchantID() {
    return merchantIDController.text != merchantID.value;
  }

  Future<void> deletePaymentMethod(String paymentMethod) async {
    try{
      final supabase = Supabase.instance.client;

      final deleteRespone = await supabase.from('payment_credentials')
      .delete()
      .eq('PaymentProvider', paymentMethod);

      Get.snackbar('Payment method', 'Successfully removed $paymentMethod Payment Method', backgroundColor: TColors.primary, colorText: Colors.white);
      fetchPayments();
    }catch (e) {
      print('🔴🔴🔴🔴 ${e.toString()}');
    }
  }


  Future<void> updateSandBoxMode(bool value, String paymentMethod) async {
    try{
      final supabase = Supabase.instance.client;

      final response = await supabase.from('payment_credentials').update({'isSandBox' : value}).eq('PaymentProvider', paymentMethod);

    }catch (e) {
      print('🟢🟢🟢 ${e.toString()}');
    }
  }

 Future<bool> getSandBoxMode(String paymentMethod) async {
  try {
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from('payment_credentials')
        .select('isSandBox')
        .eq('PaymentProvider', paymentMethod)
        .maybeSingle();

    return response?['isSandBox'] == true;
  } catch (e) {
    print('🔴 getSandBoxMode error: $e');
    return false;
  }
}

Future<double> getProcessingFee(String paymentMethod) async {
  try {
    final supabase = Supabase.instance.client;

    final response = await supabase
        .from('payment_credentials')
        .select('processing_fee')
        .eq('PaymentProvider', paymentMethod)
        .maybeSingle();

    return (response != null && response['processing_fee'] != null)
        ? double.tryParse(response['processing_fee'].toString()) ?? 0
        : 0.0;
  } catch (e) {
    print("🔴 Error: $e");
    return 0.0;
  }
}


final TextEditingController processingFeeController = TextEditingController();
var processingFee = ''.obs;
final hasProcessingFeeChanged = false.obs;




Future<void> updateProcessingFee(double processing_fee, String paymentMethod) async {
  try{
    final supabase = Supabase.instance.client;

    final existing = await supabase
    .from('payment_credentials')
    .select()
    .eq('PaymentProvider', paymentMethod);

print('Existing rows: $paymentMethod');
print('Existing rows: $processingFee');


    final respone = await supabase.from('payment_credentials').update({'processing_fee' : processing_fee}).eq('PaymentProvider', paymentMethod);
    Get.snackbar('Updated', 'Processing Fee Updated', backgroundColor: TColors.primary, colorText: Colors.white);
  }catch (e) {
    print("🔴🔴🔴 ${e.toString()}");
  }
}


Future<void> addNewPaymentMethod() async {
  Get.snackbar('Please Wait...', 'Adding new payment method', backgroundColor: TColors.primary, colorText: Colors.white);
  try {
    final supabase = Supabase.instance.client;

    final method = paymentMethodController.text.trim().isNotEmpty
        ? paymentMethodController.text.trim()
        : paymentMethod.value;

    print('🔍 Checking payment method: $method');

    final paymentData = await supabase
        .from('payment_credentials')
        .select()
        .eq('PaymentProvider', method)
        .maybeSingle();

    if (paymentData != null) {
      print('🔁 Updating payment method...');
      Get.snackbar('Already Found !', 'You Already Added $method Payment Method', backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      print('➕ Inserting new payment method...');
      final newPaymentMethod = PaymentAddModel(
        id:  Uuid().v4(),
        APIKey: aPIKeyController.text,
        MerchantID: merchantIDController.text,
        PaymentProvider: method,
        created_at: DateTime.now(),
        isActive: true,
        isSandBox: false,
        processing_fee: 0
      );

      await supabase
          .from('payment_credentials')
          .insert(newPaymentMethod.toJson());
              Get.snackbar('New Payment Method Added', 'You have successfull added ${paymentMethodController.text} Payment Method', backgroundColor: Colors.green, colorText: Colors.white);

    }

    print('✅ Payment method handled successfully.');
    fetchPayments();
    aPIKeyController.clear();
    merchantIDController.clear();
  } catch (e, s) {
    print('❌ Error in addNewPaymentMethod: $e\n$s');
    rethrow;
  }
}

  
}
