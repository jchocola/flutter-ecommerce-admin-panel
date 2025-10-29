import 'package:admin_panel/screens/discounts/all_discounts/responsive_design/discounts_desktop.dart';
import 'package:admin_panel/screens/discounts/all_discounts/responsive_design/discounts_mobile.dart';
import 'package:admin_panel/screens/discounts/all_discounts/responsive_design/discounts_tablet.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:flutter/material.dart';

class DiscountsScreen extends StatelessWidget {
  const DiscountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: DiscountsDesktop(),
      tablet: DiscountsTablet(),
      mobile: DiscountsMobile(),
    );
  }
}
