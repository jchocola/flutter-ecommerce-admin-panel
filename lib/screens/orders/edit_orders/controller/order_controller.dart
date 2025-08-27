import 'package:admin_panel/util/models/customer_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderController extends GetxController {
  var orderStatusList = [
    'Pending',
    'Processing',
    'Shipped',
    'Delivered',
    'Cancelled',
  ];
  var selectedStatus = 'Pending'.obs;

  void updateOrderStatus(String? status) {
    if (status != null) {
      selectedStatus.value = status;
    }
  }
final storage = GetStorage();
RxMap<String, dynamic> cachedOrder = <String, dynamic>{}.obs;

void cacheOrder(Map<String, dynamic> order) {
  cachedOrder.assignAll(order);
}
  void setOrder(Map<String, dynamic> order) {
    cachedOrder.value = order;
    storage.write('cached_order', order);
  }

  void loadOrder() {
    final order = storage.read('cached_order');
    if (order != null) {
      cachedOrder.value = Map<String, dynamic>.from(order);
    }
  }


  @override
  void onInit() {
    super.onInit();
  }

  final orderItems = <Map<String, dynamic>>[].obs;
RxList<Map<String, dynamic>> shippingAddressList = <Map<String, dynamic>>[].obs;

Future<void> fetchShippingAddress(String orderId) async {
  try {
    final response = await Supabase.instance.client
        .from('orders')
        .select('shippingAddress')
        .eq('orderID', orderId)
        .single();

    if (response != null && response['shippingAddress'] != null) {
      shippingAddressList.value = List<Map<String, dynamic>>.from(response['shippingAddress']);
      print('🟢 Shipping Address loaded: ${shippingAddressList.length}');
    }
  } catch (e, s) {
    print('🔴 Error shippingAddress order: $e\n$s');
  }
}



  Future<void> fetchOrderProducts(String orderId) async {
    
    try {
      print('Fetching order: $orderId');
      
      final response =
          await Supabase.instance.client
              .from('orders')
              .select('products')
              .eq('orderID', orderId)
              .single();

      if (response != null && response['products'] != null) {
        orderItems.value = List<Map<String, dynamic>>.from(
          response['products'],
        );
        print('🟢🟢Products loaded: ${orderItems.length}');
      }
    } catch (e, s) {
      print('🔴🔴Error fetching order: $e\n$s');
    }
  }

    Future<void> updateOrder(String orderId, String status) async {
    try {
      print('Fetching order: $orderId');
      final response =
          await Supabase.instance.client
              .from('orders')
              .update({
                'orderStatus': status, // replace with your column and new value// optional field
              })
              .eq('orderID', orderId)
              .select()
              .single();

      if (response != null && response['products'] != null) {
        orderItems.value = List<Map<String, dynamic>>.from(
          response['products'],
        );
        print('🟢🟢Products loaded: ${orderItems.length}');
      }
    } catch (e, s) {
      print('🔴🔴Error fetching order: $e\n$s');
    }
  }


Future<CustomerModel?> fetchUserByID(String id) async {
  final supabase = Supabase.instance.client;

  try {
    final response = await supabase
        .from('customers')
        .select()
        .eq('customerID', id)
        .maybeSingle();  // To get a single user

    if (response != null) {
      final customer = CustomerModel.fromJson(response);
      print("✅ Fetched User: ${customer.customerName}");
      return customer;
    } else {
      print("⚠️ No customer found for id: $id");
      return null;
    }
  } catch (e) {
    print("❌ Error fetching user: ${e.toString()}");
    return null;
  }
}

}
