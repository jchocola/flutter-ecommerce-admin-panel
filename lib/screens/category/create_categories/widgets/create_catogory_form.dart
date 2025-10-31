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
import 'package:admin_panel/util/models/image_model.dart';
import 'package:admin_panel/util/models/tab_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CreateCategoryForm extends StatefulWidget {
  const CreateCategoryForm({super.key});

  @override
  State<CreateCategoryForm> createState() => _CreateCategoryFormState();
}

class _CreateCategoryFormState extends State<CreateCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _categoryNameController = TextEditingController();
  String? _selectedImageUrl;
  bool _isFeatured = false;

  final CategoryController controller = Get.put(CategoryController());

  final RxList<TabModel> _tabsHome = <TabModel>[].obs;
  final RxList<TabModel> _tabsStore = <TabModel>[].obs;

  final RxnString _selectedTabId = RxnString(null); // Nullable reactive string

  @override
  void initState() {
    super.initState();
    _fetchHomeTabs();
    _fetchStoreTabs();
  }

  Future<void> _fetchHomeTabs() async {
    try {
      // final data = await controller.supabase
      //     .from('tab_config')
      //     .select()
      //     .eq('tab_location', 'home')
      //     .order('title');
      // final tabs =
      //     (data as List)
      //         .map((e) => TabModel.fromJson(e as Map<String, dynamic>))
      //         .toList();
     // _tabsHome.assignAll(tabs);
    } catch (e) {
      print("Failed to load tabs: $e");
    }
  }

  Future<void> _fetchStoreTabs() async {
    try {
      // final data = await controller.supabase
      //     .from('tab_config')
      //     .select()
      //     .eq('tab_location', 'store')
      //     .order('title');
      // final tabs =
      //     (data as List)
      //         .map((e) => TabModel.fromJson(e as Map<String, dynamic>))
      //         .toList();
      //_tabsStore.assignAll(tabs);
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
      builder:
          (_) => MediaContent(
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

            /// Tab selection chips
            ///
            // Text('Home screen Tabs'),
            // const SizedBox(height: TSizes.spaceBetwwenItems,),
            // Obx(() {
            //   if (_tabsHome.isEmpty) {
            //     return const Text("Loading tabs...");
            //   }

            //   return Wrap(
            //     spacing: 8,
            //     children:
            //         _tabsHome.map((tab) {
            //           final isSelected = _selectedTabId.value == tab.id;
            //           return ChoiceChip(
            //             label: Text(tab.title ?? 'Untitled'),
            //             selected: isSelected,
            //             onSelected: (selected) {
            //               if (selected) {
            //                 _selectedTabId.value = tab.id;
            //               } else {
            //                 _selectedTabId.value = null;
            //               }
            //             },
            //           );
            //         }).toList(),
            //   );
            // }),
            // const SizedBox(height: TSizes.spaceBetwwenSections,),
            // Text('Store screen Tabs'),
            // const SizedBox(height: TSizes.spaceBetwwenItems,),
            // Obx(() {
            //   if (_tabsStore.isEmpty) {
            //     return const Text("Loading tabs...");
            //   }

            //   return Wrap(
            //     spacing: 8,
            //     children:
            //         _tabsStore.map((tab) {
            //           final isSelected = _selectedTabId.value == tab.id;
            //           return ChoiceChip(
            //             label: Text(tab.title ?? 'Untitled'),
            //             selected: isSelected,
            //             onSelected: (selected) {
            //               if (selected) {
            //                 _selectedTabId.value = tab.id;
            //               } else {
            //                 _selectedTabId.value = null;
            //               }
            //             },
            //           );
            //         }).toList(),
            //   );
            // }),
            // const SizedBox(height: TSizes.spaceBetweenInputFields * 2),

            /// Image Picker using GetX controller
          

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: ()=>catagoryController.pickImage(), icon: const Icon(Iconsax.image)),
                Obx(
                  ()=> SizedBox( height :80, width: 80 , child:  Image.network(
                    catagoryController.pickedFile.value?.files.first.path ?? ''
                  ))
                ),
              ],
            ),

            const SizedBox(height: TSizes.spaceBetweenInputFields),

            /// Featured Checkbox
            // CheckboxListTile(
            //   title: const Text('Is this Icon? Tick it'),
            //   value: _isFeatured,
            //   onChanged: (value) {
            //     setState(() => _isFeatured = value ?? false);
            //   },
            //   controlAffinity: ListTileControlAffinity.leading,
            //   contentPadding: EdgeInsets.zero,
            // ),

            const SizedBox(height: TSizes.spaceBetweenInputFields),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  final selectedImage =
                      imageController.selectedThumbnailImageUrl.value;
                  final selectedTab = _selectedTabId.value;

                  if (_formKey.currentState!.validate() &&
                      selectedImage != null &&
                      selectedTab != null) {
                    controller.uploadCategory(
                      context: context,
                      title: _categoryNameController.text,
                      imageUrl: selectedImage,
                      isIcon: _isFeatured,
                      tabId: selectedTab,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please complete all fields including image and tab',
                        ),
                      ),
                    );
                  }
                },
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
                  child: Text(
                    'Create',
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
