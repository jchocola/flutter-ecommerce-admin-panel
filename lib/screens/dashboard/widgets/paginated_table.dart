import 'package:admin_panel/screens/layouts/headers/header.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class TPaginatedDataTable extends StatelessWidget {
  const TPaginatedDataTable({
    super.key,
    this.sortAscending = true,
    this.sortColumnIndex,
    this.rowsPerPage = 10,
    required this.source,
    required this.columns,
    this.onPageChanged,
    this.dataRowHeight = TSizes.xl * 2,
    this.tableHeight = 760,
    this.minWidth = 1000,
  });

  final bool sortAscending;

  final int? sortColumnIndex;

  final int rowsPerPage;

  final DataTableSource source;

  final List<DataColumn> columns;

  final Function(int)? onPageChanged;

  final double dataRowHeight;

  final double tableHeight;

  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return SizedBox(
      height: tableHeight,
    
      child: Theme(
        data: Theme.of(context).copyWith(cardTheme:  CardThemeData(color: dark ? TColors.dark.withOpacity(0.5) : Colors.white, elevation: 0,)),
        child: PaginatedDataTable2(
          source: source,
          columns: columns,
          columnSpacing: 12,
          dividerThickness: 0,
          horizontalMargin: 12,
          rowsPerPage: rowsPerPage,
          dataRowHeight: dataRowHeight,
          minWidth: minWidth,

          showCheckboxColumn: true,

          showFirstLastButtons: true,
          onPageChanged: onPageChanged,
          renderEmptyRowsInTheEnd: false,
          onRowsPerPageChanged: (noOfRows) {},
        ),
      ),
    );
  }
}
