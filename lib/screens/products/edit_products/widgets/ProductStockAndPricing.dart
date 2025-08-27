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
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ProductStockAndPricingEdit extends StatefulWidget {
  const ProductStockAndPricingEdit({
    super.key,
    this.stock,
    this.price,
    this.discountPrice,
  });

  final int? stock;
  final double? price, discountPrice;

  @override
  State<ProductStockAndPricingEdit> createState() =>
      _ProductStockAndPricingEditState();
}

class _ProductStockAndPricingEditState
    extends State<ProductStockAndPricingEdit> {
  late TextEditingController _stock;
  late TextEditingController _price;
  late TextEditingController _discountPrice;

  final processingFeeController = Get.put(ProcessingFeeCalcController());
  var processingFeeValue = ''.obs;
  final controller = CreateProductController.instance;
  final payCont = Get.put(PaymentController());
  var feePro = 0.0.obs;
  @override
  void initState() {
    super.initState();
     _loadFee(); 
    _stock = TextEditingController(text: widget.stock.toString());
    _price = TextEditingController(text: widget.price.toString());
    _discountPrice = TextEditingController(
      text: widget.discountPrice.toString(),
    );
    controller.price.text = widget.price?.toString() ?? '';
    controller.salesPrice.text = widget.discountPrice?.toString() ?? '';

    controller.priceText.value = controller.price.text;
    controller.salesPriceText.value = controller.salesPrice.text;

    processingFeeController.getProcessingFeeStructure().then((value) {
      setState(() {
        processingFeeValue.value = value.toString();
      });
    });
  }
Future<void> _loadFee() async {
  final fee = await payCont.getProcessingFee('PayHere');
  feePro.value = fee;
}
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Obx(
      () =>
          controller.productType.value == ProductType.single
              ? Form(
                key: controller.stockPriceFormKeyEdit,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FractionallySizedBox(
                      widthFactor: 0.45,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Stock',
                          hintText: 'Add Stock, only numbers are allowed',
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
                            (value) =>
                                TValidator.validateEmptyText('Stock', value),
                        keyboardType: TextInputType.number,
                        controller: controller.stock,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBetweenInputFields),

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
                                  'Price',
                                  value,
                                ),
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}$'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: TSizes.spaceBetwwenItems),

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
                            keyboardType: const TextInputType.numberWithOptions(
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

                    Obx(() {
                      double? salesPrice = double.tryParse(
                        controller.salesPriceText.value,
                      );
                      double? price = double.tryParse(
                        controller.priceText.value,
                      );

                      double productPrice =
                          (salesPrice != null && salesPrice >= 1)
                              ? salesPrice
                              : (price ?? 0.0);

                      double chargeToReceive =
                          PaymentCalculator.calculateAmountToCharge(
                            productPrice, double.tryParse(feePro.toString())!
                          );
                      double netAfterFee =
                          PaymentCalculator.calculateNetAmountAfterFee(
                            productPrice, double.tryParse(feePro.toString())!
                          ); 
                      double feeAmount = PaymentCalculator.calculateFee(
                        productPrice, double.tryParse(feePro.toString())!
                      );

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (salesPrice != null && salesPrice >= 1)
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
                ),
              )
              : const SizedBox(),
    );
  }
}
