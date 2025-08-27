import 'package:admin_panel/common/widgets/images/image_uploader.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages({
    super.key,
    required this.additionalProductImagesURLs,
    this.onTapToAddImages,
    this.onTapToRemoveImages,
  });

  final RxList<String> additionalProductImagesURLs;
  final void Function()? onTapToAddImages;
  final void Function(int index)? onTapToRemoveImages;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Top section for adding images
        GestureDetector(
          onTap: onTapToAddImages,
          child: TRoundedContainer(
            radius: 5,
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
                  const Text('Add Additional Product Images', textAlign: TextAlign.center,),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: TSizes.spaceBetwwenItems),

        /// Bottom scrollable row with improved ScrollBehavior for web
        SizedBox(
          height: 80,
          child: Obx(() {
            final items = additionalProductImagesURLs;

            return ScrollConfiguration(
              behavior: _WebScrollBehavior(),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: items.length + 1, // +1 for the add button
                separatorBuilder: (_, __) =>
                    const SizedBox(width: TSizes.spaceBetwwenItems / 2),
                itemBuilder: (context, index) {
                  if (index < items.length) {
                    final image = items[index];
                    return TImageUploader(
                      top: 0,
                      right: 0,
                      width: 50,
                      height: 50,
                      image: image,
                      icon: Iconsax.trash,
                      onIconButtonPressed: () => onTapToRemoveImages?.call(index),
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

/// Custom scroll behavior for web to support mouse wheel and drag
class _WebScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse, // Enable mouse dragging on web
      };
}
