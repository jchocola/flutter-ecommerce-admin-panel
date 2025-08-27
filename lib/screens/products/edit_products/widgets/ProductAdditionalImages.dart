import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/common/widgets/images/image_uploader.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';

import 'package:admin_panel/util/models/product_model/product_model.dart';

class ProductAdditionalImagesEdit extends StatelessWidget {
  const ProductAdditionalImagesEdit({
    super.key,
    required this.additionalProductImagesURLs,
    required this.onTapToAddImages,
    required this.onTapToRemoveImages,
    required this.product,
  });

  final RxList<String> additionalProductImagesURLs;
  final VoidCallback onTapToAddImages;
  final void Function(int index) onTapToRemoveImages;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTapToAddImages,
          child: TRoundedContainer(
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    TImages.placeholder,
                    width: 50,
                    height: 50,
                    color: dark ? Colors.white : TColors.dark,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Add Additional Product Images',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBetwwenItems),
        SizedBox(
          height: 80,
          child: Obx(() {
            final items = additionalProductImagesURLs;

            return ScrollConfiguration(
              behavior: _WebScrollBehavior(),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: items.length + 1,
                itemBuilder: (context, index) {
                  if (index < items.length) {
                    final image = items[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: TImageUploader(
                        top: 0,
                        right: 0,
                        width: 50,
                        height: 50,
                        image: image,
                        icon: Iconsax.trash,
                        onIconButtonPressed: () => onTapToRemoveImages(index),
                      ),
                    );
                  } else {
                    return TRoundedContainer(
                      width: 50,
                      height: 50,
                      radius: 5,
                      showBorder: true,
                      backgroundColor: Colors.transparent,
                      onTap: onTapToAddImages,
                      child: const Icon(Iconsax.add),
                    );
                  }
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _WebScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
