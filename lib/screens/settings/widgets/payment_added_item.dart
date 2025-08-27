import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_image.dart';
import 'package:admin_panel/screens/product_settings/widgets/toggle_button.dart';
import 'package:admin_panel/screens/settings/widgets/controller/payment_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';
import 'package:iconsax/iconsax.dart';

class TPaymentAddedItem extends StatefulWidget {
  const TPaymentAddedItem({
    super.key,
    required this.paymentMethod,
    required this.apiKey,
    required this.merchantID,
  });

  final String paymentMethod, apiKey, merchantID;

  @override
  State<TPaymentAddedItem> createState() => _TPaymentAddedItemState();
}

class _TPaymentAddedItemState extends State<TPaymentAddedItem> {
  final controller = Get.put(PaymentController());
  bool isSandBox = false; // 🔑 local toggle state
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSandBoxMode();
  }

  Future<void> fetchSandBoxMode() async {
    final mode = await controller.getSandBoxMode(widget.paymentMethod);
    setState(() {
      isSandBox = mode;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: dark ? Colors.white.withOpacity(0.05) : Colors.white,
            border: Border.all(
              color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(THelperFunctions.getPaymentMethodIcon(widget.paymentMethod),
                width: 200,),
                const SizedBox(width: TSizes.spaceBetwwenItems),
                Text(widget.paymentMethod, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(width: TSizes.spaceBetwwenItems),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SensitiveTextViewer(label: 'API KEY', value: widget.apiKey),
                    const SizedBox(height: TSizes.sm),
                    SensitiveTextViewer(label: 'Merchant ID', value: widget.merchantID),
                  ],
                ),
                const SizedBox(width: TSizes.spaceBetwwenItems),
      
                /// 🔄 Toggle (independent state)
                Column(
                  children: [
                    const Text('Sand Box'),
                    const SizedBox(height: TSizes.spaceBetwwenItems),
                    isLoading
                        ? const CircularProgressIndicator(strokeWidth: 2)
                        : Switch(
                            value: isSandBox,
                            onChanged: (val) {
                              setState(() => isSandBox = val);
                              controller.updateSandBoxMode(val, widget.paymentMethod);
                            },
                          ),
                  ],
                ),
      
                IconButton(
                  icon: const Icon(Iconsax.trash),
                  color: Colors.red,
                  onPressed: () => controller.deletePaymentMethod(widget.paymentMethod),
                ),
                const SizedBox(width: TSizes.spaceBetwwenItems),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class SensitiveTextViewer extends StatefulWidget {
  final String label;
  final String value;

  const SensitiveTextViewer({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  State<SensitiveTextViewer> createState() => _SensitiveTextViewerState();
}

class _SensitiveTextViewerState extends State<SensitiveTextViewer> {
  bool isVisible = false;

  String get displayValue {
    if (isVisible) return widget.value;
    if (widget.value.length <= 6) return '••••••';
    return '${widget.value.substring(0, 4)}••••${widget.value.substring(widget.value.length - 2)}';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.label),
          const SizedBox(width: TSizes.spaceBetwwenSections),
          Expanded(
            child: Text(
              displayValue,
              style: Theme.of(context).textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: Icon(
              isVisible ? Icons.visibility_off : Icons.visibility,
              size: 20,
            ),
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
          ),
        ],
      ),
    );
  }
}
