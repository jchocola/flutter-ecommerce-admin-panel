import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/screens/dashboard/table/data_table.dart';
import 'package:admin_panel/screens/dashboard/widgets/dasboard_widgets.dart';
import 'package:admin_panel/screens/dashboard/widgets/dashboard_card.dart';
import 'package:admin_panel/screens/dashboard/widgets/order_status_pie_chart.dart';
import 'package:admin_panel/screens/dashboard/widgets/renenue_statistic_bar.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class DashBoardTabletScreen extends StatelessWidget {
  const DashBoardTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: TSizes.spaceBetwwenSections),

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

              OrderStatusPieChart(),
            ],
          ),
        ),
      ),
    );
  }
}
