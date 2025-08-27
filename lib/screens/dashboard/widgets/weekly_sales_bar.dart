import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:admin_panel/controllers/dashboard/dashboard_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';

class TWeeklySalesBar extends StatelessWidget {
  const TWeeklySalesBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.to;
    final dark = THelperFunctions.isDarkMode(context);

    return TRoundedContainer(
      backgroundColor: dark ? Colors.white.withOpacity(0.05) : Colors.white,
      borderColor:
          dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
      showBorder: true,
      radius: 5,
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Weekly Sales',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                  Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: ()=> controller.toggleWeek(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: dark ? Colors.white.withOpacity(0.05) : TColors.primary,
                        border: Border.all(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text( controller.isCurrentWeek.value
                          ? 'Show Previous Week'
                          : 'Show Current Week'),
                      ),
                    ),
                  ),
                 
                ],
              ),
            ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBetwwenSections),
            Obx(() {
              if (controller.weeklySales.isEmpty ||
                  controller.last7Days.length != 7) {
                return const SizedBox(
                  height: 400,
                  child: Center(child: Text('No sales data')),
                );
              }

              // 1. Sort last7Days Monday=1 .. Sunday=7
              final sortedDays = [...controller.last7Days]
                ..sort((a, b) => a.weekday.compareTo(b.weekday));

              // 2. Map weekday -> sales value
              final Map<int, double> weekdayToSales = {};
              for (int i = 0; i < controller.last7Days.length; i++) {
                final day = controller.last7Days[i].weekday;
                final sales =
                    controller.weeklySales.length > i
                        ? controller.weeklySales[i]
                        : 0.0;
                weekdayToSales[day] = sales;
              }

              // 3. Build bar groups aligned with sortedDays (Monday=0..Sunday=6)
              final barGroups = List.generate(7, (index) {
                final weekday = index + 1; // 1=Mon, 7=Sun
                final sales = weekdayToSales[weekday] ?? 0.0;
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: sales,
                      width: 30,
                      color: TColors.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ],
                );
              });

              return SizedBox(
                height: 420,
                child: BarChart(
                  BarChartData(
                    titlesData: _buildTitles(sortedDays),
                    borderData: FlBorderData(
                      show: true,
                      border: const Border(
                        top: BorderSide.none,
                        right: BorderSide.none,
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      horizontalInterval: 200,
                      verticalInterval: 300,
                      drawHorizontalLine: true,
                      drawVerticalLine: false,
                    ),
                    barGroups: barGroups,
                    groupsSpace: TSizes.spaceBetwwenItems,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: TColors.secondary,
                      ),
                      touchCallback:
                          TDeviceUtils.isDesktopScreen(context)
                              ? (_, __) {}
                              : null,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  FlTitlesData _buildTitles(List<DateTime> sortedDays) {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            if (index < 0 || index >= sortedDays.length)
              return const SizedBox.shrink();

            final date = sortedDays[index];
            final dayName =
                ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index];
            final label = '${date.day}/${date.month}';

            return SideTitleWidget(
              axisSide: AxisSide.bottom,
              space: 0,
              child: Column(
                children: [
                  Text(dayName, style: const TextStyle(fontSize: 12)),
                  Text(
                    label,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      leftTitles: const AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 500,
          reservedSize: 50,
        ),
      ),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}
