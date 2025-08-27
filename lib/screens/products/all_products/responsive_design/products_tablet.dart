import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/screens/category/all_categories/widgets/category_header.dart';
import 'package:admin_panel/screens/products/all_products/table/table_source.dart';
import 'package:admin_panel/screens/products/controller/product_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsTablet extends StatefulWidget {
  const ProductsTablet({super.key});

  @override
  State<ProductsTablet> createState() => _ProductsTabletState();
}

class _ProductsTabletState extends State<ProductsTablet> {
  final ProductsController productController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

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
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (productController.filteredProducts.isEmpty) {
                          return const Center(child: Text('No products found'));
                        }

                        return ProductsTable(
                          products: productController.filteredProducts.toList(),
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
    );
  }
}
