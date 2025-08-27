import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/screens/settings/other_screens/user_activity_screen/table/user_activity_log.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class UserActivityScreen extends StatelessWidget {
  const UserActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop:UserActivityScreenResp(), tablet: UserActivityScreenResp(), mobile: UserActivityScreenResp(),);
  }
}


class UserActivityScreenResp extends StatelessWidget {
  const UserActivityScreenResp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('User Activity Log', style: Theme.of(context).textTheme.headlineLarge,),
              const SizedBox(height: TSizes.spaceBetwwenItems,),

              UserActivityLogTable(),

            ],
          ),
        ),
      ),
    );
  }
}