import 'package:admin_panel/common/widgets/heading/section_heading.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TDashboardCard extends StatelessWidget {
  const TDashboardCard({
    super.key,
    required this.title,
    required this.subTitle,
    this.icon = Iconsax.arrow_up_3,
    this.color = Colors.green,
    required this.stats,
    this.onTap,
    required this.lastMonth
  });

  final String title, subTitle;
  final IconData icon;
  final Color color;
  final int stats;
  final void Function()? onTap;
  final String lastMonth;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      onTap: onTap,
      radius: 5,
      backgroundColor: dark ? Colors.white.withOpacity(0.05) : Colors.white,
      showBorder: true,
      borderColor:
          dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
      padding: EdgeInsets.all(TSizes.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TSectionHeading(
            title: title,
            textColor: dark ? TColors.textWhite : TColors.textSecondary,
            showActionButton: false,
          ),
          SizedBox(height: TSizes.spaceBetwwenSections),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subTitle, style: Theme.of(context).textTheme.headlineMedium),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon((stats.toString().contains('-')) ? Iconsax.arrow_down : Iconsax.arrow_up_3, color: (stats.toString().contains('-')) ? Colors.red :Colors.green, size: TSizes.iconSm),
                      Text(
                        '$stats%',
                        style: Theme.of(context).textTheme.titleLarge!.apply(
                          color: (stats.toString().contains('-')) ? Colors.red : Colors.green,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Text(
            'Compared to $lastMonth',
            style: Theme.of(context).textTheme.labelMedium,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
