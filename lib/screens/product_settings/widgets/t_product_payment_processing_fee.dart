import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/settings/widgets/controller/payment_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/constants/validator.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';

class TProductPaymentProcessingFee extends StatefulWidget {
  const TProductPaymentProcessingFee({super.key, this.onSelected});
  final void Function(String)? onSelected;

  @override
  State<TProductPaymentProcessingFee> createState() =>
      _TProductPaymentProcessingFeeState();
}

class _TProductPaymentProcessingFeeState
    extends State<TProductPaymentProcessingFee> {
  final controller = Get.put(PaymentController());
  bool isSandBox = false; // 🔘 local toggle state
  bool isLoading = true; // 🕒 loading state
  RxString paymentMethod = ''.obs;
  double processingFee = 0.0; // ✅ fee storage

  @override
  void initState() {
    super.initState();
    _initPaymentDetails('PayHere'); // ✅ run async logic here
  }

  Future<void> _initPaymentDetails(String paymentMethods) async {
    paymentMethod.value = paymentMethods; // 🟩 or get from widget/args
    isLoading = true;

    final fee = await controller.getProcessingFee(paymentMethod.value);

    controller.processingFeeController.text = fee.toString();
    setState(() {
      processingFee = fee;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      child: Container(
        decoration: BoxDecoration(
          color: dark ? Colors.white.withOpacity(0.05) : Colors.white,
          border: Border.all(
            color:
                dark
                    ? Colors.grey.withOpacity(0.5)
                    : TColors.dark.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment Processing Fee',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: TSizes.spaceBetwwenItems),
              Row(
                children: [
                  Container(
                    width: TSizes.buttonWidth * 1.5,
                    child: TextFormField(
                      controller: controller.processingFeeController,
                      decoration: InputDecoration(
                        labelText: 'Fee in %',
                        hintText: 'Processing Fee',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                            color:
                                dark
                                    ? Colors.grey.withOpacity(0.5)
                                    : TColors.dark.withOpacity(0.2),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                            color:
                                dark
                                    ? Colors.white.withOpacity(1)
                                    : TColors.dark.withOpacity(1),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      validator:
                          (value) => TValidator.validateEmptyText(
                            'Shipping Cost',
                            value,
                          ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
                  Obx(() {
                    if (controller.hasProcessingFeeChanged.value) {
                      return GestureDetector(
                        onTap: () {
                          final feeString =
                              controller.processingFeeController.text
                                  .toString();
                          if (feeString.isNotEmpty &&
                              double.tryParse(feeString) != null) {
                            controller.updateProcessingFee(
                              double.parse(feeString),
                              controller.paymentMethod.value,
                            );
                          } else {
                            Get.snackbar(
                              'Invalid Fee',
                              'Please enter a valid processing fee.',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: TColors.primary,
                            border: Border.all(
                              color:
                                  dark
                                      ? Colors.grey.withOpacity(0.5)
                                      : TColors.dark.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text('Save'),
                          ),
                        ),
                      );
                    }
                    return SizedBox.shrink();
                  }),
                ],
              ),
              const SizedBox(height: TSizes.spaceBetweenInputFields),
              Obx(
                () => DropdownButtonFormField<String>(
                  value: controller.paymentMethod.value,
                  decoration: InputDecoration(
                    labelText: 'Payment Method',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color:
                            dark
                                ? Colors.grey.withOpacity(0.5)
                                : TColors.dark.withOpacity(0.2),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color:
                            dark
                                ? Colors.white.withOpacity(1)
                                : TColors.dark.withOpacity(1),
                      ),
                    ),
                  ),
                  items:
                      controller.paymentMethods.map((method) {
                        return DropdownMenuItem(
                          value: method,
                          child: Row(
                            children: [
                              TRoundedImage(
                                imageUrl: THelperFunctions.getPaymentMethodIcon(
                                  method,
                                ),
                                width: 100,
                                fit: BoxFit.cover,
                                backgroundColor: Colors.transparent,
                                isNetworkImage: false,
                                height: 50,
                              ),
                              Text(method),
                            ],
                          ),
                        );
                      }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.paymentMethod.value = value;
                      _initPaymentDetails(value);
                      if (widget.onSelected != null) widget.onSelected!(value);
                    }
                  },
                ),
              ),
              const SizedBox(height: TSizes.spaceBetwwenItems),
            ],
          ),
        ),
      ),
    );
  }
}
