import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/screens/dashboard/widgets/dasboard_widgets.dart';
import 'package:admin_panel/screens/dashboard/widgets/dashboard_card.dart';
import 'package:admin_panel/screens/dashboard/widgets/order_status_pie_chart.dart';
import 'package:admin_panel/screens/dashboard/widgets/weekly_sales_bar.dart';
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
              // Row(
              //   children: [
              //     Expanded(
              //       child: TDashboardCard(
              //         title: 'Sales Total',
              //         subTitle: '\$250.0',
              //         stats: 25,
              //       ),
              //     ),
              //     SizedBox(width: TSizes.spaceBetwwenItems),
              //     Expanded(
              //       child: TDashboardCard(
              //         title: 'Average Order Value',
              //         subTitle: '\$25',
              //         stats: 15,
              //       ),
              //     ),
               
              //   ],
              // ),
              // const SizedBox(height: TSizes.spaceBetwwenItems,),
              //  Row(
              //   children: [
                 
              //     Expanded(
              //       child: TDashboardCard(
              //         title: 'Total Orders',
              //         subTitle: '36',
              //         stats: 44,
              //       ),
              //     ),
              //     SizedBox(width: TSizes.spaceBetwwenItems),
              //     Expanded(
              //       child: TDashboardCard(
              //         title: 'Visitors',
              //         subTitle: '23,035',
              //         stats: 2,
              //       ),
              //     ),
              //   ],
              // ),
              TDasboardCards(),

              const SizedBox(height: TSizes.spaceBetwwenSections,),

              const TWeeklySalesBar(),
              const SizedBox(height: TSizes.spaceBetwwenSections,),

              const TRoundedContainer(),
              const SizedBox(height: TSizes.spaceBetwwenSections,),

              OrderStatusPieChart(),
            ],
          ),
        ),
      ),
    );
  }
}
