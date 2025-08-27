import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/screens/brands/brands/table/brand_table.dart';
import 'package:admin_panel/screens/brands/create_brands/controller/brand_controller.dart';
import 'package:admin_panel/screens/category/all_categories/table/data_header.dart';
import 'package:admin_panel/screens/category/all_categories/widgets/category_header.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BrandsTablet extends StatelessWidget {
   BrandsTablet({super.key});
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(BrandController());
     WidgetsBinding.instance.addPostFrameCallback((_) {
    if (_searchController.text.isEmpty) {
      controller.resetSearch();
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
                        TTableHeader(buttonText: 'Create New Brand', onPressed: () => Get.toNamed(TRoutes.createBrand),
                        searchController: _searchController,
                          searchOnChanged: (value) => controller.filterBrand(value),
),
                        SizedBox(height: TSizes.spaceBetwwenItems,),
                    
                         BrandTable(),
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