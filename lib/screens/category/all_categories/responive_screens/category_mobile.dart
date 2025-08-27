import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/screens/category/all_categories/table/data_header.dart';
import 'package:admin_panel/screens/category/all_categories/widgets/category_header.dart';
import 'package:admin_panel/screens/category/controllers/category_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CreateCategoryScreenMobile extends StatelessWidget {
   CreateCategoryScreenMobile({super.key});
  final TextEditingController _searchController = TextEditingController();
  final categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

     WidgetsBinding.instance.addPostFrameCallback((_) {
    if (_searchController.text.isEmpty) {
      categoryController.resetSearch();
    }
  });
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: TSizes.spaceBetwwenSections,),

            
               TRoundedContainer(
                backgroundColor: dark ? Colors.white.withOpacity(0.05) : Colors.white,
                showBorder: true,
                radius: 5,
                borderColor: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TTableHeader(buttonText: 'Create New Category', onPressed: () => Get.toNamed(TRoutes.createCategory),
                        searchOnChanged: (query) => categoryController.filterCategory(query),),
                        SizedBox(height: TSizes.spaceBetwwenItems,),
                    
                         CategoryTable()
                      ],
                    ),
                  ),
                ),
              
            ],
          ),
        ),
      )
    );
  }
}