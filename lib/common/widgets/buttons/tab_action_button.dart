import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TTabActionButton extends StatelessWidget {
  const TTabActionButton({
    super.key,
    this.view = false,
    this.edit = true,
    this.delete = true,
    this.onViewPressed,
    this.onEditPressed,
    this.onDeletePressed,
  });

  final bool view, edit, delete;

  final VoidCallback? onViewPressed, onEditPressed, onDeletePressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        if (view)
          IconButton(
            onPressed: onViewPressed,
            icon: Icon(Iconsax.eye, color: dark ? Colors.white : TColors.dark),
          ),

        if (edit)
          IconButton(
            onPressed: onEditPressed,
            icon: Icon(Iconsax.pen_add, color: dark ? Colors.white : TColors.dark),
          ),

        if (delete)
          IconButton(
            onPressed: onDeletePressed,
            icon: Icon(Iconsax.trash, color: dark ? Colors.white : TColors.dark),
          ),
      ],
    );
  }
}
