import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';

import 'package:admin_panel/controllers/dashboard/dashboard_controller.dart';
import 'package:admin_panel/screens/dashboard/controller/monthly_stats_controller.dart';

import 'package:admin_panel/screens/dashboard/table/data_table.dart';
import 'package:admin_panel/screens/dashboard/widgets/dasboard_widgets.dart';

import 'package:admin_panel/screens/dashboard/widgets/order_status_pie_chart.dart';
import 'package:admin_panel/screens/dashboard/widgets/renenue_statistic_bar.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';

import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(DashboardController());
    final monthlyController = Get.put(MonthlyStatsController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: TSizes.spaceBetwwenSections),

              // all statistic
              TDasboardCards(),

              const SizedBox(height: TSizes.spaceBetwwenSections),

             
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                         // revenue statistic
                        RepaintBoundary(child: RevenueStatisticBar()),

                        SizedBox(height: TSizes.spaceBetwwenSections),

                        TRoundedContainer(
                          backgroundColor:
                              dark
                                  ? Colors.white.withOpacity(0.05)
                                  : Colors.white,
                          showBorder: true,
                          radius: 5,
                          borderColor:
                              dark
                                  ? Colors.grey.withOpacity(0.5)
                                  : TColors.dark.withOpacity(0.2),
                          child: Padding(
                            padding: const EdgeInsets.all(TSizes.defaultSpace),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Recent Orders',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBetwwenSections,
                                ),
                                RepaintBoundary(child: DashboardOrderTable()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: TSizes.spaceBetwwenSections),

                  // ORDER STATUS PIE CHART
                  Expanded(
                    child: RepaintBoundary(child: OrderStatusPieChart()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
