import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/banners/create_banners/controller/banner_controller.dart';
import 'package:admin_panel/screens/media/widgets/media_content.dart';
import 'package:admin_panel/screens/products/controller/product_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/image_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/models/banner_model.dart';
import 'package:admin_panel/util/models/image_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';

class Editbannerform extends StatefulWidget {
  const Editbannerform({super.key, required this.title, required this.banner});
  final String title;
  final BannerModel banner;

  @override
  State<Editbannerform> createState() => _EditbannerformState();
}

class _EditbannerformState extends State<Editbannerform> {
  String? _selectedImageUrl;
  bool _isActive = true;
  String _selectedLocation = 'search';
  String? _selectedProductId;
    final controller = Get.put(BannerController());


  void _openMediaPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (_) => MediaContent(
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
  void initState(){
    super.initState();
    controller.fetchProducts();

    setState(() {
      _isActive = widget.banner.isActive!;
      controller.selectedLocation.value = widget.banner.value!;
      controller.selectedCateogryID.value = widget.banner.location ?? null;
      controller.selectedProductId.value = widget.banner.redirectScreen ?? null;
    });
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: TSizes.sm),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBetwwenSections),

            /// Image Picker Section
            Column(
              children: [
                Obx(
                  () => GestureDetector(
                    child: TRoundedImage(
                      width: 400,
                      height: 200,
                      border: Border.all(
                        color:
                            dark
                                ? Colors.grey.withOpacity(0.5)
                                : TColors.dark.withOpacity(0.2),
                      ),
                      backgroundColor: Colors.white.withOpacity(0.05),
                      fit:
                          imageController.selectedThumbnailImageUrl.value !=
                                  null
                              ? BoxFit.cover
                              : BoxFit.contain,
                      imageUrl:
                          imageController.selectedThumbnailImageUrl.value ??
                          widget.banner.imageUrl!,
                      isNetworkImage: true,
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBetwwenItems),
                TextButton(
                  onPressed: imageController.selectThumbnailImage,
                  child: const Text('Select Image'),
                ),
              ],
            ),

            const SizedBox(height: TSizes.spaceBetweenInputFields),

            /// Checkbox
            Text(
              'Make your Banner Active or Inactive',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            CheckboxListTile(
              value: _isActive,
              onChanged: (value) => setState(() => _isActive = value ?? true),
              title: const Text('Active'),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),

            const SizedBox(height: TSizes.spaceBetweenInputFields),

            /// Dropdown
       Row(
  children: [
    Expanded(
      child: DropdownButton<String>(
        isExpanded: true,
        value: controller.selectedLocation.value,
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() => controller.selectedLocation.value = newValue);
          }
        },
        items: const [
          DropdownMenuItem<String>(value: 'home', child: Text('Home')),
          DropdownMenuItem<String>(value: 'search', child: Text('Search')),
          DropdownMenuItem<String>(value: 'store', child: Text('Store')),
          DropdownMenuItem<String>(value: 'products', child: Text('Specific Products')),
        ],
      ),
    ),

    const SizedBox(width: TSizes.spaceBetwwenItems),

    Expanded(
      child: Obx(() {
        if (controller.products.isEmpty) {
          return const CircularProgressIndicator();
        } else if (controller.selectedLocation == 'products') {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton<String>(
                isExpanded: true,
                value: controller.selectedProductId.value,
                hint: const Text('Select Product'),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() => controller.selectedProductId.value = newValue);
                  }
                },
                items: controller.products.map((product) {
                  return DropdownMenuItem<String>(
                    value: product['id'] as String?,
                    child: Text(product['title'] ?? 'No Title', overflow: TextOverflow.ellipsis),
                  );
                }).toList(),
              ),
               Text('Products Banner will appear in home screen', style: Theme.of(context).textTheme.labelSmall,),
            ],
          );
        } else if (controller.selectedLocation != 'products') {
          return Column(
            children: [
              DropdownButton<String>(
                isExpanded: true,
                value: controller.selectedCateogryID.value,
                hint: const Text('Select Category'),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() => controller.selectedCateogryID.value = newValue);
                  }
                },
                items: controller.categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category['id'] as String?,
                    child: Text(category['title'] ?? 'No Title', overflow: TextOverflow.ellipsis),
                  );
                }).toList(),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      }),
    ),
    
  ],
),


            const SizedBox(height: TSizes.spaceBetweenInputFields * 2),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  print('✅ Create Banner');
                  print(
                    'Image URL: ${imageController.selectedThumbnailImageUrl.value}',
                  );
                  print('Active: $_isActive');
                  print('Location: $_selectedLocation');
                  // Upload logic goes here
                  controller.updateBanner(
                    context: context,
                    location: controller.selectedCateogryID.toString(),
                    imageUrl:
                        imageController.selectedThumbnailImageUrl.value ?? widget.banner.imageUrl!,
                    isActive: _isActive, bannerId: widget.banner.id!,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        dark ? Colors.white.withOpacity(0.05) : TColors.primary,
                    border: Border.all(
                      color: dark ? TColors.dark : Colors.white,
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
