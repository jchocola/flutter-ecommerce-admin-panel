import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/formatters/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class THelperFunctions {

  static DateTime getStartOfWeek(DateTime date) {
    final int daysUntilMonday = date.weekday - 1;
    final DateTime startOfWeek = date.subtract(Duration(days: daysUntilMonday));
    return DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day, 0,0,0,0,0);
  }
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color getOrderStatusColor(OrderStatus value) {
    if (OrderStatus.placed == value) {
      return Colors.blue;
    } else if (OrderStatus.processing == value) {
      return Colors.orange;
    } else if (OrderStatus.shipped == value) {
      return Colors.purple;
    } else if (OrderStatus.delivered == value) {
      return Colors.green;
    } else if(OrderStatus.cancelled == value) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }
   static Color getOrderStatusColorByModel(String value) {
    if ('placed' == value) {
      return Colors.blue;
    } else if ('processing' == value) {
      return Colors.orange;
    } else if ('shipped' == value) {
      return const Color.fromARGB(255, 217, 0, 255);
    } else if ('delivered' == value) {
      return Colors.green;
    } else if('cancelled' == value) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

   static String getPaymentMethodIcon(String value) {
    if ('Pay Here' == value) {
      return TImages.payHereIcon;
    } else if ('PayPal' == value) {
      return TImages.paypal_icon;
    } else if ('shipped' == value) {
      return TImages.payHereIcon;
    } else if ('delivered' == value) {
      return TImages.payHereIcon;
    } else if('cancelled' == value) {
      return TImages.payHereIcon;
    } else {
      return TImages.payHereIcon;
    }
  }

static Color getRoleColor(String value) {
  switch (value) {
    case 'Super Admin':
      return Colors.amber; // Trustworthy and strong
    case 'Store Admin':
      return Colors.deepOrange; // Vibrant and distinct
    case 'Product Manager':
      return Colors.purple; // Creative and strategic
    case 'Order Manager':
      return Colors.teal; // Calm and efficient
    case 'Marketing Manager':
      return Colors.pinkAccent; // Bold and eye-catching
    default:
      return Colors.grey; // Fallback
  }
}


  static Color? getColor(String value) {


    if(value == 'Green') {
      return Colors.green;
    } else if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    }
    return null;
  }

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }


  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Ok')),
          ],
        );
      }
    );
  }
}