import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:iconsax/iconsax.dart';

class TTableHeader extends StatelessWidget {
  const TTableHeader({
    super.key,
    this.onPressed,
    required this.buttonText,
    this.searchController,
    this.searchOnChanged,
    this.isSecondBtn = false,
    this.secondButtonText = '',
     this.isSearch = true,
  });

  final Function()? onPressed;
  final String buttonText;

  final bool isSecondBtn, isSearch;
  final String secondButtonText;

  final TextEditingController? searchController;
  final Function(String)? searchOnChanged;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Expanded(
          flex: TDeviceUtils.isDesktopScreen(context) ? 3 : 1,
          child: Row(
            children: [
              SizedBox(
                width: 200,
                child: GestureDetector(
                  onTap: onPressed,
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          dark
                              ? Colors.white.withOpacity(0.05)
                              : TColors.primary,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color:
                            dark
                                ? Colors.grey.withOpacity(0.5)
                                : TColors.dark.withOpacity(0.2),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          color: dark ? TColors.textWhite : Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),

              if (isSecondBtn) const SizedBox(width: TSizes.defaultSpace),
              if (isSecondBtn)
                Flexible(
                  child: SizedBox(
                    width: 250,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(TRoutes.createCombo),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              dark
                                  ? Colors.white.withOpacity(0.05)
                                  : TColors.primary,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color:
                                dark
                                    ? Colors.grey.withOpacity(0.5)
                                    : TColors.dark.withOpacity(0.2),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            secondButtonText,
                            style: TextStyle(
                              color: dark ? TColors.textWhite : Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        if(isSearch)
        Expanded(
          flex: TDeviceUtils.isDesktopScreen(context) ? 2 : 1,
          child: TextFormField(
            controller: searchController,
            onChanged: searchOnChanged,
            decoration: InputDecoration(
              hintText: 'Search here...',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.grey), // Optional
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.white)
              ),
              prefixIcon: const Icon(Iconsax.search_normal),
            ),
          ),
        ),
      ],
    );
  }
}
