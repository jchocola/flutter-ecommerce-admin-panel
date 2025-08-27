import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/models/address_model.dart';
import 'package:flutter/material.dart';

class ShippingAddressWdiget extends StatelessWidget {
  const ShippingAddressWdiget({
    super.key,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.title,
    required this.model,
  });

  final String street, city, state, country, title;
  final AddressModel model;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
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
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: TSizes.spaceBetwwenSections),

            if (model != null) ...[
              Text(
                'Street : $street',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: TSizes.spaceBetwwenItems),
              Text(
                'City : $city',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: TSizes.spaceBetwwenItems),
              Text(
                'State : $state',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: TSizes.spaceBetwwenItems),
              Text(
                'Country : $country',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: TSizes.spaceBetwwenItems),
            ] else
              Text('No Shipping Address'),
            const SizedBox(height: TSizes.spaceBetwwenItems),
          ],
        ),
      ),
    );
  }
}
