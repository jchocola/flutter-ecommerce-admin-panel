import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';

class TDialogs {
  static defaultDialog({
    required BuildContext context,
    String title = 'Remova; Confirmation',
    String content = 'Removing this data will delete all related data. Are you sure?',
    String cancelText = 'Cancel',
    String confirmText = 'Remove',
    bool? isNegetive = false,
    Function()? onCancel,
    Function()? onConfirm,
  }) {
    showDialog(context: context, builder: (BuildContext context) {
      final dark = THelperFunctions.isDarkMode(context);
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(onPressed: onCancel ?? () => Navigator.of(context).pop(),
           child: Text(cancelText),
           ),
           GestureDetector(
            onTap: onConfirm ?? () => Navigator.of(context).pop(),
            
            child: Container(
              decoration: BoxDecoration(
                color: TColors.primary,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: dark ? Colors.white.withOpacity(1) : TColors.dark.withOpacity(0.2), width: 0.5)
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(confirmText, style: TextStyle(),),
              ),
            ),
           )
       ],
      );
    });
  }
}