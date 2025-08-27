import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/common/widgets/sidebars/sidebar.dart';
import 'package:admin_panel/screens/products/create_products/controller/create_product_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/constants/validator.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProductTitleAndDescriptionEdit extends StatefulWidget {
   const ProductTitleAndDescriptionEdit({super.key, this.title, this.descritpion,});

  final String? title, descritpion;

  @override
  State<ProductTitleAndDescriptionEdit> createState() => _ProductTitleAndDescriptionEditState();



  
}

class _ProductTitleAndDescriptionEditState extends State<ProductTitleAndDescriptionEdit> {
    late TextEditingController? titleController;
    late TextEditingController? descriptionController;
      @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    descriptionController = TextEditingController(text: widget.descritpion);
  }
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(CreateProductController());

    controller.title.text = widget.title ?? '';
        controller.description.text = widget.descritpion ?? '';




    return TRoundedContainer(
      backgroundColor: dark ? Colors.white.withOpacity(0.05) : Colors.white,
      showBorder: true,
      radius: 5,
      key: controller.titleDesctiptionFormKeyEdit,
      borderColor: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
      child: Form(
        key: controller.titleDesctiptionFormKeyEdit,
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              Text('Basic Information', style: Theme.of(context).textTheme.headlineSmall,),
              const SizedBox(height: TSizes.spaceBetwwenItems,),
          
          
              TextFormField(
                controller: controller.title,
                validator: (value) => TValidator.validateEmptyText('Product Title', value),
                decoration:  InputDecoration(labelText: 'Product Title',
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
                          
                        ),),
              ),
              const SizedBox(height: TSizes.spaceBetweenInputFields,),
          
              Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: TextFormField(
                      expands: true,
                      controller: controller.description,
                      maxLines: null,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.multiline,
                      textAlignVertical: TextAlignVertical.top,
                      validator: (value) => TValidator.validateEmptyText('Product Description', value),
                      decoration:  InputDecoration(
                        labelText: 'Product Description',
                        hintText: 'Add your Product Description here...',
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
                  ),
                  const SizedBox(height: TSizes.spaceBetwwenItems,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        spacing: 10,
                        children: [
                          Image(image: AssetImage(TImages.generative_ai_icon), width: 20, height: 20,),
                          Text('Generate Desctiption with AI', style: Theme.of(context).textTheme.bodyLarge,)
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}