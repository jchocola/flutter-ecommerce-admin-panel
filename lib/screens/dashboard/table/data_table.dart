import 'package:admin_panel/screens/dashboard/table/table_source.dart';
import 'package:admin_panel/screens/dashboard/widgets/paginated_table.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class DashboardOrderTable extends StatelessWidget {
  const DashboardOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 700,
      tableHeight: 500,
      dataRowHeight: TSizes.xl * 1.2,
      columns: const [
        DataColumn2(label: Text('Order ID')),
        DataColumn2(label: Text('Amount')),
        DataColumn2(label: Text('Status')),
        DataColumn2(label: Text('Date')),
      ],
      source: OrderRows(),
    );
  }
}