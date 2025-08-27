import 'package:admin_panel/common/widgets/images/image_uploader.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/screens/brands/create_brands/controller/brand_controller.dart';
import 'package:admin_panel/screens/media/widgets/media_content.dart';
import 'package:admin_panel/screens/products/create_products/controller/image_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/constants/validator.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/models/brand_model.dart';
import 'package:admin_panel/util/models/category_model.dart';
import 'package:admin_panel/util/models/image_model.dart';
import 'package:admin_panel/util/models/tab_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uuid/uuid.dart';

class CreateBrandForm extends StatefulWidget {
  const CreateBrandForm({super.key, required this.title, this.brandModel});

  final String title;
  final BrandModel? brandModel;

  @override
  State<CreateBrandForm> createState() => _CreateBrandFormState();
}

class _CreateBrandFormState extends State<CreateBrandForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _brandNameController = TextEditingController();
  bool _isFeatured = false;

  final BrandController controller = Get.put(BrandController());
    final imageController = Get.put(ProductImagesController());

  final RxList<CategoryModel> _tabs = <CategoryModel>[].obs;
  final RxnString _selectedTabId = RxnString(null);
@override
void initState() {
  super.initState();
  _fetchTabs();

  if (widget.brandModel != null) {
    _brandNameController.text = widget.brandModel!.title ?? '';
    _isFeatured = widget.brandModel!.isFeatured;
    _selectedTabId.value = widget.brandModel!.category;
    imageController.selectedThumbnailImageUrl.value = widget.brandModel!.imageUrl;
  }
}


  Future<void> _fetchTabs() async {
    try {
      final data = await controller.supabase
          .from('tab_categories')
          .select()
          .order('title');
      final tabs = (data as List)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      _tabs.assignAll(tabs);
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
        onImageSelected: (List<ImageModel> selectedImages) {
          if (selectedImages.isNotEmpty) {
            setState(() {
              ProductImagesController.instance.selectedThumbnailImageUrl = selectedImages.first.url as Rx<String?>;
            });
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _brandNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return TRoundedContainer(
      backgroundColor: dark ? Colors.white.withOpacity(0.05) : Colors.white,
      showBorder: true,
      borderColor: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: TSizes.sm),
            Text(widget.title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBetwwenSections),

            /// Brand Name
            TextFormField(
              controller: _brandNameController,
              validator: (value) => TValidator.validateEmptyText('Brand Name', value),
              decoration: const InputDecoration(
                labelText: 'Brand Name',
                prefixIcon: Icon(Iconsax.box),
              ),
            ),

            const SizedBox(height: TSizes.spaceBetweenInputFields * 2),

            /// Select Tabs (Categories)
            Text('Select Categories', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: TSizes.spaceBetweenInputFields / 2),

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

            /// Image Uploader
         Obx(() {
  final selectedImage = imageController.selectedThumbnailImageUrl.value;
  final imageToShow = (selectedImage != null && selectedImage.isNotEmpty)
      ? selectedImage
      : (widget.brandModel?.imageUrl ?? TImages.placeholder);

  return TImageUploader(
    width: 80,
    height: 80,
    isNetworkImage: (selectedImage != null && selectedImage.isNotEmpty) ? true : false,
    image: imageToShow,
    onIconButtonPressed: () => imageController.selectThumbnailImage(),
  );
}),


            const SizedBox(height: TSizes.spaceBetweenInputFields),

            /// Featured Checkbox
            CheckboxListTile(
              title: const Text('Featured'),
              value: _isFeatured,
              onChanged: (value) {
                setState(() => _isFeatured = value ?? false);
              },
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),

            const SizedBox(height: TSizes.spaceBetweenInputFields * 2),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                   if (_formKey.currentState!.validate() &&
                      imageController.selectedThumbnailImageUrl.value != null &&
                      _selectedTabId.value != null) {
                        final selectedTab = _tabs.firstWhereOrNull((tab) => tab.id == _selectedTabId.value);
final selectedTabTitle = selectedTab?.id ?? 'Unknown';

                    controller.uploadBrand(
                      id: Uuid().v4(),
                      context: context,
                      title: _brandNameController.text,
                      category: selectedTabTitle,
                      imageUrl: imageController.selectedThumbnailImageUrl.value!,
                      isFeatured: _isFeatured,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields and select category')),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: dark ? Colors.white.withOpacity(0.05) : TColors.primary,
                    border: Border.all(
                      color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
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
          ],
        ),
      ),
    );
  }
}
