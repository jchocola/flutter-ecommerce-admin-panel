import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    this.width,
    this.height,
    this.imageUrl = '',
    this.applyImageRadius = false,
    this.border,
    this.backgroundColor = TColors.light,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = TSizes.md,
    this.imageProvider,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;
  final ImageProvider? imageProvider; // 🟢 Make this generic

  @override
  Widget build(BuildContext context) {
    final ImageProvider effectiveImageProvider =
        imageProvider ??
        (isNetworkImage
            ? NetworkImage(imageUrl)
            : AssetImage(imageUrl) as ImageProvider);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(TSizes.md),
        ),
        child: Hero(
          tag: Uuid().v4()+'$imageUrl' + Uuid().v1(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: FadeInImage(
              width: 180,
              height: 100,
              placeholderColor: Colors.grey,

              placeholder: AssetImage('assets/icons/placeholder.png'),
              image: effectiveImageProvider, // your Supabase public URL
              fadeInDuration: Duration(milliseconds: 500),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
