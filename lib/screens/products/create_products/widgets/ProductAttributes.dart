import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/products/create_products/controller/attributes_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/create_product_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/variation_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/constants/validator.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/formatters/enum.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    final productController = CreateProductController.instance;
    final attributeController = Get.put(ProductAttributesController());
     final variationController = Get.put(ProductVariantionsController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return productController.productType.value == ProductType.single
          ? const Column(children: [
            Divider(color: TColors.primaryBackground,),
            SizedBox(height: TSizes.spaceBetwwenSections,)
          ])
          : const SizedBox.shrink();
        }),

        Text('Add Product Attributes', style: Theme.of(context).textTheme.headlineSmall,),
        const SizedBox(height: TSizes.spaceBetwwenItems,),

        Form(
          key: attributeController.attributesFormKeyEdit,
          child: TDeviceUtils.isDesktopScreen(context)
          ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildAttributesName()),
              const SizedBox(width: TSizes.spaceBetwwenItems,),
              Expanded(
                flex: 2,
                child: _buildAttributesTextField(),
              ),
              const SizedBox(width: TSizes.spaceBetwwenItems,),
              _buildAddAttributesButton(),
            ],
          ) : Column(
            children: [
              _buildAttributesName(),
              const SizedBox(height: TSizes.spaceBetwwenItems,),
              _buildAttributesTextField(),
              const SizedBox(height: TSizes.spaceBetwwenItems,),
              _buildAddAttributesButton(),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBetwwenSections,),

        Text('All Attributes', style: Theme.of(context).textTheme.headlineSmall,),
        const SizedBox(height: TSizes.spaceBetwwenItems,),

        TRoundedContainer(
          backgroundColor: dark ? TColors.dark.withOpacity(0.05) : TColors.dark.withOpacity(0.2),
          showBorder: true,
          radius: 5,
          borderColor: dark ? Colors.grey.withOpacity(0.15) : TColors.dark.withOpacity(0.01),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              return attributeController.productAttributes.isNotEmpty
              ? ListView.separated(
                shrinkWrap: true,
                itemCount: attributeController.productAttributes.length,
                separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBetwwenItems,),
                itemBuilder: (_, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: TColors.dark,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(attributeController.productAttributes[index].name ?? ''),
                      subtitle: Text(attributeController.productAttributes[index].values!.map((e) => e.trim()).toString()),
                      trailing: IconButton(
                        onPressed: () => attributeController.removeAttributes(index, context),
                        icon: const Icon(Iconsax.trash, color: Colors.red,),
                      ),
                    ),
                  );
                },
              ) :  Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                                  Lottie.asset(TImages.no_data_animation, width: 300, height: 300, repeat: false),

                    ],
                  ),
                  SizedBox(height: TSizes.spaceBetwwenItems,),
                  Text('There are no attributes added for this product')
                ],
              );
            }),
          ),
        ),
        Obx(() {
          return productController.productType.value == ProductType.variable && variationController.productVariantions.isEmpty
          ? Center(
            child: SizedBox(
              width: 200,
              child: GestureDetector(
                onTap: () =>  variationController.generateVariationConfirmation(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: TColors.primary,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text('Generate Variations', textAlign: TextAlign.center, ),
                  ),
                ),
              )
            ),
          )
          : const SizedBox.shrink();
        })
      ],
    );
  }
}

Column buildEmptyAttributes() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(TImages.no_data_animation, width: 300, height: 300),
        ],
      ),
      const SizedBox(height: TSizes.spaceBetwwenItems,),
      const Text('There are no attributes added for this product')
    ],
  );
}

ListView buildAttributesList(BuildContext context, ProductAttributesController controller) {
  return ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(), // Prevent scroll conflict if inside scrollable
    itemCount: controller.productAttributes.length, // ✅ dynamic count
    separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBetwwenItems),
    itemBuilder: (_, index) {
      final attribute = controller.productAttributes[index];

      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? TColors.dark.withOpacity(0.05)
              : Colors.white,
          borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
        ),
        child: ListTile(
  title: Text(attribute.name?.trim().isNotEmpty == true ? attribute.name! : 'Unnamed Attribute'),
  subtitle: Text(
    attribute.values != null && attribute.values!.isNotEmpty
        ? attribute.values!
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .join(', ')
        : 'No values',
  ),
  trailing: IconButton(
    onPressed: () => controller.removeAttributes(index, context),
    icon: const Icon(Iconsax.trash, color: Colors.red),
  ),
),

      );
    },
  );
}


SizedBox _buildAddAttributesButton() {
  final dark = THelperFunctions.isDarkMode(Get.context!);
  final controller = Get.put(ProductAttributesController());
  return SizedBox(
    child: GestureDetector(
      onTap: () => controller.addNewAttribute(),
      child: TRoundedContainer(
        radius: 5,
        showBorder: true,
        borderColor: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
        backgroundColor: dark ? TColors.primary : TColors.primary,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text('Add', style: TextStyle(color: dark ? Colors.white : Colors.white),),
        ),
      ),
    ),
  );
}

TextFormField _buildAttributesName() {
  final controller = Get.find<ProductAttributesController>();
  final dark = THelperFunctions.isDarkMode(Get.context!);
  return TextFormField(
    controller: controller.attributeNameController,
    validator: (value) => TValidator.validateEmptyText('Attributes Name', value),
    decoration:  InputDecoration(labelText: 'Attributes Name', hintText: 'Colors, Sizes, Materials',
     enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2)),
                          
                        ),
                         focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: dark ? Colors.white.withOpacity(1) : TColors.dark.withOpacity(1)),
                          
                        ),
                         errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.red),
                          
                        ),
    ),
  );
}

SizedBox _buildAttributesTextField() {
  final controller = Get.find<ProductAttributesController>();
  final dark = THelperFunctions.isDarkMode(Get.context!);
  return SizedBox(
    height: 80,
    child: TextFormField(
      controller: controller.attributeValuesController,
      expands: true,
      maxLines: null,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.multiline,
      textAlignVertical: TextAlignVertical.top,
      validator: (value) => TValidator.validateEmptyText('Attributes Field', value),
      decoration:  InputDecoration(
        labelText: 'Attributes',
        hintText: 'Add attributes separated by | Example: Green | Blue | Yellow',
        alignLabelWithHint: true,
         enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2)),
                          
                        ),
                         focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: dark ? Colors.white.withOpacity(1) : TColors.dark.withOpacity(1)),
                          
                        ),
                         errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.red),
                          
                        ),
      ),
    ),
  );
}
