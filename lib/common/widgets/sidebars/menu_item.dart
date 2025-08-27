import 'package:admin_panel/common/widgets/sidebars/sidebar_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/image_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class TMenuItem extends StatelessWidget {
  const TMenuItem({
    super.key,
    required this.route,
    required this.icon,
    required this.itemname,  this.isEnabled = true,
  });

  final String route;
  final IconData icon;
  final String itemname;
  final bool isEnabled;
  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(SidebarController());
    final dark = THelperFunctions.isDarkMode(context);
    final imageController = Get.put(ProductImagesController());

    return InkWell(
      onTap: () {
         isEnabled ? menuController.menuOnTap(route) : null;
         imageController.selectedThumbnailImageUrl.value = null;
      },
      onHover:
          (hovering) =>
              isEnabled ? hovering
                  ? menuController.changeHoverItem(route)
                  : menuController.changeHoverItem('') : menuController.changeHoverItem(''),
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
          child: Container(
            decoration: BoxDecoration(
              color:
                  menuController.isHovering(route) ||
                          menuController.isActive(route)
                      ? TColors.primary
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: TSizes.lg,
                    top: TSizes.md,
                    bottom: TSizes.md,
                    right: TSizes.md,
                  ),
                  child:
                      menuController.isActive(route)
                          ? Icon(icon,size: 22 , color: TColors.textWhite)
                          : Icon(icon, size: 22, color: TColors.grey),
                ),

                if(menuController.isHovering(route) || menuController.isActive(route))
                Flexible(
                  child: Text(
                    itemname,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.apply(color: TColors.textWhite),
                  ),
                )
                else
                Flexible(
                  child: Text(
                    itemname,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.apply(color: dark ? TColors.grey : TColors.dark),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
