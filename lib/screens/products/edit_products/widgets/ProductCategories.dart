import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/screens/category/controllers/category_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/create_product_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:uuid/uuid.dart';

class ProductCategoriesEdit extends StatefulWidget {
  const ProductCategoriesEdit({super.key, this.selectedCategories});
  final List<CategoryModel>? selectedCategories;

  @override
  State<ProductCategoriesEdit> createState() => _ProductCategoriesEditState();
}

class _ProductCategoriesEditState extends State<ProductCategoriesEdit> {
  final categoryController = Get.put(CategoryController());
  final productController = CreateProductController.instance;

  @override
  void initState() {
    super.initState();

    /// ✅ Set selected categories for editing (optional)
    if (widget.selectedCategories != null &&
        widget.selectedCategories!.isNotEmpty &&
        productController.selectedCategories.isEmpty) {
      productController.selectedCategories.assignAll(widget.selectedCategories!);
    }

    /// ✅ Load categories from Supabase after frame build
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (categoryController.categories.isEmpty) {
        await categoryController.loadCategories();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return TRoundedContainer(
      backgroundColor: dark ? Colors.white.withOpacity(0.05) : Colors.white,
      showBorder: true,
      radius: 5,
      borderColor: dark
          ? Colors.grey.withOpacity(0.5)
          : TColors.dark.withOpacity(0.2),
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBetwwenItems),
          Obx(() {
            final allCategories = categoryController.categories;

            if (allCategories.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return MultiSelectDialogField<CategoryModel>(
              buttonText: const Text('Select Categories'),
              title: const Text('Categories'),
              items: allCategories
                  .map((cat) => MultiSelectItem(cat, cat.title ?? 'Unknown'))
                  .toList(),
              listType: MultiSelectListType.CHIP,
              initialValue: productController.selectedCategories,
              onConfirm: (selected) {
                productController.selectedCategories.assignAll(selected);
              },
            );
          }),
        ],
      ),
    );
  }
}
