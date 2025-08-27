import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/screens/category/all_categories/widgets/category_header.dart';
import 'package:admin_panel/screens/tabs/all_tabs/data/tabs_table.dart';
import 'package:admin_panel/screens/tabs/controller/tab_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:lottie/lottie.dart';

class TabsMobile extends StatelessWidget {
  TabsMobile({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    // Make sure controller instance is ready
    final TabsController tabsController = Get.put(TabsController.instance);
WidgetsBinding.instance.addPostFrameCallback((_) {
    if (_searchController.text.isEmpty) {
      tabsController.resetSearch();
    }
  });
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: TSizes.spaceBetwwenSections),
              TRoundedContainer(
                radius: 5,
                backgroundColor:
                    dark ? Colors.white.withOpacity(0.05) : Colors.white,
                showBorder: true,
                borderColor:
                    dark
                        ? Colors.grey.withOpacity(0.5)
                        : TColors.dark.withOpacity(0.2),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TTableHeader(
                        buttonText: 'Create New Tab',
                        onPressed: () async {
                          final result = await Get.toNamed(TRoutes.createTabs);
                          if (result == true) {
                            final controller = Get.find<TabsController>();
                            controller.fetchTabs();
                          }
                        },

                        searchController: _searchController,
                        searchOnChanged:
                            (query) => tabsController.filterTabs(query),
                      ),
                      const SizedBox(height: TSizes.spaceBetwwenItems),
                      Obx(() {
                        if (tabsController.isLoading.value) {
                          return Center(
                            child: Lottie.asset(TImages.loading_animation),
                          );
                        }
                        if (tabsController.filteredTabs.isEmpty) {
                          return Column(
                            children: [
                              Lottie.asset(
                                TImages.no_data_animation,
                                width: 300,
                                height: 300,
                                repeat: false,
                              ),
                              Text(
                                'No Tabs Found..',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          );
                        }
                        return TabsTable(tabs: tabsController.filteredTabs);
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
