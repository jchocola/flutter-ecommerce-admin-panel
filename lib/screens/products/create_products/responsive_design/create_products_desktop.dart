import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/screens/products/create_products/controller/image_controller.dart';
import 'package:admin_panel/screens/products/create_products/widgets/ProductAdditionalImages.dart';
import 'package:admin_panel/screens/products/create_products/widgets/ProductAttributes.dart';
import 'package:admin_panel/screens/products/create_products/widgets/ProductBrand.dart';
import 'package:admin_panel/screens/products/create_products/widgets/ProductCategories.dart';
import 'package:admin_panel/screens/products/create_products/widgets/ProductStockAndPricing.dart';
import 'package:admin_panel/screens/products/create_products/widgets/ProductThumnailImage.dart';
import 'package:admin_panel/screens/products/create_products/widgets/ProductTitleAndDescription.dart';
import 'package:admin_panel/screens/products/create_products/widgets/ProductTypeWidget.dart';
import 'package:admin_panel/screens/products/create_products/widgets/ProductVariantions.dart';
import 'package:admin_panel/screens/products/create_products/widgets/ProductVisibilityWidget.dart';
import 'package:admin_panel/screens/products/create_products/widgets/bottom_nav.dart';
import 'package:admin_panel/screens/products/create_products/widgets/product_tab_select.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/models/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProductsDesktop extends StatefulWidget {
  const CreateProductsDesktop({super.key});

  @override
  State<CreateProductsDesktop> createState() => _CreateProductsDesktopState();
}

class _CreateProductsDesktopState extends State<CreateProductsDesktop> {
  late final ProductImagesController controller;


     @override
  void initState() {
    super.initState();
    controller = Get.put(ProductImagesController());
  }
  @override
  Widget build(BuildContext context) {
  
    final dark = THelperFunctions.isDarkMode(context);
   
    return Scaffold(
      bottomNavigationBar: ProductBottomNav(), 
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: TSizes.spaceBetwwenSections),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: TDeviceUtils.isTabletScreen(context) ? 2 : 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ProductTitleAndDescription(),
                        const SizedBox(height: TSizes.spaceBetwwenSections),

                        TRoundedContainer(
                          radius: 5,
                          backgroundColor:
                              dark
                                  ? Colors.white.withOpacity(0.05)
                                  : Colors.white,
                          showBorder: true,
                          borderColor:
                              dark
                                  ? Colors.grey.withOpacity(0.5)
                                  : TColors.dark.withOpacity(0.2),
                          child: Padding(
                            padding: const EdgeInsets.all(TSizes.defaultSpace),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Stock & Pricing',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBetwwenItems,
                                ),

                                //Product Type
                                 ProductTypeWidget(),
                                const SizedBox(
                                  height: TSizes.spaceBetweenInputFields,
                                ),

                                //Stock
                                const ProductStockAndPricing(),
                                const SizedBox(
                                  height: TSizes.spaceBetwwenSections,
                                ),

                                //Product Type
                                const ProductAttributes(),
                                const SizedBox(
                                  height: TSizes.spaceBetwwenSections,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBetwwenSections),

                        //Variation
                        const ProductVariantions(),
                      ],
                    ),
                  ),
                  const SizedBox(width: TSizes.defaultSpace),

                  Expanded(
                    child: Column(
                      children: [
                        const ProductThumnailImage(),
                        const SizedBox(height: TSizes.spaceBetwwenSections),

                        //Product Images
                        TRoundedContainer(
                          backgroundColor:
                              dark
                                  ? Colors.white.withOpacity(0.05)
                                  : Colors.white,
                          showBorder: true,
                          borderColor:
                              dark
                                  ? Colors.grey.withOpacity(0.5)
                                  : TColors.dark.withOpacity(0.2),
                          padding: EdgeInsets.all(TSizes.defaultSpace),
                          radius: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'All Product Images',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: TSizes.spaceBetwwenItems),
                              ProductAdditionalImages(
                                additionalProductImagesURLs:controller.additionalProductImagesUrls,
                                onTapToAddImages: () => controller.selectMultipleProductImages(),
                                onTapToRemoveImages: (index) => controller.removeImage(index),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBetwwenSections),

                        const ProductBrand(),
                        const SizedBox(height: TSizes.spaceBetwwenSections),

                        const ProductCategories(),
                        const SizedBox(height: TSizes.spaceBetwwenSections),

                        const ProductOfferWidget(),
                         const SizedBox(height: TSizes.spaceBetwwenSections),
                        const TabConfigButtons(),
                        const SizedBox(height: TSizes.spaceBetwwenSections),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
