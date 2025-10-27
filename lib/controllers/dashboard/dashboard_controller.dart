import 'dart:async';

import 'package:admin_panel/util/models/order_model.dart';
import 'package:get/get.dart';

import 'package:admin_panel/util/formatters/enum.dart';

class DashboardController extends GetxController {
  static DashboardController get to => Get.find();



  // Observable lists and maps
  final RxList<OrderModel> orders = <OrderModel>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;
  final RxList<double> weeklySales = <double>[].obs;


@override
void onInit() {
  super.onInit();

  Future.microtask(() async {
    // await fetchOrders();
    // await fetchWeeklySales();
    // listenOrderChanges();
    getLast7Days();
  });
}

  // Fetch orders once
  // Future<void> fetchOrders() async {
  //   try {
  //     final data = await supabase
  //         .from('orders')
  //         .select()
  //         .order('orderDate', ascending: false);

  //     if (data != null) {
  //       final list = (data as List)
  //           .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
  //           .toList();
  //       orders.assignAll(list);
  //       _recalculateStats();
  //     }
  //   } catch (e) {
  //     print('Error fetching orders: $e');
  //   }
  // }
final RxBool isCurrentWeek = true.obs;

// Future<void> fetchWeeklySales() async {
//   try {
//     final now = DateTime.now();
//  final startOfWeek = isCurrentWeek.value
//     ? DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1))
//     : DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1 + 7));

// final endOfWeek = startOfWeek.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));


//     final data = await supabase
//       .from('orders')
//       .select('totalPrice, orderDate')
//       .gte('orderDate', startOfWeek.toIso8601String())
//       .lte('orderDate', endOfWeek.toIso8601String());

//     final last7Days = List.generate(7, (i) => startOfWeek.add(Duration(days: i)));

//     final Map<String, double> dailySales = {
//       for (var date in last7Days) date.toIso8601String().substring(0, 10): 0.0,
//     };

//     for (final order in data) {
//       final orderDate = DateTime.parse(order['orderDate']);
//       final dateKey = orderDate.toIso8601String().substring(0, 10);
//       final amount = (order['totalPrice'] as num).toDouble();
//       if (dailySales.containsKey(dateKey)) {
//         dailySales[dateKey] = dailySales[dateKey]! + amount;
//       }
//     }

//     final salesList = last7Days.map((date) {
//       final key = date.toIso8601String().substring(0, 10);
//       return dailySales[key] ?? 0;
//     }).toList();

//     weeklySales.assignAll(salesList);
//     this.last7Days.assignAll(last7Days);
//   } catch (e) {
//     print('❌ Exception fetching weekly sales: $e');
//   }
// }

void toggleWeek() {
  isCurrentWeek.toggle();
  //fetchWeeklySales();
}



  // Subscribe to real-time changes via stream
StreamSubscription? _orderStream;

final RxList<DateTime> last7Days = <DateTime>[].obs;

List<DateTime> getLast7Days() {
  final now = DateTime.now();
  final monday = now.subtract(Duration(days: now.weekday - 1)); // Week starts Monday
  return List.generate(7, (i) => monday.add(Duration(days: i))); // Monday to Sunday
}

List<DateTime> getPreviousWeekDays() {
  final now = DateTime.now();
  final thisMonday = now.subtract(Duration(days: now.weekday - 1));
  final prevMonday = thisMonday.subtract(const Duration(days: 7));
  return List.generate(7, (i) => prevMonday.add(Duration(days: i)));
}


Timer? _debounceTimer;
// void listenOrderChanges() {
//   _orderStream = supabase
//       .from('orders')
//       .stream(primaryKey: ['id'])
//       .order('orderDate', ascending: false)
//       .limit(100)
//       .listen((updatedOrders) {
//    _debounceTimer?.cancel();
// _debounceTimer = Timer(const Duration(seconds: 1), () async {
//   await fetchOrders();
//   await fetchWeeklySales();
// });

//   });
// }


@override
void onClose() {
  _orderStream?.cancel();
  _debounceTimer?.cancel();
  super.onClose();
}


void _recalculateStats() {
  // Use local maps to rebuild and assign — this is critical
  final Map<OrderStatus, int> statusCount = {
    for (var status in OrderStatus.values) status: 0,
  };

  final Map<OrderStatus, double> amountTotals = {
    for (var status in OrderStatus.values) status: 0.0,
  };

  for (var order in orders) {
    final status = orderStatusFromString(order.orderStatus ?? '');
    statusCount[status] = (statusCount[status] ?? 0) + 1;
    amountTotals[status] =
        (amountTotals[status] ?? 0.0) + (order.totalPrice ?? 0.0);
  }

  // Assign the whole map to trigger observers
  orderStatusData.assignAll(statusCount);
  totalAmounts.assignAll(amountTotals);
}


  String getDisplayStatusName(OrderStatus status) {
    switch (status) {
      case OrderStatus.placed:
        return 'Placed';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }
}


