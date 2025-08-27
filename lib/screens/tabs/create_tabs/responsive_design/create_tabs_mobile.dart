import 'package:admin_panel/screens/tabs/create_tabs/widgets/create_tabs.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CreateTabsMobile extends StatelessWidget {
  const CreateTabsMobile({super.key});

  @override
  Widget build(BuildContext context) {
      var uuid = const Uuid();
String newId = uuid.v4(); // newId is String
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: TSizes.spaceBetwwenSections,),

              CreateTabsForm(title: 'Create New Tabs', tabId: newId, tabTitle: '',),
            ],
          ),
        ),
      )
    );
  }
}