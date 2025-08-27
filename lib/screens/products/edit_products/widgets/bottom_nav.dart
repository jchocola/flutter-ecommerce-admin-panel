import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/screens/products/create_products/controller/create_product_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/models/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';

class ProductBottomNavEdit extends StatelessWidget {
  const ProductBottomNavEdit({super.key, this.product});

  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(CreateProductController());
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      child: TRoundedContainer(
        backgroundColor: dark ? Colors.white.withOpacity(0.05) : Colors.white,
        showBorder: true,
        
        borderColor: 
            dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2), 
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color:
                        dark
                            ? Colors.white.withOpacity(0.05)
                            : Colors.white.withOpacity(0.5),
                    border: Border.all(
                      color:
                          dark
                              ? TColors.grey.withOpacity(0.5)
                              : TColors.dark.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Discard',
                      style: TextStyle(
                        color: dark ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: TSizes.spaceBetwwenItems * 2),

              GestureDetector(
                onTap: () => controller.updateProduct(product!),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color:
                        dark ? TColors.primary : TColors.primary,
                    border: Border.all(
                      color:
                          dark
                              ? TColors.grey.withOpacity(0.5)
                              : TColors.dark.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Save Changes',
                      style: TextStyle(
                        color: dark ? TColors.textWhite : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
