import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/screens/products/create_products/controller/image_controller.dart';
import 'package:admin_panel/screens/products/edit_products/widgets/ProductAdditionalImages.dart';
import 'package:admin_panel/screens/products/edit_products/widgets/ProductAttributes.dart';
import 'package:admin_panel/screens/products/edit_products/widgets/ProductBrand.dart';
import 'package:admin_panel/screens/products/edit_products/widgets/ProductCategories.dart';
import 'package:admin_panel/screens/products/edit_products/widgets/ProductStockAndPricing.dart';
import 'package:admin_panel/screens/products/edit_products/widgets/ProductThumnailImage.dart';
import 'package:admin_panel/screens/products/edit_products/widgets/ProductTitleAndDescription.dart';
import 'package:admin_panel/screens/products/edit_products/widgets/ProductTypeWidget.dart';
import 'package:admin_panel/screens/products/edit_products/widgets/ProductVariantions.dart';
import 'package:admin_panel/screens/products/edit_products/widgets/ProductVisibilityWidget.dart';
import 'package:admin_panel/screens/products/edit_products/widgets/bottom_nav.dart';
import 'package:admin_panel/screens/products/edit_products/widgets/product_tab_select.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/models/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class EditProductsDesktop extends StatefulWidget {
  const EditProductsDesktop({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<EditProductsDesktop> createState() => _EditProductsDesktopState();
}

class _EditProductsDesktopState extends State<EditProductsDesktop> {
  final ProductImagesController controller = Get.put(ProductImagesController());

  @override
  void initState() {
    super.initState();

    // ✅ Safe state update
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.additionalProductImagesUrls.assignAll(widget.productModel.images ?? []);
      controller.additionalProductImagesUrls.refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    print(widget.productModel);

    return Scaffold(
      bottomNavigationBar: ProductBottomNavEdit(product: widget.productModel),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: RepaintBoundary(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: TSizes.spaceBetwwenSections),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column
                    Expanded(
                      flex: TDeviceUtils.isTabletScreen(context) ? 2 : 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductTitleAndDescriptionEdit(
                            title: widget.productModel.title,
                            descritpion: widget.productModel.description,
                          ),
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
                              padding: const EdgeInsets.all(TSizes.defaultSpace),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Stock & Pricing',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall),
                                  const SizedBox(
                                      height: TSizes.spaceBetwwenItems),
                                  ProductTypeWidgetEdit(
                                      type: widget.productModel.productType),
                                  const SizedBox(
                                      height: TSizes.spaceBetweenInputFields),
                                  ProductStockAndPricingEdit(
                                    stock: widget.productModel.stock,
                                    price: widget.productModel.price,
                                    discountPrice: widget.productModel.salesPrice,
                                  ),
                                  const SizedBox(
                                      height: TSizes.spaceBetwwenSections),
                                  ProductAttributesEdit(
                                    productAttributes: widget.productModel.productAttributes,
                                  ),
                                  const SizedBox(
                                      height: TSizes.spaceBetwwenSections),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBetwwenSections),
                          ProductVariantionsEdit(
                            productVariationModel: widget.productModel.variation,
                          ),
                        ],
                      ),
                    ),
            
                    const SizedBox(width: TSizes.defaultSpace),
            
                    // Right Column
                    Expanded(
                      child: Column(
                        children: [
                          ProductThumnailImageEdit(
                            thumbnailImage: widget.productModel.thumbnail,
                          ),
                          const SizedBox(height: TSizes.spaceBetwwenSections),
                          TRoundedContainer(
                            
                            backgroundColor: dark
                                ? Colors.white.withOpacity(0.05)
                                : Colors.white,
                            showBorder: true,
                            borderColor: dark
                                ? Colors.grey.withOpacity(0.5)
                                : TColors.dark.withOpacity(0.2),
                            padding: const EdgeInsets.all(TSizes.defaultSpace),
                            radius: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('All Product Images',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                                const SizedBox(
                                    height: TSizes.spaceBetwwenItems),
                                ProductAdditionalImagesEdit(
                                  product: widget.productModel,
                                  additionalProductImagesURLs:
                                      controller.additionalProductImagesUrls,
                                  onTapToAddImages:
                                      controller.selectMultipleProductImages,
                                  onTapToRemoveImages: controller.removeImage,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBetwwenSections),
                          ProductBrandEdit(selectedBrand: widget.productModel.brand),
                          const SizedBox(height: TSizes.spaceBetwwenSections),
                          ProductCategoriesEdit(
                              selectedCategories: widget.productModel.categories),
                          const SizedBox(height: TSizes.spaceBetwwenSections),
                          ProductOfferWidgetEdit(
                              selectedOffer: widget.productModel.offerValue),
                                 const SizedBox(height: TSizes.spaceBetwwenSections),
                          TabConfigButtonsEdit(tabID: widget.productModel.selectedTab),
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
      ),
    );
  }
}
