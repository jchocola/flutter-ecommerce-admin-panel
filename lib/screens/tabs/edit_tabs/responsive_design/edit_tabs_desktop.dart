import 'package:admin_panel/screens/tabs/create_tabs/widgets/create_tabs.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class EditTabsDesktop extends StatelessWidget {
 

  const EditTabsDesktop({super.key,required this.tabId, required this.tabTitle});

final String tabId, tabTitle;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: TSizes.spaceBetwwenSections),
            CreateTabsForm(title: 'Edit Tab', tabId: tabId, tabTitle: tabTitle, buttonTitle: 'Update', isEdit: true,),
          ],
        ),
      ),
    );
  }
}
