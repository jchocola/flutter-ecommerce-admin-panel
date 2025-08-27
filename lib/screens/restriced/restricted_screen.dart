import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:flutter/material.dart';

class RestrictedScreen extends StatelessWidget {
  const RestrictedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop: Center(child: Text('You dont have persmission')),);
  }
}