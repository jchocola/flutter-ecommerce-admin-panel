import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/controllers/dashboard/dashboard_controller.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/formatters/enum.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';


class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Information', style: Theme.of(context).textTheme.headlineMedium,),
          const SizedBox(height: TSizes.spaceBetwwenSections,),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Date'),
                    Text(order.orderDate.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Items'),
                    Text('2 Items', style: Theme.of(context).textTheme.bodyLarge,),
                  ],
                ),
              ),
              Expanded(
                flex: TDeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Status'),
                    TRoundedContainer(
                      radius: TSizes.cardRadiusSm,
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: 0),
                      backgroundColor: THelperFunctions.getOrderStatusColor(OrderStatus.placed).withOpacity(0.1),
                      child: DropdownButton<OrderStatus>(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        value: OrderStatus.placed,
                        onChanged: (OrderStatus? newValue) {},
                        items: OrderStatus.values.map((OrderStatus status) {
                          return DropdownMenuItem<OrderStatus>(
                            value: status,
                            child: Text(
                              status.name.capitalize.toString(),
                              style: TextStyle(color: THelperFunctions.getOrderStatusColor(OrderStatus.placed),),
                          )
                          );
                        }
                        ).toList()
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text('total'),
                    Text('Total Amount', style: Theme.of(context).textTheme.bodyLarge,)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}