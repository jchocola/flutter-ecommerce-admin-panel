import 'package:admin_panel/common/widgets/images/image_uploader.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/screens/brands/create_brands/controller/brand_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/image_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/constants/validator.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/models/brand_model.dart';
import 'package:admin_panel/util/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditBrandForm extends StatefulWidget {
  const EditBrandForm({super.key, required this.title, this.brandModel});

  final String title;
  final BrandModel? brandModel;

  @override
  State<EditBrandForm> createState() => _EditBrandFormState();
}

class _EditBrandFormState extends State<EditBrandForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _brandNameController = TextEditingController();
  bool _isFeatured = false;

  final BrandController controller = Get.put(BrandController());
  final imageController = Get.put(ProductImagesController());

  final RxList<CategoryModel> _tabs = <CategoryModel>[].obs;
  final RxnString _selectedTabId = RxnString();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await _fetchTabs();

    if (widget.brandModel != null) {
      _brandNameController.text = widget.brandModel!.title ?? '';
      _isFeatured = widget.brandModel!.isFeatured;
      _selectedTabId.value = widget.brandModel!.category;
      imageController.selectedThumbnailImageUrl.value = widget.brandModel!.imageUrl ?? '';
      setState(() {});
    }
  }

  Future<void> _fetchTabs() async {
    try {
      // final data = await controller.supabase.from('tab_categories').select().order('title');
      // final tabs = (data as List).map((e) => CategoryModel.fromJson(e)).toList();
     // _tabs.assignAll(tabs);
    } catch (e) {
      print("Failed to load tabs: $e");
    }
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

            /// Select Tabs
            Text('Select Category', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: TSizes.spaceBetweenInputFields / 2),

            Obx(() {
              if (_tabs.isEmpty) return const Text("Loading tabs...");

              return Wrap(
                spacing: 8,
                children: _tabs.map((tab) {
                  final isSelected = _selectedTabId.value == tab.id;
                  return ChoiceChip(
                    label: Text(tab.title ?? 'Untitled'),
                    selected: isSelected,
                    onSelected: (_) {
                      _selectedTabId.value = tab.id;
                    },
                  );
                }).toList(),
              );
            }),

            const SizedBox(height: TSizes.spaceBetweenInputFields * 2),

            /// Image Uploader
            Obx(() {
              final selectedImage = imageController.selectedThumbnailImageUrl.value;
              final imageToShow = selectedImage!.isNotEmpty
                  ? selectedImage
                  : (widget.brandModel?.imageUrl ?? TImages.placeholder);

              return TImageUploader(
                width: 80,
                height: 80,
                isNetworkImage: selectedImage.isNotEmpty,
                image: imageToShow,
                onIconButtonPressed: () => imageController.selectThumbnailImage(),
              );
            }),

            const SizedBox(height: TSizes.spaceBetweenInputFields),

            /// Featured
            CheckboxListTile(
              title: const Text('Featured'),
              value: _isFeatured,
              onChanged: (value) => setState(() => _isFeatured = value ?? false),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),

            const SizedBox(height: TSizes.spaceBetweenInputFields * 2),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleUpdate,
                child: const Text('Update Brand'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleUpdate() {
    if (_formKey.currentState!.validate() &&
        imageController.selectedThumbnailImageUrl.value!.isNotEmpty &&
        _selectedTabId.value != null &&
        widget.brandModel != null) {
      controller.updateBrand(
        id: widget.brandModel!.id,
        context: context,
        title: _brandNameController.text,
        category: _selectedTabId.value!,
        imageUrl: imageController.selectedThumbnailImageUrl.value!,
        isFeatured: _isFeatured,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and select category')),
      );
    }
  }
}
