import 'package:admin_panel/screens/brands/brands/data/brand_rows.dart';
import 'package:admin_panel/screens/brands/create_brands/controller/brand_controller.dart';
import 'package:admin_panel/screens/dashboard/widgets/paginated_table.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/models/brand_model.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class BrandTable extends StatelessWidget {
  BrandTable({super.key});

  final BrandController controller = Get.put(BrandController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: Lottie.asset(
            TImages.loading_animation,
            width: 500,
            height: 500,
          ),
        );
      }

      final brands = controller.filterBrands
          .map((e) => BrandModel.fromJson(e))
          .toList();

      if (brands.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(TImages.no_data_animation, width: 300, height: 300),
              Text(
                'No Brands Found...',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        );
      }

      return TPaginatedDataTable(
        minWidth: 700,
        tableHeight: 760,
        dataRowHeight: 64,
        columns: [
          DataColumn2(
            label: const Text('Brand'),
            fixedWidth: TDeviceUtils.isMobileScreen(context) ? null : 300,
          ),
          const DataColumn2(label: Text('Category')),
          DataColumn2(
            label: const Text('Featured'),
            fixedWidth: TDeviceUtils.isMobileScreen(context) ? null : 250,
          ),
          DataColumn2(
            label: const Text('Date'),
            fixedWidth: TDeviceUtils.isMobileScreen(context) ? null : 200,
          ),
          DataColumn2(
            label: const Text('Action'),
            fixedWidth: TDeviceUtils.isMobileScreen(context) ? null : 100,
          ),
        ],
        source: BrandRows(
          brands: brands,
          onDelete: (id) async {
            await controller.loadBrands();
          },
          onEdit: (brand) {
            Get.toNamed('/edit-brand', arguments: brand);
          },
        ),
      );
    });
  }
}
