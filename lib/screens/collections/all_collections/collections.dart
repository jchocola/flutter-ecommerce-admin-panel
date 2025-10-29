import 'package:admin_panel/screens/collections/all_collections/responsive_design/collections_mobile.dart';
import 'package:admin_panel/screens/collections/all_collections/responsive_design/collections_desktop.dart';
import 'package:admin_panel/screens/collections/all_collections/responsive_design/collections_tablet.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:flutter/material.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: CollectionsDesktop(),
      tablet: CollectionsTablet(),
      mobile: CollectionsMobile(),
    );
  }
}
