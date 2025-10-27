import 'package:admin_panel/screens/dashboard/widgets/paginated_table.dart';
import 'package:admin_panel/common/widgets/buttons/tab_action_button.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/products/all_products/data/data_table.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:admin_panel/common/widgets/buttons/tab_action_button.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:admin_panel/screens/dashboard/widgets/paginated_table.dart';
import 'package:admin_panel/screens/products/all_products/data/data_table.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class ProductsTable extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const ProductsTable({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 1000,
      columns: const [
        DataColumn2(label: Text('Product'), fixedWidth: 400),
        DataColumn2(label: Text('Stock')),
        DataColumn2(label: Text('Brand')),
        DataColumn2(label: Text('Price')),
        DataColumn2(label: Text('Date')),
        DataColumn2(label: Text('Action'), fixedWidth: 100),
      ],
      source: ProductsRow(products, onRefresh: () {  }),
    );
  }
}
