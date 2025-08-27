import 'package:admin_panel/common/widgets/dialogs/dialogs.dart';
import 'package:admin_panel/screens/products/create_products/controller/attributes_controller.dart';
import 'package:admin_panel/util/models/product_model/variation_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductVariantionsController extends GetxController {
  static ProductVariantionsController get instance => Get.find();

  final isLoading = false.obs;
  final RxList<ProductVariantionsModel> productVariantions = <ProductVariantionsModel>[].obs;

  List<Map<ProductVariantionsModel, TextEditingController>> stockControllersList = [];
  List<Map<ProductVariantionsModel, TextEditingController>> priceControllersList = [];
  List<Map<ProductVariantionsModel, TextEditingController>> salesControllersList = [];
  List<Map<ProductVariantionsModel, TextEditingController>> descriptionControllersList = [];
final RxMap<ProductVariantionsModel, double> variationPriceMap = <ProductVariantionsModel, double>{}.obs;

  final attributesController = Get.put(ProductAttributesController());

  void resetAllValues() {
    productVariantions.clear();
    stockControllersList.clear();
    priceControllersList.clear();
    salesControllersList.clear();
    descriptionControllersList.clear();
  }
final RxString? defaultVariationId = ''.obs;

void setDefaultVariation(String id) {
  defaultVariationId?.value = id;
}

  void removeVariations(BuildContext context) {
    TDialogs.defaultDialog(
      context: context,
      title: 'Remove Variations',
      onConfirm: () {
        resetAllValues();
        Navigator.of(context).pop();
      },
    );
  }

  void generateVariationConfirmation(BuildContext context) {
    TDialogs.defaultDialog(
      context: context,
      confirmText: 'Generate',
      title: 'Generate Variations',
      content:
          'Once the variations are created, you cannot add more attributes. In order to add more variations, you may have to delete any of the attributes',
      onConfirm: () => generateVariationFromAttributes(),
    );
  }

 void generateVariationFromAttributes() {
  Get.back();

  final List<ProductVariantionsModel> variations = [];

  final validAttributes = attributesController.productAttributes.where((attr) {
    final nameValid = (attr.name ?? '').trim().isNotEmpty;
    final valuesValid = attr.values != null &&
        attr.values!.isNotEmpty &&
        attr.values!.every((v) => v.trim().isNotEmpty);
    return nameValid && valuesValid;
  }).toList();

  if (validAttributes.isEmpty) {
    print('No valid attributes found to generate variations.');
    return;
  }

  final List<List<String>> attributeValuesList = validAttributes
      .map((attr) => attr.values!.map((v) => v.trim()).toList())
      .toList();

  final combinations = getCombination(attributeValuesList);

  if (combinations.isEmpty) {
    print('No attribute combinations generated.');
    return;
  }

  // Clear existing controller lists first:
  stockControllersList.clear();
  priceControllersList.clear();
  salesControllersList.clear();
  descriptionControllersList.clear();

  for (final combination in combinations) {
    if (combination.length != validAttributes.length) {
      print('Skipping invalid combination due to length mismatch: $combination');
      continue;
    }

    final Map<String, String> attributesValues = {};

    for (int i = 0; i < validAttributes.length; i++) {
      attributesValues[validAttributes[i].name!.trim()] = combination[i];
    }

    final variation = ProductVariantionsModel(
      id: UniqueKey().toString(),
      attributesValues: attributesValues,
    );

    variations.add(variation);

    // Initialize TextEditingControllers for this variation and add to each list
    stockControllersList.add({variation: TextEditingController()});
    priceControllersList.add({variation: TextEditingController()});
    salesControllersList.add({variation: TextEditingController()});
    descriptionControllersList.add({variation: TextEditingController()});
  }

  productVariantions.assignAll(variations);
  defaultVariationId?.value = (variations.isNotEmpty ? variations.first.id : null)!;

}


  List<List<String>> getCombination(List<List<String>> lists) {
    if (lists.isEmpty || lists.any((list) => list.isEmpty)) {
      return [];
    }
    final List<List<String>> result = [];
    _combineRecursive(lists, 0, [], result);
    return result;
  }

  void _combineRecursive(List<List<String>> lists, int index, List<String> current,
      List<List<String>> result) {
    if (index == lists.length) {
      result.add(List.from(current));
      return;
    }

    for (final item in lists[index]) {
      final updated = List<String>.from(current)..add(item);
      _combineRecursive(lists, index + 1, updated, result);
    }
  }

void initControllersForExistingVariations(List<ProductVariantionsModel> variations) {
  for (int i = 0; i < variations.length; i++) {
    final variation = variations[i];

   stockControllersList.add({variation: TextEditingController(text: variation.stock.toString())});
    priceControllersList.add({variation: TextEditingController(text: variation.price.toString())});
    salesControllersList.add({variation: TextEditingController(text: variation.salePrice.toString())});
    descriptionControllersList.add({variation: TextEditingController(text: variation.description ?? '')});

    if (variation.isDefault == true) {
      defaultVariationId!.value = variation.id;
    }
  }
}
}
