import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/screens/category/all_categories/widgets/category_header.dart';
import 'package:admin_panel/screens/products/all_products/table/table_source.dart';
import 'package:admin_panel/screens/products/controller/product_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/image_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ProductsDesktop extends StatefulWidget {
  const ProductsDesktop({super.key});

  @override
  State<ProductsDesktop> createState() => _ProductsDesktopState();
}

class _ProductsDesktopState extends State<ProductsDesktop> {
  final ProductsController productController = Get.put(ProductsController());
  final TextEditingController _searchController = TextEditingController();
  final imageController = Get.put(ProductImagesController());
@override
void initState(){
  super.initState();
 // imageController.selectedThumbnailImageUrl.value = '';
}
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (_searchController.text.isEmpty) {
      productController.resetSearch();
    }
  });
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: RepaintBoundary(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: TSizes.spaceBetwwenSections),
                TRoundedContainer(
                  radius: 5,
                  backgroundColor: dark
                      ? Colors.white.withOpacity(0.05)
                      : Colors.white,
                  showBorder: true,
                  borderColor: dark
                      ? Colors.grey.withOpacity(0.5)
                      : TColors.dark.withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TTableHeader(
                          buttonText: 'Create New Product',
                          searchController: _searchController,
                          onPressed: () async {
                            final result = await Get.toNamed(TRoutes.createProducts);
                            if (result == true) {
                              await productController.fetchProducts();
                            }
                          },
                          searchOnChanged: (query) => productController.filterProductsByTitle(query),
                          
                          
                        ),
                        const SizedBox(height: TSizes.spaceBetwwenItems),
                        Obx(() {
                          if (productController.isLoading.value) {
                                  return  Center(child: Lottie.asset(TImages.loading_animation, width: 500, height: 500));
                          }
            
                          if (productController.filteredProducts.isEmpty) {
                            return  Center(child: Lottie.asset(TImages.no_data_animation, width: 500, height: 500));
                          }
            
                          return RepaintBoundary(
                            child: ProductsTable(
                              products: productController.filteredProducts.toList(),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
