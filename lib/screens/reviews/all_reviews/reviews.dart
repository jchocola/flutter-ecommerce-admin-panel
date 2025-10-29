import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/screens/reviews/all_reviews/responsive_design/reviews_desktop.dart';
import 'package:admin_panel/screens/reviews/all_reviews/responsive_design/reviews_mobile.dart';
import 'package:admin_panel/screens/reviews/all_reviews/responsive_design/reviews_tablet.dart';
import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: ReviewsDesktop(),
      tablet: ReviewsTablet(),
      mobile: ReviewsMobile(),
    );
  }
}
