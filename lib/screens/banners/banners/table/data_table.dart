import 'package:admin_panel/screens/banners/create_banners/controller/banner_controller.dart';
import 'package:admin_panel/screens/banners/banners/data/banner_rows.dart';
import 'package:admin_panel/screens/dashboard/widgets/paginated_table.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class BannerTable extends StatelessWidget {
  final BannerController controller = Get.put(BannerController());

  BannerTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: Lottie.asset(
            TImages.loading_animation,
            width: 150,
            height: 150,
          ),
        );
      }

      final banners = controller.banners;

      if (banners.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(TImages.no_data_animation, width: 300, height: 300),
              Text(
                'No banners found.',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        );
      }

      return TPaginatedDataTable(
        minWidth: 700,
        tableHeight: 760,
        dataRowHeight: 120,
        columns: const [
          DataColumn2(label: Text('Tabs')),
          DataColumn2(label: Text('Redirect Screen')),
          DataColumn2(label: Text('Active')),
          DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: BannerRows(banners, controller.fetchBanners),
      );
    });
  }
}
