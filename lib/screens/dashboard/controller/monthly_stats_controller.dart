import 'package:admin_panel/screens/dashboard/model/monthly_stats_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MonthlyStatsController extends GetxController {
  static MonthlyStatsController get instance => Get.find();

  //  final supabase = Supabase.instance.client;

  var stats = Rxn<MonthlySalesStats>();

  @override
  void onInit() {
    super.onInit();
    fetchCurrentMonthStats();
    fetchPreviousMonthStats();
  }

  Future<void> fetchCurrentMonthStats() async {
    final currentMonthLabel = DateFormat(
      'MMMM yyyy',
    ).format(DateTime.now()); // e.g. "July 2025"

    try {
      // final response = await supabase
      //     .from('monthly_stats')
      //     .select()
      //     .eq('month', currentMonthLabel)
      //     .maybeSingle();

      // if (response != null) {
      //   stats.value = MonthlySalesStats.fromJson(response);
      //   print('🟢 Fetched current month stats: ${stats.value}');
      // } else {
      //   print('🟡 No stats found for current month: $currentMonthLabel');
      // }
    } catch (e) {
      print('🔴 Error fetching monthly stats: $e');
    }
  }

  var previousStats = Rxn<MonthlySalesStats>();
  Future<String> getAppCurrencySymbol() async {
    print('🔍 getAppCurrencySymbol called'); // <-- Check if this appears
    // final supabase = Supabase.instance.client;

    try {
      // final check = await supabase
      //     .from('app_config')
      //     .select('value')
      //     .eq('title', 'currencySymbol')
      //     .maybeSingle();

      // print('Curr🎫🎫ency symbol fetched: ${check?['value']}');  // <-- This should print

      // return check?['value']?.toString() ?? '';
      return '';
    } catch (e) {
      print('🔴 Error fetching config: ${e.toString()}');
      return '';
    }
  }

  Future<void> fetchPreviousMonthStats() async {
    final now = DateTime.now();
    final previousMonth = DateTime(now.year, now.month - 1);
    final previousMonthName = DateFormat('MMMM yyyy').format(previousMonth);
    print("🎫🎫🎫 ${previousMonthName.toString()}"); // e.g., "June"

    try {
      // final response = await supabase
      //     .from('monthly_stats')
      //     .select()
      //     .eq('month', previousMonthName)
      //     .maybeSingle();

      // if (response != null) {
      //   previousStats.value = MonthlySalesStats.fromJson(response);
      //   print('🟢 Fetched current month stats: ${previousStats.value}');
      // } else {
      //   print('🟡 No stats found for current month: $previousMonthName');
      // }
    } catch (e) {
      print('🔴 Error fetching monthly stats: $e');
    }
  }
}
