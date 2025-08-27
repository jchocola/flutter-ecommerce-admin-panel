import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:admin_panel/util/models/order_model.dart';

class OrderControllerSearch extends GetxController {
  static OrderControllerSearch get instance => Get.find();

  final RxList<OrderModel> allOrders = <OrderModel>[].obs;
  final RxList<OrderModel> filterOrders = <OrderModel>[].obs;

  final _isLoading = false.obs;
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    _isLoading.value = true;

    final supabase = Supabase.instance.client;
    final response = await supabase.from('orders').select();

    if (response != null) {
      allOrders.value = (response as List)
          .map((order) => OrderModel.fromJson(order))
          .toList();
      filterOrders.assignAll(allOrders);
      print('Orders fetched: ${allOrders.length}');
    } else {
      print('No orders found');
      allOrders.clear();
      filterOrders.clear();
    }

    _isLoading.value = false;
  }

  void filterOrdersByQuery(String query) {
    if (query.trim().isEmpty) {
      filterOrders.assignAll(allOrders);
    } else {
      final lowerQuery = query.toLowerCase();
      filterOrders.assignAll(
        allOrders.where((order) {
          final orderId = order.orderID?.toLowerCase() ?? '';
          final orderStatus = order.orderStatus?.toLowerCase() ?? '';
            final orderDate = order.orderDate?.toString().toLowerCase() ?? '';
          return orderId.contains(lowerQuery) || orderStatus.contains(lowerQuery) || orderDate.contains(lowerQuery);
        }).toList(),
      );
    }
  }

  void resetSearch() {
    filterOrders.assignAll(allOrders);
    searchController.clear();
  }

  bool get isLoading => _isLoading.value;
}
