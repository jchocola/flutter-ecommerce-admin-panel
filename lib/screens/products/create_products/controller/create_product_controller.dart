import 'package:admin_panel/screens/products/create_products/controller/attributes_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/image_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/product_repositpry.dart';
import 'package:admin_panel/screens/products/create_products/controller/variation_controller.dart';
import 'package:admin_panel/screens/settings/other_screens/user_activity_screen/controller/user_activity_controller.dart';
import 'package:admin_panel/util/formatters/enum.dart';
import 'package:admin_panel/util/models/brand_model.dart';
import 'package:admin_panel/util/models/category_model.dart';
import 'package:admin_panel/util/models/product_model/product_category_model.dart';
import 'package:admin_panel/util/models/product_model/product_model.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CreateProductController extends GetxController {
  static CreateProductController get instance => Get.find();

  final isLoading = false.obs;
  final productType = ProductType.single.obs;
  final productVisibilty = ProductVisibilty.hidden.obs;

  //Controllers and keys
  final stockPriceFormKey = GlobalKey<FormState>();
  final titleDesctiptionFormKey = GlobalKey<FormState>();
  final attributesFormKey = GlobalKey<FormState>();

  final stockPriceFormKeyEdit = GlobalKey<FormState>();
  final titleDesctiptionFormKeyEdit = GlobalKey<FormState>();
  final attributesFormKeyEdit = GlobalKey<FormState>();

  //Text Editing Controller
  TextEditingController title = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salesPrice = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  //Rx observables
  final Rx<BrandModel?> selectBrand = Rx<BrandModel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  final Rx<String?> selectedOffer = Rx<String?>(
    null,
  ); // null means no offer selected
  final Rx<String?> selectedTab = Rx<String?>(
    null,
  ); // null means no offer selected

  //Flags
  RxBool thumbnailUploader = false.obs;
  RxBool additionalImageUploader = false.obs;
  RxBool productDataUplaoder = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;
  var hasPriceChanged = false.obs;

  var hasDiscrountChanged = false.obs;
  var priceVar = ''.obs;
  var discountVar = ''.obs;
  final RxString priceText = ''.obs;
  final RxString salesPriceText = ''.obs;

  final RxString varPriceText = ''.obs;
  final RxString varSalesPriceText = ''.obs;
  @override
  void onInit() {
    super.onInit();

    price.addListener(() {
      hasPriceChanged.value = _isPriceChanged();
    });

    salesPrice.addListener(() {
      hasDiscrountChanged.value = _isDiscountChanged();
    });
  }

  bool _isPriceChanged() {
    return price.text != priceVar.value || price.text != priceVar.value;
  }
   bool _isDiscountChanged() {
    return salesPrice.text != discountVar.value || salesPrice.text != discountVar.value;
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      print('--- Debug: Check all values before updating product ---');

      print('title: ${title.text}');
      print('stock: ${stock.text}');
      print('price: ${price.text}');
      print('salesPrice: ${salesPrice.text}');
      print('description: ${description.text}');
      print('selectBrand.value: ${selectBrand.value}');
      print('productType.value: ${productType.value}');
      print('variationList length: ${product.variation?.length ?? 0}');

      try {
        print('selectedTab.value: ${selectedTab.value}');
      } catch (e) {
        print('Error printing selectedTab.value: $e');
      }

      print('selectedOffer.value: ${selectedOffer.value}');
      print('selectedCategories count: ${selectedCategories.length}');
      print(
        'productAttributes count: ${ProductAttributesController.instance.productAttributes.length}',
      );
      print('Payload to update: ${product.toJson()}');

      print('🛠️ Starting product update...');

      // Validate title/description form
      if (!(titleDesctiptionFormKeyEdit.currentState?.validate() ?? false)) {
        print('Title or description form invalid - returning');
        return;
      }
      print('Title/description form valid');

      // Validate stock/price form only if productType is single
      if (productType.value == ProductType.single &&
          !(stockPriceFormKeyEdit.currentState?.validate() ?? false)) {
        print('Stock or price form invalid - returning');
        return;
      }
      print('Stock/price form valid');

      // Brand must be selected
      if (selectBrand.value == null) {
        print('❌ Brand not selected - returning');
        Get.snackbar(
          'Error',
          'Please select a brand',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      print('Brand selected');

      // If variable product, variations must exist
      if (productType.value == ProductType.variable &&
          ProductVariantionsController.instance.productVariantions.isEmpty) {
        print('❌ No variations found for variable product - returning');
        Get.snackbar(
          'Error',
          'Add variations or change product type',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      print('Variations checked');

      // Prepare image controller and variation controller
      final imageController = ProductImagesController.instance;
      final variationController = ProductVariantionsController.instance;
      final variationList = variationController.productVariantions;

      // Mark default variation
      for (var v in variationList) {
        v.isDefault = (v.id == variationController.defaultVariationId?.value);
      }

      // If single product with no variations, reset variation controller
      if (productType.value == ProductType.single && variationList.isEmpty) {
        variationController.resetAllValues();
      }

      // Build updated ProductModel
      final updatedProduct = ProductModel(
        id: product.id ?? '',
        sku: '',
        isFeatured: true,
        title: title.text.trim(),
        brand: selectBrand.value,
        variation: productType.value == ProductType.single ? [] : variationList,
        description: description.text.trim(),
        productType: productType.value.toString(),
        stock:
            productType.value == ProductType.single
                ? int.tryParse(stock.text.trim())
                : null,
        price:
            productType.value == ProductType.single
                ? double.tryParse(price.text.trim())
                : null,
        images: imageController.additionalProductImagesUrls,
        salesPrice: double.tryParse(salesPrice.text.trim()) ?? 0,
        thumbnail: imageController.selectedThumbnailImageUrl.value ?? '',
        productAttributes:
            ProductAttributesController.instance.productAttributes,
        date: DateTime.now(),
        offerValue: selectedOffer.value,
        selectedTab: selectedTab.value,
        categories: selectedCategories,
      );

      productDataUplaoder.value = true;

      print('📦 Updating product...');
      print('🟡 Updated Product JSON: ${updatedProduct.toJson()}');

      final success = await ProductRepositpry.instance.updateProduct(
        updatedProduct,
      );

      // Handle categories linking if any selected
      if (selectedCategories.isNotEmpty) {
        categoriesRelationshipUploader.value = true;

        // Optional: Clear old relationships first
        await ProductRepositpry.instance.deleteProductCategories(product.id!);

        for (var category in selectedCategories) {
          final productCategory = ProductCategoryModel(
            id: Uuid().v4(),
            productId: product.id!,
            categoryId: category.id,
          );

          await ProductRepositpry.instance.uploadProductCategory(
            productCategory,
          );
        }

        print('✅ Categories linked');
      } else {
        print('No categories selected');
      }

      final logController = Get.put(UserActivityController());
      logController.updateUserLog('Product', 'Product Updated');

      Get.snackbar(
        'Success',
        'Product updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );

      productDataUplaoder.value = false;

      Get.offAllNamed(TRoutes.products);

      print('🚨 Finished updating product.');
    } catch (e, st) {
      print('❌ Error in updateProduct(): $e');
      print(st);
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  //Function
  Future<void> createProduct() async {
    try {
      print('🛠️ Starting product creation...');

      print("Validating title/desctiption form...");
      if (!titleDesctiptionFormKey.currentState!.validate()) {
        print('Title or description form invalid');
        return;
      }
      print("Title/description form validated.");

      print("Validating stock/price form if single product...");
      if (productType.value == ProductType.single &&
          !stockPriceFormKey.currentState!.validate()) {
        print('Stock or price form invalid');
        return;
      }
      print("Stock/price form validated.");

      if (selectBrand.value == null) {
        print('❌ Brand not selected');
        Get.snackbar(
          'Error',
          'Please select a brand',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (productType.value == ProductType.variable &&
          ProductVariantionsController.instance.productVariantions.isEmpty) {
        print('❌ No variations found for variable product');
        Get.snackbar(
          'Error',
          'Add variations or change product type',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (productType.value == ProductType.variable) {
        final variationCheckFailed = ProductVariantionsController
            .instance
            .productVariantions
            .any(
              (element) =>
                  element.price.isNaN ||
                  element.price < 0 ||
                  element.salePrice.isNaN ||
                  element.salePrice < 0 ||
                  element.stock.isNaN ||
                  element.stock < 0 ||
                  element.image.value.isEmpty,
            );

        if (variationCheckFailed) {
          print('❌ Variation data is invalid');
          Get.snackbar(
            'Error',
            'Variation data is invalid, please check',
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }
      }

      final imageController = ProductImagesController.instance;
      if (imageController.selectedThumbnailImageUrl.value == null ||
          imageController.selectedThumbnailImageUrl.value!.isEmpty) {
        print('❌ Thumbnail image not selected');
        Get.snackbar(
          'Error',
          'Please select a product thumbnail image',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final variationController = ProductVariantionsController.instance;
      final variationList = variationController.productVariantions;

      // Ensure only one is marked as default
      for (var v in variationList) {
        v.isDefault = (v.id == variationController.defaultVariationId?.value);
      }

      // If product is single and no variation, reset
      if (productType.value == ProductType.single && variationList.isEmpty) {
        variationController.resetAllValues();
      }

      final newRecord = ProductModel(
        id: Uuid().v4(),
        sku: '',
        isFeatured: true,
        title: title.text.trim(),
        brand: selectBrand.value,
        variation: variationList,
        description: description.text.trim(),
        productType: productType.value.toString(),
        stock: int.tryParse(stock.text.trim()) ?? 0,
        price: double.tryParse(price.text.trim()) ?? 0,
        images: imageController.additionalProductImagesUrls,
        salesPrice: double.tryParse(salesPrice.text.trim()) ?? 0,
        thumbnail: imageController.selectedThumbnailImageUrl.value ?? '',
        productAttributes:
            ProductAttributesController.instance.productAttributes,
        date: DateTime.now(),
        offerValue: selectedOffer.value,
        selectedTab: selectedTab.value,
        categories: selectedCategories,
      );

      productDataUplaoder.value = true;

      print('📦 Uploading product...');
      final newProductId = await ProductRepositpry.instance.uploadProduct(
        newRecord,
      );

      print('✅ Product uploaded with ID: $newProductId');

      if (selectedCategories.isNotEmpty) {
        categoriesRelationshipUploader.value = true;

        for (var category in selectedCategories) {
          final productCategory = ProductCategoryModel(
            id: Uuid().v4(),
            productId: newProductId,
            categoryId: category.id,
          );
          await ProductRepositpry.instance.uploadProductCategory(
            productCategory,
          );
        }
        print('✅ Categories linked');
      } else {
        print(' Categories not linked');
      }
      final logController = Get.put(UserActivityController());

      logController.updateUserLog('Product', 'Product Created');
      Get.snackbar(
        'Success',
        'Product created successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAllNamed(TRoutes.products);

      // Optionally clear form here or reset flags
    } catch (e) {
      print('❌ Error in createProduct(): $e');
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
}
