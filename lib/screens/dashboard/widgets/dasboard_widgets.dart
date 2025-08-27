import 'package:admin_panel/screens/dashboard/controller/monthly_stats_controller.dart';
import 'package:admin_panel/screens/dashboard/widgets/dashboard_card.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TDasboardCards extends StatefulWidget {
  TDasboardCards({super.key});

  @override
  State<TDasboardCards> createState() => _TDasboardCardsState();
}

class _TDasboardCardsState extends State<TDasboardCards> {
  final controller = Get.put(MonthlyStatsController());
  var currencySymbol = ''.obs;

@override
void initState(){
  super.initState();
  controller.getAppCurrencySymbol().then((value) {
    currencySymbol.value = value;
  });
}


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final data = controller.stats.value;
      final previousData = controller.previousStats.value;

      if (data == null) {
        return const Center(child: CircularProgressIndicator());
      }

      if(TDeviceUtils.isDesktopScreen(context)) {
      return Row(
        children: [
          Expanded(
            child: TDashboardCard(
              title: 'Sales Total',
              subTitle: data.totalSales.toString(),
              stats: data.percentageGrowthTotalSales.toInt() ?? 0,
              lastMonth: previousData!.month,
            ),
          ),
          SizedBox(width: TSizes.spaceBetwwenItems),
          Expanded(
            child: TDashboardCard(
              title: 'Average Order Value',
              subTitle: data.totalOrders > 0
                  ? '$currencySymbol ${(data.totalSales / data.totalOrders).toStringAsFixed(2)}'
                  : 'N/A',
              stats: data.percentageGrowthTotalOrders?.toInt() ?? 0,
              lastMonth: previousData.month,
            ),
          ),
          SizedBox(width: TSizes.spaceBetwwenItems),
          Expanded(
            child: TDashboardCard(
              title: 'Total Orders',
              subTitle: data.totalOrders.toString(),
              stats: data.percentageGrowthTotalOrders?.toInt() ?? 0,
              lastMonth: previousData.month,
            ),
          ),
          SizedBox(width: TSizes.spaceBetwwenItems),
          Expanded(
            child: TDashboardCard(
              title: 'Visitors',
              subTitle: data.visitors.toString(),
              stats: data.percentageGrowthVisitors?.toInt() ?? 0,
              lastMonth: previousData.month,
            ),
          ),
        ],
      );
    } else   if(TDeviceUtils.isTabletScreen(context)) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TDashboardCard(
                  title: 'Sales Total',
                  subTitle: data.totalSales.toString(),
                  stats: data.percentageGrowthTotalSales.toInt() ?? 0,
                  lastMonth: previousData!.month,
                ),
              ),
          SizedBox(width: TSizes.spaceBetwwenItems),
          Expanded(
            child: TDashboardCard(
              title: 'Average Order Value',
              subTitle: data.totalOrders > 0
                  ? '$currencySymbol ${(data.totalSales / data.totalOrders).toStringAsFixed(2)}'
                  : 'N/A',
              stats: data.percentageGrowthTotalOrders?.toInt() ?? 0,
              lastMonth: previousData.month,
            ),
          ),
            ],
          ),
          SizedBox(height: TSizes.spaceBetwwenItems),
         Row(
          children: [
             Expanded(
            child: TDashboardCard(
              title: 'Total Orders',
              subTitle: data.totalOrders.toString(),
              stats: data.percentageGrowthTotalOrders?.toInt() ?? 0,
              lastMonth: previousData.month,
            ),
          ),
          SizedBox(width: TSizes.spaceBetwwenItems),
          Expanded(
            child: TDashboardCard(
              title: 'Visitors',
              subTitle: data.visitors.toString(),
              stats: data.percentageGrowthVisitors?.toInt() ?? 0,
              lastMonth: previousData.month,
            ),
          ),
          ],
         )
        ],
      );
    } else if(TDeviceUtils.isMobileScreen(context)) {
      return Column(
        children: [
          TDashboardCard(
            title: 'Sales Total',
            subTitle: data.totalSales.toString(),
            stats: data.percentageGrowthTotalSales.toInt() ?? 0,
            lastMonth: previousData!.month,
          ),
          SizedBox(height: TSizes.spaceBetwwenItems),
          TDashboardCard(
            title: 'Average Order Value',
            subTitle: data.totalOrders > 0
                ? '$currencySymbol ${(data.totalSales / data.totalOrders).toStringAsFixed(2)}'
                : 'N/A',
            stats: data.percentageGrowthTotalOrders?.toInt() ?? 0,
            lastMonth: previousData.month,
          ),
          SizedBox(height: TSizes.spaceBetwwenItems),
          TDashboardCard(
            title: 'Total Orders',
            subTitle: data.totalOrders.toString(),
            stats: data.percentageGrowthTotalOrders?.toInt() ?? 0,
            lastMonth: previousData.month,
          ),
          SizedBox(height: TSizes.spaceBetwwenItems),
          TDashboardCard(
            title: 'Visitors',
            subTitle: data.visitors.toString(),
            stats: data.percentageGrowthVisitors?.toInt() ?? 0,
            lastMonth: previousData.month,
          ),
        ],
      );
    }
    return SizedBox.shrink();
  });
  }
}
