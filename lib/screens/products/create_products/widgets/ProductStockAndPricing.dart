import 'package:admin_panel/common/widgets/sidebars/sidebar.dart';
import 'package:admin_panel/screens/products/create_products/controller/create_product_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/processing_fee_calc_controller.dart';
import 'package:admin_panel/screens/settings/widgets/controller/payment_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/constants/validator.dart';
import 'package:admin_panel/util/formatters/enum.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/helpers/payment_calc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/utils.dart';

class ProductStockAndPricing extends StatefulWidget {
  const ProductStockAndPricing({super.key});

  @override
  State<ProductStockAndPricing> createState() => _ProductStockAndPricingState();
}

class _ProductStockAndPricingState extends State<ProductStockAndPricing> {
  final processingFeeController = Get.put(ProcessingFeeCalcController());
  var processingFeeValue = ''.obs;
  final payCont = Get.put(PaymentController());
  var feeProc = 0.0.obs;

  @override
  void initState() {
    super.initState();
        _loadFee();

    processingFeeController.getProcessingFeeStructure().then((value) {
      setState(() {
        processingFeeValue.value = value.toString();
      });
    });
  }
Future<void> _loadFee() async {
  final fee = await payCont.getProcessingFee('PayHere');
  feeProc.value = fee;
}
  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;
    final dark = THelperFunctions.isDarkMode(context);

    return Obx(
      () =>
          controller.productType.value == ProductType.single
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Form(
                          key: controller.stockPriceFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FractionallySizedBox(
                                widthFactor: 0.45,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Stock',
                                    hintText:
                                        'Add Stock, only numbers are allowed',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      borderSide: BorderSide(
                                        color:
                                            dark
                                                ? Colors.grey.withOpacity(0.5)
                                                : TColors.dark.withOpacity(0.2),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      borderSide: BorderSide(
                                        color:
                                            dark
                                                ? Colors.white.withOpacity(1)
                                                : TColors.dark.withOpacity(1),
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                  validator:
                                      (value) => TValidator.validateEmptyText(
                                        'Stock',
                                        value,
                                      ),
                                  keyboardType: TextInputType.number,
                                  controller: controller.stock,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: TSizes.spaceBetweenInputFields,
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: controller.price,
                                      onChanged: (value) {
                                        controller.priceText.value = value;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Price',
                                        hintText: 'Price with up-to-2 decimals',
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                          borderSide: BorderSide(
                                            color:
                                                dark
                                                    ? Colors.grey.withOpacity(
                                                      0.5,
                                                    )
                                                    : TColors.dark.withOpacity(
                                                      0.2,
                                                    ),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                          borderSide: BorderSide(
                                            color:
                                                dark
                                                    ? Colors.white.withOpacity(
                                                      1,
                                                    )
                                                    : TColors.dark.withOpacity(
                                                      1,
                                                    ),
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      validator:
                                          (value) =>
                                              TValidator.validateEmptyText(
                                                'Price',
                                                value,
                                              ),
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,2}$'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: TSizes.spaceBetwwenItems,
                                  ),

                                  Expanded(
                                    child: TextFormField(
                                      controller: controller.salesPrice,
                                      onChanged: (value) {
                                        controller.salesPriceText.value = value;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Discounted Price',
                                        hintText: 'Price with up-2 decimals',
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                          borderSide: BorderSide(
                                            color:
                                                dark
                                                    ? Colors.grey.withOpacity(
                                                      0.5,
                                                    )
                                                    : TColors.dark.withOpacity(
                                                      0.2,
                                                    ),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                          borderSide: BorderSide(
                                            color:
                                                dark
                                                    ? Colors.white.withOpacity(
                                                      1,
                                                    )
                                                    : TColors.dark.withOpacity(
                                                      1,
                                                    ),
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,2}$'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBetwwenItems),
                  Obx(() {
                    double productPrice =
                        controller.salesPriceText.value.isNotEmpty
                            ? double.tryParse(
                                  controller.salesPriceText.value,
                                ) ??
                                0.0
                            : double.tryParse(controller.priceText.value) ??
                                0.0;

                    double chargeToReceive =
                        PaymentCalculator.calculateAmountToCharge(productPrice, double.tryParse(feeProc.toString())!);
                    double netAfterFee =
                        PaymentCalculator.calculateNetAmountAfterFee(
                          productPrice, double.tryParse(feeProc.toString())!
                        );
                    double feeAmount = PaymentCalculator.calculateFee(
                      productPrice, double.tryParse(feeProc.toString())!
                    );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(controller.salesPriceText.value.isNotEmpty)
                        Text('For Discount Price'),

                        if (processingFeeValue.toString() == 'include')
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'If you want to RECEIVE ${productPrice.toStringAsFixed(2)} LKR:',
                              ),
                              Text(
                                'Charge: ${chargeToReceive.toStringAsFixed(2)} LKR',
                              ),
                            ],
                          ),
                        const SizedBox(height: 8),
                        if (processingFeeValue.toString() != 'include')
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'If you CHARGE ${productPrice.toStringAsFixed(2)} LKR:',
                              ),
                              Text(
                                'Net after fee: ${netAfterFee.toStringAsFixed(2)} LKR',
                              ),
                              Text(
                                'Fee amount: ${feeAmount.toStringAsFixed(2)} LKR',
                              ),
                            ],
                          ),
                      ],
                    );
                  }),
                ],
              )
              : const SizedBox(),
    );
  }
}
