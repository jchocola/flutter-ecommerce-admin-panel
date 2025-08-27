import 'package:admin_panel/common/widgets/images/image_uploader.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/media/controller/media_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/create_product_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/image_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/processing_fee_calc_controller.dart';
import 'package:admin_panel/screens/products/create_products/controller/variation_controller.dart';
import 'package:admin_panel/screens/settings/widgets/controller/payment_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/formatters/enum.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/helpers/payment_calc.dart';
import 'package:admin_panel/util/models/product_model/variation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

class ProductVariantionsEdit extends StatefulWidget {
  const ProductVariantionsEdit({super.key, this.productVariationModel});

  final List<ProductVariantionsModel>? productVariationModel;

  @override
  State<ProductVariantionsEdit> createState() => _ProductVariantionsEditState();
}

class _ProductVariantionsEditState extends State<ProductVariantionsEdit> {
  final variationController = ProductVariantionsController.instance;
  var processingFeeValue = ''.obs;
  final processingCalcController = Get.put(ProcessingFeeCalcController());
  final payCont = Get.put(PaymentController());
  var feePro = 0.0.obs;
  @override
  void initState() {
    super.initState();
     _loadFee();

    if (widget.productVariationModel != null &&
        widget.productVariationModel!.isNotEmpty &&
        variationController.productVariantions.isEmpty) {
      variationController.productVariantions.assignAll(
        widget.productVariationModel!,
      );
      variationController.initControllersForExistingVariations(
        widget.productVariationModel!,
      );

      // Populate variationPriceMap
      for (var variation in widget.productVariationModel!) {
        double priceToConsider =
            variation.salePrice != null && variation.salePrice! > 0
                ? variation.salePrice!
                : (variation.price ?? 0.0);

        variationController.variationPriceMap[variation] = priceToConsider;
      }
    }

    processingCalcController.getProcessingFeeStructure().then((value) {
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
          CreateProductController.instance.productType.value ==
                  ProductType.variable
              ? TRoundedContainer(
                backgroundColor:
                    dark ? Colors.white.withOpacity(0.05) : Colors.white,
                showBorder: true,
                radius: 5,
                borderColor:
                    dark
                        ? Colors.grey.withOpacity(0.05)
                        : TColors.dark.withOpacity(0.2),
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Product Variations',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          TextButton(
                            onPressed:
                                () => variationController.removeVariations(
                                  context,
                                ),
                            child: const Text('Remove Varations'),
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBetwwenItems),

                      if (variationController.productVariantions.isNotEmpty)
                        ListView.separated(
                          itemCount:
                              variationController.productVariantions.length,
                          shrinkWrap: true,
                          separatorBuilder:
                              (_, __) => const SizedBox(
                                height: TSizes.spaceBetwwenItems,
                              ),
                          itemBuilder: (_, index) {
                            final variation =
                                variationController.productVariantions[index];
                            return _builVariationTitle(
                              context,
                              index,
                              variation,
                              variationController,
                            );
                          },
                        )
                      else
                        _buildNoVariationMessage(),
                    ],
                  ),
                ),
              )
              : const SizedBox.shrink(),
    );
  }

  Widget _builVariationTitle(
    BuildContext context,
    int index,
    ProductVariantionsModel variation,
    ProductVariantionsController variationController,
  ) {
    return Obx(() {
      final isDefault =
          variationController.defaultVariationId!.value == variation.id;

      return ExpansionTile(
        backgroundColor: TColors.dark.withOpacity(1),
        collapsedBackgroundColor: TColors.dark.withOpacity(1),
        childrenPadding: const EdgeInsets.all(TSizes.md),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                variation.attributesValues.entries
                    .map((entry) => '${entry.key}: ${entry.value}')
                    .join(', '),
              ),
            ),
            Icon(
              isDefault ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isDefault ? Colors.green : Colors.grey,
            ),
          ],
        ),
        children: [
          // Image Uploader
          TImageUploader(
            right: 0,
            left: null,
            isNetworkImage: variation.image.value.isNotEmpty,
            image:
                variation.image.value.isEmpty
                    ? TImages.placeholder
                    : variation.image.value,
            onIconButtonPressed:
                () => ProductImagesController.instance.selectVariationImage(
                  variation,
                ),
          ),
          const SizedBox(height: TSizes.spaceBetweenInputFields),

          // Fields
          Wrap(
            spacing: TSizes.spaceBetweenInputFields,
            runSpacing: TSizes.spaceBetweenInputFields,
            children: [
              SizedBox(
                width: 120,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged:
                      (value) => variation.stock = int.tryParse(value) ?? 0,
                  controller:
                      variationController
                          .stockControllersList[index][variation],
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Stock',
                    hintText: 'Only numbers',
                  ),
                ),
              ),
              SizedBox(
                width: 120,
                child: TextFormField(
                  onChanged: (value) {
                    variation.price = double.tryParse(value) ?? 0;
                    variationController.variationPriceMap[variation] =
                        (variation.salePrice != null &&
                                variation.salePrice! > 0)
                            ? variation.salePrice!
                            : variation.price ?? 0.0;
                  },

                  controller:
                      variationController
                          .priceControllersList[index][variation],
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}$'),
                    ),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    hintText: 'Up to 2 decimals',
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                child: TextFormField(
                  onChanged: (value) {
                    variation.salePrice = double.tryParse(value) ?? 0;
                    variationController.variationPriceMap[variation] =
                        (variation.salePrice != null &&
                                variation.salePrice! > 0)
                            ? variation.salePrice!
                            : variation.price ?? 0.0;
                  },

                  controller:
                      variationController
                          .salesControllersList[index][variation],
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}$'),
                    ),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Discounted Price',
                    hintText: 'Up to 2 decimals',
                  ),
                ),
              ),
              SizedBox(
                width: 250,
                child: TextFormField(
                  onChanged: (value) => variation.description = value,
                  controller:
                      variationController
                          .descriptionControllersList[index][variation],
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Add description',
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: TSizes.spaceBetwwenItems),

          // Default variation radio
          ListTile(
            leading: Radio<String>(
              value: variation.id,
              groupValue: variationController.defaultVariationId!.value,
              onChanged: (value) {
                variationController.setDefaultVariation(value!);
              },
            ),
            title: const Text('Set as Default Variation'),
            onTap: () {
              variationController.setDefaultVariation(variation.id);
            },
          ),

          const SizedBox(height: TSizes.spaceBetwwenSections),
          Obx(() {
            double productPrice =
                variationController.variationPriceMap[variation] ?? 0.0;

            double chargeToReceive = PaymentCalculator.calculateAmountToCharge(
              productPrice, double.tryParse(feePro.toString())!
            );
            double netAfterFee = PaymentCalculator.calculateNetAmountAfterFee(
              productPrice, double.tryParse(feePro.toString())!
            );
            double feeAmount = PaymentCalculator.calculateFee(productPrice, double.tryParse(feePro.toString())!);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (variation.salePrice != null && variation.salePrice! > 0)
  Text('For Discount Price'),


                if (processingFeeValue.toString() == 'include')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'If you want to RECEIVE ${productPrice.toStringAsFixed(2)} LKR:',
                      ),
                      Text('Charge: ${chargeToReceive.toStringAsFixed(2)} LKR'),
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
                      Text('Fee amount: ${feeAmount.toStringAsFixed(2)} LKR'),
                    ],
                  ),
              ],
            );
          }),
        ],
      );
    });
  }
}

Widget _buildNoVariationMessage() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(TImages.no_data_animation, width: 300, height: 300),
        ],
      ),
      const SizedBox(height: TSizes.spaceBetwwenItems),
      const Text('There are no Variations added for this product'),
    ],
  );
}
