import 'package:admin_panel/common/widgets/buttons/tab_action_button.dart';
import 'package:admin_panel/common/widgets/dialogs/dialogs.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/products/controller/product_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/create_product_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/formatters/formatters.dart';
import 'package:admin_panel/util/models/brand_model.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:admin_panel/common/widgets/buttons/tab_action_button.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductsRow extends DataTableSource {
  final List<Map<String, dynamic>> products;
  final VoidCallback onRefresh;

  ProductsRow(this.products, {required this.onRefresh});

  String _safeString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    if (value is Map) return value.toString();
    return value.toString();
  }

  String _getImageUrl(dynamic imageData) {
    try {
      if (imageData == null) return TImages.productImage3;
      if (imageData is String) return imageData;
      if (imageData is Map && imageData.containsKey('url')) {
        final url = imageData['url'];
        if (url is String) return url;
      }
    } catch (_) {}
    return TImages.productImage3;
  }

  String _formatDate(dynamic date) {
    if (date == null) return '';
    if (date is String) return date;
    try {
      return DateFormat('yyyy-MM-dd').format(DateTime.parse(date.toString()));
    } catch (_) {
      return date.toString();
    }
  }

  @override
  DataRow? getRow(int index) {
    if (index >= products.length) return null;
    final product = products[index];

    final thumbnail = _getImageUrl(product['thumbnail']);
    final title = _safeString(product['title']);
    final stock = _safeString(product['stock']);
    final brandName = _safeString(product['brand']?['title']);
    final price =
        product['price'] != null ? 'Rs. ${product['price']}' : 'Rs. 0';
    final formattedDate = _formatDate(product['created_at']);

    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              TRoundedImage(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(TSizes.xs),
                imageUrl: thumbnail,
                applyImageRadius: false,
                borderRadius: 0,
                isNetworkImage: true,
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(width: TSizes.spaceBetwwenItems),
              Flexible(
                child: Text(
                  title,
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge!.apply(color: TColors.primary),
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(stock)),
        DataCell(Text(brandName)),
        DataCell(Text(price)),
        DataCell(
          Text(
            TFormatters.formatDate(DateTime.tryParse(product['created_at'])!),
          ),
        ),
        DataCell(
          TTabActionButton(
            onEditPressed: () async {
              Get.delete<CreateProductController>();
              Get.find<ProductsController>().setProduct(product);

              final result = await Get.toNamed(
                TRoutes.editProducts,
                arguments: product,
              );

              if (result == true) {
                onRefresh(); // Call refresh on return
              }
            },
            onDeletePressed: () {
              // TODO: your delete logic here
              TDialogs.defaultDialog(
                context: Get.context!,
                title: 'Delete Product',
                content:
                    'Do you want to delete Product ${product['title'].toString().toUpperCase()}?',
                confirmText: 'Delete',
                cancelText: 'Cancel',
                onConfirm: () async {
                  final controller = Get.put(ProductsController());
                  await controller.deleteProduct(product['id']);
                  Get.back(); // Close the dialog after deletion
                  // Optionally refresh your product list or show a success message
                  Get.snackbar('Success', 'Product deleted successfully');
                  onRefresh();
                  controller.fetchProducts();
                },
                onCancel: () {
                  Get.back(); // Close dialog on cancel
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => products.length;

  @override
  int get selectedRowCount => 0;
}
