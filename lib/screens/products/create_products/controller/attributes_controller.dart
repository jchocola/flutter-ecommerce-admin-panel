import 'package:admin_panel/common/widgets/dialogs/dialogs.dart';
import 'package:admin_panel/screens/products/create_products/widgets/ProductVariantions.dart';
import 'package:admin_panel/util/models/product_model/attributes_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProductAttributesController extends GetxController{
  static ProductAttributesController get instance => Get.find();

  final isLoading = false.obs;
  final attributesFormKey = GlobalKey<FormState>();
    final attributesFormKeyEdit = GlobalKey<FormState>();

  TextEditingController attributeName = TextEditingController();
  TextEditingController attributes = TextEditingController();
  late final RxList<ProductAttributeModel> productAttributes = <ProductAttributeModel>[].obs;
final attributeNameController = TextEditingController();
final attributeValuesController = TextEditingController();

void addNewAttribute() {
  final name = attributeNameController.text.trim();
  final rawValues = attributeValuesController.text.trim();

  if (name.isEmpty || rawValues.isEmpty) return;

  final values = rawValues.split('|').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

  if (values.isEmpty) return;

  productAttributes.add(ProductAttributeModel(name: name, values: values));

  // Clear fields after adding
  attributeNameController.clear();
  attributeValuesController.clear();
}


  void removeAttributes(int index, BuildContext context) {
    TDialogs.defaultDialog(
      context: context,
      onConfirm: () {

        Navigator.of(context).pop();
        productAttributes.removeAt(index);

        //Reset product Variation
      }
    );
  }
}