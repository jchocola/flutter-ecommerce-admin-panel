import 'package:admin_panel/screens/brands/brands/data/brand_rows.dart';
import 'package:admin_panel/screens/customers/all_customers/controller/customer_controller.dart';
import 'package:admin_panel/screens/customers/all_customers/data/customers_rows.dart';
import 'package:admin_panel/screens/dashboard/widgets/paginated_table.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:lottie/lottie.dart';

class CustomersTable extends StatefulWidget {
  const CustomersTable({super.key, this.products});
  final List<Map<String, dynamic>>? products;

  @override
  State<CustomersTable> createState() => _CustomersTableState();
}

class _CustomersTableState extends State<CustomersTable> {
  late final CustomerController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(CustomerController());
  }

  @override
  Widget build(BuildContext context) {
    /// ❌ Don't use controller.customers inside Obx directly
    /// Instead, render widget.products that was passed from parent
    final products = widget.products ?? [];

    if(controller.isLoading.value == true){
       return  Center(child: Column(
        children: [
          Lottie.asset(TImages.loading_animation, width: 300, height: 300),
          const SizedBox(height: TSizes.spaceBetwwenItems,),
        ],
      ));
    }

    if (products.isEmpty) {
      return  Center(child: Column(
        children: [
          Lottie.asset(TImages.no_data_animation, width: 300, height: 300),
          const SizedBox(height: TSizes.spaceBetwwenItems,),
          Text('No Customers Found...', style: Theme.of(context).textTheme.headlineSmall,)
        ],
      ));
    }

    final dataSource = CustomersRows(products);

    return TPaginatedDataTable(
      minWidth: 700,
      tableHeight: 760,
      dataRowHeight: 64,
      columns: const [
        DataColumn2(label: Text('Customers')),
        DataColumn2(label: Text('Email')),
        DataColumn2(label: Text('Phone Number')),
        DataColumn2(label: Text('Registered')),
        DataColumn2(label: Text('Action')),
      ],
      source: dataSource,
      rowsPerPage: 10,
    );
  }
}

