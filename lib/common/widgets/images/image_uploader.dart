import 'package:admin_panel/common/widgets/roundend_styles/t_circluar_image.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TImageUploader extends StatelessWidget {
  const TImageUploader({
    super.key,
     this.circular = false,
    this.image,
    this.width = 100,
    this.height = 100,
    this.memoryImage,
     this.icon = Iconsax.edit_2,
    this.top,
    this.bottom,
    this.right,
    this.left,
    this.onIconButtonPressed, this.isNetworkImage = true,
  });

  final bool circular;

  final String? image;

  final double width;

  final double height;

  final Uint8List? memoryImage;

  final IconData icon;

  final bool isNetworkImage;
  final double? top;

  final double? bottom;

  final double? right;

  final double? left;

  final void Function()? onIconButtonPressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        circular
        ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: TCircularImage(
            image: image ?? TImages.placeholder,
            width: width,
            height: height,
            isNetworkImage: isNetworkImage,
            backgroundColor: dark ? Colors.white.withOpacity(0.05) : TColors.primaryBackground,
          ),
        )

        : Padding(
          padding: const EdgeInsets.all(8.0),
          child: TRoundedImage(
            imageUrl: image ?? TImages.placeholder,
            width: width,
            height: height,
            border: Border.all(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2)),
            isNetworkImage: isNetworkImage,
            backgroundColor: dark ? Colors.white.withOpacity(0.05) : TColors.primaryBackground,
          ),
        ),

        Positioned(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
          child: GestureDetector(
            onTap: onIconButtonPressed,
            child: TRoundedContainer(
              backgroundColor: TColors.primary,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon, size: TSizes.md, color: Colors.white,),
              ))),
        )
      ],
    );
  }
}
