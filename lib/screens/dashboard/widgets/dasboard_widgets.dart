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

      // if (data == null) {
      //   return const Center(child: CircularProgressIndicator());
      // }

      if(TDeviceUtils.isDesktopScreen(context)) {
      return Row(
        children: [
          Expanded(
            child: TDashboardCard(
              title: 'Sales Total',
              subTitle: 'total order',
              stats: 100,
              lastMonth: 'last mont',
            ),
          ),
          SizedBox(width: TSizes.spaceBetwwenItems),
          Expanded(
            child: TDashboardCard(
              title: 'Average Order Value',
              subTitle: '',
              stats:  0,
              lastMonth: '',
            ),
          ),
          SizedBox(width: TSizes.spaceBetwwenItems),
          Expanded(
            child: TDashboardCard(
              title: 'Total Orders',
              subTitle: '',
              stats:  0,
              lastMonth: '',
            ),
          ),
          SizedBox(width: TSizes.spaceBetwwenItems),
          Expanded(
            child: TDashboardCard(
              title: 'Visitors',
              subTitle: '121',
              stats:  0,
              lastMonth: '',
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
                  subTitle: '',
                  stats:  0,
                  lastMonth: '43',
                ),
              ),
          SizedBox(width: TSizes.spaceBetwwenItems),
          Expanded(
            child: TDashboardCard(
              title: 'Average Order Value',
              subTitle:'',
              stats:  0,
              lastMonth: '43',
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
              subTitle: '',
              stats: 32,
              lastMonth: '34',
            ),
          ),
          SizedBox(width: TSizes.spaceBetwwenItems),
          Expanded(
            child: TDashboardCard(
              title: 'Visitors',
              subTitle: '32',
              stats:  0,
              lastMonth: '34',
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
            subTitle: '',
            stats: 34,
            lastMonth: '343',
          ),
          SizedBox(height: TSizes.spaceBetwwenItems),
          TDashboardCard(
            title: 'Average Order Value',
            subTitle: '',
            stats:  0,
            lastMonth: '43',
          ),
          SizedBox(height: TSizes.spaceBetwwenItems),
          TDashboardCard(
            title: 'Total Orders',
            subTitle: '',
            stats:  0,
            lastMonth: '43',
          ),
          SizedBox(height: TSizes.spaceBetwwenItems),
          TDashboardCard(
            title: 'Visitors',
            subTitle: '56',
            stats:  0,
            lastMonth: '3',
          ),
        ],
      );
    }
    return SizedBox.shrink();
  });
  }
}
