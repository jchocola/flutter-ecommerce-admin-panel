import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/screens/dashboard/table/data_table.dart';
import 'package:admin_panel/screens/dashboard/widgets/dasboard_widgets.dart';
import 'package:admin_panel/screens/dashboard/widgets/dashboard_card.dart';
import 'package:admin_panel/screens/dashboard/widgets/order_status_pie_chart.dart';
import 'package:admin_panel/screens/dashboard/widgets/renenue_statistic_bar.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class DashBoardMobileScreen extends StatelessWidget {
  const DashBoardMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              // TDashboardCard(
              //   title: 'Sales Total',
              //   subTitle: '\$250.0',
              //   stats: 25,
              // ),
              // const SizedBox(height: TSizes.spaceBetwwenItems),

              // TDashboardCard(
              //   title: 'Average Order Value',
              //   subTitle: '\$25',
              //   stats: 15,
              // ),
              // const SizedBox(height: TSizes.spaceBetwwenItems),
              // TDashboardCard(
              //   title: 'Total Orders',
              //   subTitle: '36',
              //   stats: 44,
              // ),
              // const SizedBox(height: TSizes.spaceBetwwenItems),
              // TDashboardCard(
              //   title: 'Visitors',
              //   subTitle: '23,035',
              //   stats: 2,
              // ),
              TDasboardCards(),

              const SizedBox(height: TSizes.spaceBetwwenSections),

              const RevenueStatisticBar(),
              const SizedBox(height: TSizes.spaceBetwwenSections),

              const TRoundedContainer(),
              const SizedBox(height: TSizes.spaceBetwwenSections),

              Text(
                'Recent Orders',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: TSizes.spaceBetwwenSections),
              RepaintBoundary(child: DashboardOrderTable()),
              const SizedBox(height: TSizes.spaceBetwwenSections),

              OrderStatusPieChart(),
            ],
          ),
        ),
      ),
    );
  }
}
