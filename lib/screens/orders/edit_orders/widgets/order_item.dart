import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/controllers/dashboard/dashboard_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({super.key, required this.order, this.orderList});

  final OrderModel order;
  final List<OrderModel>? orderList;
  @override
  Widget build(BuildContext context) {
  
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Items', style: Theme.of(context).textTheme.headlineMedium,),
          const SizedBox(height: TSizes.spaceBetwwenSections,),

          //Items
          ListView.separated(
            shrinkWrap: true,
            itemCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBetwwenItems,),
            itemBuilder: (_, index) {
             
              return Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        TRoundedImage(
                          backgroundColor: TColors.primaryBackground,
                          imageUrl: TImages.appDarkLogo,
                        ),
                        const SizedBox(width: TSizes.spaceBetwwenItems,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Title',
                                style: Theme.of(context).textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}