import 'package:admin_panel/common/widgets/dialogs/dialogs.dart';
import 'package:admin_panel/screens/banners/create_banners/controller/banner_controller.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/models/banner_model.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BannerRows extends DataTableSource {
  final List<BannerModel> banners;
final void Function()? onRefresh;

  BannerRows(this.banners, this.onRefresh);

  @override
  DataRow? getRow(int index) {
    if (index >= banners.length) return null;
    final banner = banners[index];

    final screenText = (banner.value == 'products') ? '/Products' : banner.redirectScreen;

    return DataRow2(
      cells: [
        DataCell(
          FadeInImage(
            width: 180,
            height: 100,
            placeholderColor: Colors.grey,
            
  placeholder: AssetImage('assets/icons/placeholder.png'),
  image: NetworkImage(banner.imageUrl ?? ''), // your Supabase public URL
  fadeInDuration: Duration(milliseconds: 500),
  fit: BoxFit.cover,
),


        ),
        DataCell( Text(screenText ?? 'Unknown')), // Customize as needed
        DataCell(
          GestureDetector(
            onTap: () =>
               banner.isActive == true
                            ? TDialogs.defaultDialog(
                              context: Get.context!,
                              title: 'Banner Status',
                              confirmText: 'Inactive',
                              onConfirm:
                                  () async =>
                                      await uploadBannerStatusInactive(banner.id!),
                              content: 'Do you want to inactive this banner ?',
                            )
                            : TDialogs.defaultDialog(
                              context: Get.context!,
                              title: 'Banner Status',
                              confirmText: 'Active',
                              onConfirm:
                                  () async => await uploadBannerStatusActive(banner.id!),
                              content: 'Do you want to active this banner ?',
                            ),
            child: Icon(
              banner.isActive == true ? Icons.visibility : Icons.visibility_off,
              color: banner.isActive == true ? Colors.green : Colors.grey,
            ),
          ),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
               onPressed: () => Get.toNamed(TRoutes.editbanners, arguments: banner)

                     
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // Delete banner logic
                  TDialogs.defaultDialog(
                  context: Get.context!,
                  title: 'Delete Tab',
                  confirmText: 'Delete',
                  onConfirm: ()  {
                   final controller  = Get.put(BannerController());

                   controller.deleteBanner(banner.id!);
                   
                    // Optionally close the dialog if not closed inside deleteTab
                    // Get.back();
                  },
                  content:
                      'Do you want to delete this banner?',
                  // Add transitionBuilder if supported to fix hero tag issue
                );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => banners.length;

  @override
  int get selectedRowCount => 0;

  uploadBannerStatusInactive(String id) async {
    final supabase = Supabase.instance.client;

    try {
      await Supabase.instance.client
          .from('banners')
          .update({'is_active': false})
          .eq('id', id);
          Get.back();
              onRefresh!(); // trigger data reload

    } catch (e) {
      print('inactive error' +e.toString());
    }
  }

  uploadBannerStatusActive(String id) async {
   final supabase = Supabase.instance.client;

    try {
      await Supabase.instance.client
          .from('banners')
          .update({'is_active': true})
          .eq('id', id);
          Get.back();
              onRefresh!(); // trigger data reload

    } catch (e) {
      print('inactive error' +e.toString());
    }
  }
}
