import 'package:admin_panel/common/widgets/images/image_uploader.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
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

class EditCategoryForm extends StatefulWidget {
  const EditCategoryForm({super.key, required this.category});

  final CustomCategoryModel category;

  @override
  State<EditCategoryForm> createState() => _EditCategoryFormState();
}

class _EditCategoryFormState extends State<EditCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _categoryNameController;
  String? _selectedImageUrl;
  bool? _isFeatured;

  final CategoryController controller = Get.put(CategoryController());

  final RxList<TabModel> _tabs = <TabModel>[].obs;
  final RxnString _selectedTabId = RxnString(null); // Nullable reactive string

  @override
  void initState() {
    super.initState();
    _categoryNameController = TextEditingController(text: widget.category.title);
    //_isFeatured = widget.category.isIcon;
   // _selectedTabId.value = widget.category.tab_id;
    _fetchTabs();
  }

  Future<void> _fetchTabs() async {
    try {
      // final data = await controller.supabase
      //     .from('tab_config')
      //     .select()
      //     .order('title');
      // final tabs = (data as List)
      //     .map((e) => TabModel.fromJson(e as Map<String, dynamic>))
      //     .toList();
      //_tabs.assignAll(tabs);
    } catch (e) {
      print("Failed to load tabs: $e");
    }
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => MediaContent(
        allowSelection: true,
        allowMultipleSelection: false,
        onImageSelected: (List<ImageModel> selectedImages) {
          if (selectedImages.isNotEmpty) {
            setState(() {
              _selectedImageUrl = selectedImages.first.url;
            });
            Navigator.pop(context);
          }
        },
      ),
    );
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
              'Update Category',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(widget.category.title!,
            style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.primary),),
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

            /// Tab selection chips
            Obx(() {
              if (_tabs.isEmpty) {
                return const Text("Loading tabs...");
              }

              return Wrap(
                spacing: 8,
                children: _tabs.map((tab) {
                  
                  final isSelected = _selectedTabId.value == tab.id;
                  return ChoiceChip(
                    label: Text(tab.title ?? 'Untitled'),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        _selectedTabId.value = tab.id;
                      } else {
                        _selectedTabId.value = null;
                      }
                    },
                  );
                }).toList(),
              );
            }),

            const SizedBox(height: TSizes.spaceBetweenInputFields * 2),

            /// Image Picker using GetX controller
            Obx(() => TImageUploader(
                  width: 80,
                  height: 80,
                  image: imageController.selectedThumbnailImageUrl.value ??
                      widget.category.imageUrl,
                  onIconButtonPressed: () =>
                      imageController.selectThumbnailImage(),
                )),

            const SizedBox(height: TSizes.spaceBetweenInputFields),

            /// Featured Checkbox
            CheckboxListTile(
              title: const Text('Is this Icon? Tick it'),
              value: true,
              onChanged: (value) {
                setState(() => _isFeatured = value ?? false);
              },
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),

            const SizedBox(height: TSizes.spaceBetweenInputFields),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  final selectedImage = imageController.selectedThumbnailImageUrl.value;
                  final selectedTab = _selectedTabId.value;

                  if (_formKey.currentState!.validate() &&
                      selectedImage != null &&
                      selectedTab != null || widget.category.imageUrl != null && widget.category.title != null) {
                    controller.updateCategory(
                      context: context,
                      title: _categoryNameController.text,
                      imageUrl: (selectedImage ?? widget.category.imageUrl) ?? '',
                      isIcon: _isFeatured ?? false,
                      tabId: selectedTab!,
                      id: widget.category.id ?? '',
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Please complete all fields including image and tab'),
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: dark
                        ? Colors.white.withOpacity(0.05)
                        : TColors.primary,
                    border: Border.all(
                      color: dark
                          ? Colors.grey.withOpacity(0.5)
                          : TColors.dark.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Update',
                    style: TextStyle(
                      color: dark ? TColors.textWhite : Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
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
