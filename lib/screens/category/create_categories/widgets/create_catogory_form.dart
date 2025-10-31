import 'dart:io';

import 'package:admin_panel/common/widgets/images/image_uploader.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/controllers/category_controller.dart';
import 'package:admin_panel/screens/category/controllers/category_controller.dart';
import 'package:admin_panel/screens/media/widgets/media_content.dart';
import 'package:admin_panel/screens/products/create_products/controller/image_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/constants/validator.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/models/category_model.dart';
import 'package:admin_panel/util/models/image_model.dart';
import 'package:admin_panel/util/models/tab_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uuid/uuid.dart';

class CreateCategoryForm extends StatefulWidget {
  const CreateCategoryForm({super.key});

  @override
  State<CreateCategoryForm> createState() => _CreateCategoryFormState();
}

class _CreateCategoryFormState extends State<CreateCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _categoryNameController = TextEditingController();

  final CategoryController controller = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
  }

  Future<void> onCreateTapped() async {
    // generate category id
    final categoryId = Uuid().v4().substring(0, 8);

    // upload and get image url
    final imageUrl = await Get.find<CategoryControllerCustom>()
        .uploadImageandGetUrl(categoryId: categoryId);

    // create category
    final category = CustomCategoryModel(
      id: categoryId,
      title: _categoryNameController.text,
      imageUrl: imageUrl,
    );

    try {
      await Get.find<CategoryControllerCustom>()
          .createCategory(category: category)
          .then((value) {
            Get.snackbar('Success', 'Category created successfully!');
          });
    } catch (e) {
      Get.snackbar('Error', 'Failed to create category: $e');
    }
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final imageController = Get.put(ProductImagesController());
    final catagoryController = Get.find<CategoryControllerCustom>();
    return TRoundedContainer(
      backgroundColor: dark ? Colors.white.withOpacity(0.05) : Colors.white,
      showBorder: true,
      borderColor:
          dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: TSizes.sm),
            Text(
              'Create New Category',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBetwwenSections),

            /// Name input
            TextFormField(
              controller: _categoryNameController,
              validator: (value) => TValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                labelText: 'Category Name',
                prefixIcon: Icon(Iconsax.category),
              ),
            ),

            const SizedBox(height: TSizes.spaceBetweenInputFields * 2),

            /// Image Picker
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => catagoryController.pickImage(),
                  icon: const Icon(Iconsax.image),
                ),
                Obx(
                  () => SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.network(
                      catagoryController.pickedFile.value?.files.first.path ??
                          '',
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: TSizes.spaceBetweenInputFields),

            const SizedBox(height: TSizes.spaceBetweenInputFields),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () => onCreateTapped(),
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        dark ? Colors.white.withOpacity(0.05) : TColors.primary,
                    border: Border.all(
                      color:
                          dark
                              ? Colors.grey.withOpacity(0.5)
                              : TColors.dark.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Obx(() {
                    return controller.isLoading.value == true
                        ? const Center(child: CircularProgressIndicator())
                        : Text(
                          'Create',
                          style: TextStyle(
                            color: dark ? TColors.textWhite : Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        );
                  }),
                ),
              ),
            ),

            const SizedBox(height: TSizes.spaceBetweenInputFields * 2),
          ],
        ),
      ),
    );
  }
}
