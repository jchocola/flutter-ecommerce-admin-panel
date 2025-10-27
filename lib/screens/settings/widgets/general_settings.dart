import 'package:admin_panel/common/widgets/images/image_uploader.dart';
import 'package:admin_panel/screens/products/create_products/controller/image_controller.dart';
import 'package:admin_panel/screens/settings/controllers/settings_controller.dart';
import 'package:admin_panel/screens/settings/widgets/controller/general_settings_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/image_strings.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/constants/validator.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class GeneralSettings extends StatefulWidget {
  GeneralSettings({
    super.key,
    this.onSelected,
    TextEditingController? currencyController,
    TextEditingController? themeController,
  }) : currencyController = currencyController ?? TextEditingController(),
       themeController = themeController ?? TextEditingController();

  final TextEditingController currencyController;
  final TextEditingController themeController;
  final void Function(String)? onSelected;

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  final List<String> themes = ['System', 'Light', 'Dark'];

  final List<String> currencies = [
    'AED - United Arab Emirates Dirham',
    'AFN - Afghan Afghani',
    'ALL - Albanian Lek',
    'AMD - Armenian Dram',
    'ANG - Netherlands Antillean Guilder',
    'AOA - Angolan Kwanza',
    'ARS - Argentine Peso',
    'AUD - Australian Dollar',
    'AWG - Aruban Florin',
    'AZN - Azerbaijani Manat',
    'BAM - Bosnia-Herzegovina Convertible Mark',
    'BBD - Barbadian Dollar',
    'BDT - Bangladeshi Taka',
    'BGN - Bulgarian Lev',
    'BHD - Bahraini Dinar',
    'BIF - Burundian Franc',
    'BMD - Bermudian Dollar',
    'BND - Brunei Dollar',
    'BOB - Bolivian Boliviano',
    'BRL - Brazilian Real',
    'BSD - Bahamian Dollar',
    'BTN - Bhutanese Ngultrum',
    'BWP - Botswanan Pula',
    'BYN - Belarusian Ruble',
    'BZD - Belize Dollar',
    'CAD - Canadian Dollar',
    'CDF - Congolese Franc',
    'CHF - Swiss Franc',
    'CLP - Chilean Peso',
    'CNY - Chinese Yuan',
    'COP - Colombian Peso',
    'CRC - Costa Rican Colón',
    'CUP - Cuban Peso',
    'CVE - Cape Verdean Escudo',
    'CZK - Czech Koruna',
    'DJF - Djiboutian Franc',
    'DKK - Danish Krone',
    'DOP - Dominican Peso',
    'DZD - Algerian Dinar',
    'EGP - Egyptian Pound',
    'ERN - Eritrean Nakfa',
    'ETB - Ethiopian Birr',
    'EUR - Euro',
    'FJD - Fijian Dollar',
    'FKP - Falkland Islands Pound',
    'FOK - Faroese Króna',
    'GBP - British Pound Sterling',
    'GEL - Georgian Lari',
    'GGP - Guernsey Pound',
    'GHS - Ghanaian Cedi',
    'GIP - Gibraltar Pound',
    'GMD - Gambian Dalasi',
    'GNF - Guinean Franc',
    'GTQ - Guatemalan Quetzal',
    'GYD - Guyanaese Dollar',
    'HKD - Hong Kong Dollar',
    'HNL - Honduran Lempira',
    'HRK - Croatian Kuna',
    'HTG - Haitian Gourde',
    'HUF - Hungarian Forint',
    'IDR - Indonesian Rupiah',
    'ILS - Israeli New Sheqel',
    'IMP - Isle of Man Pound',
    'INR - Indian Rupee',
    'IQD - Iraqi Dinar',
    'IRR - Iranian Rial',
    'ISK - Icelandic Króna',
    'JEP - Jersey Pound',
    'JMD - Jamaican Dollar',
    'JOD - Jordanian Dinar',
    'JPY - Japanese Yen',
    'KES - Kenyan Shilling',
    'KGS - Kyrgystani Som',
    'KHR - Cambodian Riel',
    'KID - Kiribati Dollar',
    'KMF - Comorian Franc',
    'KRW - South Korean Won',
    'KWD - Kuwaiti Dinar',
    'KYD - Cayman Islands Dollar',
    'KZT - Kazakhstani Tenge',
    'LAK - Laotian Kip',
    'LBP - Lebanese Pound',
    'LKR - Sri Lankan Rupee',
    'LRD - Liberian Dollar',
    'LSL - Lesotho Loti',
    'LYD - Libyan Dinar',
    'MAD - Moroccan Dirham',
    'MDL - Moldovan Leu',
    'MGA - Malagasy Ariary',
    'MKD - Macedonian Denar',
    'MMK - Myanmar Kyat',
    'MNT - Mongolian Tugrik',
    'MOP - Macanese Pataca',
    'MRU - Mauritanian Ouguiya',
    'MUR - Mauritian Rupee',
    'MVR - Maldivian Rufiyaa',
    'MWK - Malawian Kwacha',
    'MXN - Mexican Peso',
    'MYR - Malaysian Ringgit',
    'MZN - Mozambican Metical',
    'NAD - Namibian Dollar',
    'NGN - Nigerian Naira',
    'NIO - Nicaraguan Córdoba',
    'NOK - Norwegian Krone',
    'NPR - Nepalese Rupee',
    'NZD - New Zealand Dollar',
    'OMR - Omani Rial',
    'PAB - Panamanian Balboa',
    'PEN - Peruvian Sol',
    'PGK - Papua New Guinean Kina',
    'PHP - Philippine Peso',
    'PKR - Pakistani Rupee',
    'PLN - Polish Zloty',
    'PYG - Paraguayan Guarani',
    'QAR - Qatari Rial',
    'RON - Romanian Leu',
    'RSD - Serbian Dinar',
    'RUB - Russian Ruble',
    'RWF - Rwandan Franc',
    'SAR - Saudi Riyal',
    'SBD - Solomon Islands Dollar',
    'SCR - Seychellois Rupee',
    'SDG - Sudanese Pound',
    'SEK - Swedish Krona',
    'SGD - Singapore Dollar',
    'SHP - Saint Helena Pound',
    'SLE - Sierra Leonean Leone',
    'SOS - Somali Shilling',
    'SRD - Surinamese Dollar',
    'SSP - South Sudanese Pound',
    'STN - São Tomé and Príncipe Dobra',
    'SYP - Syrian Pound',
    'SZL - Swazi Lilangeni',
    'THB - Thai Baht',
    'TJS - Tajikistani Somoni',
    'TMT - Turkmenistani Manat',
    'TND - Tunisian Dinar',
    'TOP - Tongan Paʻanga',
    'TRY - Turkish Lira',
    'TTD - Trinidad and Tobago Dollar',
    'TVD - Tuvaluan Dollar',
    'TWD - New Taiwan Dollar',
    'TZS - Tanzanian Shilling',
    'UAH - Ukrainian Hryvnia',
    'UGX - Ugandan Shilling',
    'USD - United States Dollar',
    'UYU - Uruguayan Peso',
    'UZS - Uzbekistani Som',
    'VES - Venezuelan Bolívar Soberano',
    'VND - Vietnamese Dong',
    'VUV - Vanuatu Vatu',
    'WST - Samoan Tala',
    'XAF - Central African CFA Franc',
    'XCD - East Caribbean Dollar',
    'XOF - West African CFA Franc',
    'XPF - CFP Franc',
    'YER - Yemeni Rial',
    'ZAR - South African Rand',
    'ZMW - Zambian Kwacha',
    'ZWL - Zimbabwean Dollar',
  ];

  Color currentColor = Colors.blue;
  final generalController = Get.put(GeneralSettingsController());
  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  bool? _isColorChanged = false;
  void pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor:
                  generalController.appColor.value.toColor() ?? Colors.black,
              onColorChanged: (color) {
                setState(() {
                  currentColor = color;
                });
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Select & Upload'),
              onPressed: () {
                Navigator.of(context).pop();
                generalController.appColor.value = colorToHex(currentColor);

                //generalController.updateAppColor();

                generalController.hasColorChanged.value == true;
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final imageController = Get.put(ProductImagesController());
    final settingsController = Get.put(SettingsController());

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: dark ? Colors.white.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color:
              dark
                  ? Colors.grey.withOpacity(0.5)
                  : TColors.dark.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General Settings',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSizes.spaceBetwwenItems),

            if (TDeviceUtils.isMobileScreen(context))
              TGeneralSettingsMobile(
                currencyController: widget.currencyController,
                currencies: currencies,
                onSelected: widget.onSelected,
                themeController: widget.themeController,
                themes: themes,
              ),

            if (TDeviceUtils.isDesktopScreen(context) ||
                TDeviceUtils.isTabletScreen(context))
              TGeneralSettingDesktop(
                currencyController: widget.currencyController,
                currencies: currencies,
                onSelected: widget.onSelected,
                themeController: widget.themeController,
                themes: themes,
              ),

            const SizedBox(height: TSizes.spaceBetwwenItems),

            // App Icon / Logo
            const SizedBox(height: TSizes.spaceBetweenInputFields),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      'Maintenance Mode',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),

                    Obx(() {
                      return ToggleButtons(
                        borderRadius: BorderRadius.circular(8),
                        selectedColor: Colors.white,
                        fillColor: TColors.primary,
                        isSelected: [
                          !generalController.maintenanceMode.value, // OFF
                          generalController.maintenanceMode.value, // ON
                        ],
                        onPressed: (index) {
                          settingsController.maintenanceMode.value = index == 1;
                          generalController.updateMaintenanceMode(
                            settingsController.maintenanceMode.value,
                          );
                          print(
                            'Maintenance mode is ${settingsController.maintenanceMode.value ? "ON" : "OFF"}',
                          );
                          // TODO: Save this state to Supabase if needed
                        },
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('OFF'),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('ON'),
                          ),
                        ],
                      );
                    }),
                  ],
                ),

                const SizedBox(width: TSizes.spaceBetwwenItems),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choose your App Theme Colour',
                        style: Theme.of(context).textTheme.titleMedium,overflow: TextOverflow.ellipsis,softWrap: true,
                      ),
                      const SizedBox(height: TSizes.spaceBetwwenItems),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => pickColor(context),
                            child: Text(
                              'Pick',
                              style: Theme.of(context).textTheme.titleSmall!
                                  .apply(color: TColors.primary),
                            ),
                          ),
                          const SizedBox(width: TSizes.spaceBetwwenItems),
                          Obx(() => Text(generalController.appColor.value)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TGeneralSettingsMobile extends StatelessWidget {
  const TGeneralSettingsMobile({
    super.key,
    required this.currencyController,
    required this.currencies,
    required this.onSelected,
    required this.themeController,
    required this.themes,
  });

  final TextEditingController currencyController;
  final List<String> currencies;
  final void Function(String p1)? onSelected;
  final TextEditingController themeController;
  final List<String> themes;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GeneralSettingsController());
    return Column(
      children: [
        Container(
          width: TSizes.buttonWidth * 3,
          child: TextFormField(
            controller: controller.appCurrencySymbol,
            decoration: const InputDecoration(
              labelText: 'App Currency Symbol',
              hintText: 'Enter your currency symbol Eg: USD | \$',
            ),
            validator:
                (value) =>
                    TValidator.validateEmptyText('App Currency Symbol', value),
          ),
        ),
        const SizedBox(height: TSizes.spaceBetweenInputFields),

        // App Description
        Container(
          width: TSizes.buttonWidth * 3,
          child: TextFormField(
            controller: controller.appDescriptionController,
            decoration: const InputDecoration(
              labelText: 'App Description',
              hintText: 'Enter Your App Description',
            ),
            validator:
                (value) =>
                    TValidator.validateEmptyText('App Description', value),
          ),
        ),
        const SizedBox(height: TSizes.spaceBetweenInputFields),
        Container(
          width: TSizes.buttonWidth * 3,
          child: TypeAheadField<String>(
            builder: (context, textEditingController, focusNode) {
              return TextFormField(
                controller: controller.currencyController,
                focusNode: focusNode,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select Currency',
                  suffixIcon: Icon(Iconsax.dollar_circle),
                ),
              );
            },
            suggestionsCallback: (pattern) {
              if (pattern.isEmpty) return currencies;
              return currencies
                  .where(
                    (item) =>
                        item.toLowerCase().contains(pattern.toLowerCase()),
                  )
                  .toList();
            },
            itemBuilder: (context, String suggestion) {
              return ListTile(title: Text(suggestion));
            },
            onSelected: (String selected) {
              controller.currencyController.text = selected;
              if (onSelected != null) onSelected!(selected);
            },
          ),
        ),

        const SizedBox(height: TSizes.spaceBetweenInputFields),
        Container(
          width: TSizes.buttonWidth * 3,
          child: TypeAheadField<String>(
            builder: (context, textEditingController, focusNode) {
              return TextFormField(
                controller: controller.themeController,
                focusNode: focusNode,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select Theme',
                  suffixIcon: Icon(Iconsax.toggle_off),
                ),
              );
            },
            suggestionsCallback: (pattern) {
              if (pattern.isEmpty) return themes;
              return themes
                  .where(
                    (item) =>
                        item.toLowerCase().contains(pattern.toLowerCase()),
                  )
                  .toList();
            },
            itemBuilder: (context, String suggestion) {
              return ListTile(title: Text(suggestion));
            },
            onSelected: (String selected) {
              controller.themeController.text = selected;
              if (onSelected != null) onSelected!(selected);
            },
          ),
        ),
        Obx(() {
          if (controller.hasCurrencySymbolChanged.value ||
              controller.hasCurrencyChanged.value ||
              controller.hasDescriptionChanged.value ||
              controller.hasThemeChanged.value ||
              controller.hasColorChanged.value) {
            return Column(
              children: [
                const SizedBox(height: TSizes.spaceBetwwenItems),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: TColors.primary,
                      border: Border.all(color: Colors.white.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('Save'),
                    ),
                  ),
                ),
              ],
            );
          }
          return SizedBox.shrink();
        }),
      ],
    );
  }
}

class TGeneralSettingDesktop extends StatelessWidget {
  TGeneralSettingDesktop({
    super.key,
    required this.currencyController,
    required this.currencies,
    required this.onSelected,
    required this.themeController,
    required this.themes,
  });

  final TextEditingController currencyController;
  final List<String> currencies;
  final void Function(String p1)? onSelected;
  final TextEditingController themeController;
  final List<String> themes;
  final List<String> districts = [
    'Colombo',
    'Gampaha',
    'Kalutara',
    'Kandy',
    'Matale',
    'Nuwara Eliya',
    'Galle',
    'Matara',
    'Hambantota',
    'Jaffna',
    'Kilinochchi',
    'Mannar',
    'Vavuniya',
    'Mullaitivu',
    'Batticaloa',
    'Ampara',
    'Trincomalee',
    'Kurunegala',
    'Puttalam',
    'Anuradhapura',
    'Polonnaruwa',
    'Badulla',
    'Monaragala',
    'Ratnapura',
    'Kegalle',
  ];

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(Get.context!);
    final controller = Get.put(GeneralSettingsController());

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            // App Currency Symbol
            Container(
              width: TSizes.buttonWidth * 2.7,
              child: TextFormField(
                controller: controller.appCurrencySymbol,
                decoration: InputDecoration(
                  labelText: 'App Currency Symbol',
                  hintText: 'Enter your currency symbol Eg: USD | \$',
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(color: Colors.red),
                  ),
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
                ),

                validator:
                    (value) => TValidator.validateEmptyText(
                      'App Currency Symbol',
                      value,
                    ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBetweenInputFields),
            Container(
              width: TSizes.buttonWidth * 2.7,
              child: TypeAheadField<String>(
                builder: (context, textEditingController, focusNode) {
                  return TextFormField(
                    controller: controller.appDescriptionController,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Store Location',
                      hintText: 'Enter Your Location | District',
                      suffixIcon: Icon(Iconsax.location),
                    ),
                    validator:
                        (value) => TValidator.validateEmptyText(
                          'Store Location',
                          value,
                        ),
                  );
                },
                suggestionsCallback: (pattern) {
                  return districts
                      .where(
                        (district) => district.toLowerCase().contains(
                          pattern.toLowerCase(),
                        ),
                      )
                      .toList();
                },
                itemBuilder: (context, String suggestion) {
                  return ListTile(title: Text(suggestion));
                },
                onSelected: (String selected) {
                  controller.appDescriptionController.text = selected;
                },
              ),
            ),

            // App Description
          ],
        ),
        const SizedBox(width: TSizes.spaceBetwwenItems),
        Column(
          children: [
            // Currency TypeAheadField
            Container(
              width: TSizes.buttonWidth * 2.7,
              child: TypeAheadField<String>(
                builder: (context, textEditingController, focusNode) {
                  return TextFormField(
                    controller: controller.currencyController,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Select Currency',
                      suffixIcon: Icon(Iconsax.dollar_circle),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
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
                    ),
                  );
                },
                suggestionsCallback: (pattern) {
                  if (pattern.isEmpty) return currencies;
                  return currencies
                      .where(
                        (item) =>
                            item.toLowerCase().contains(pattern.toLowerCase()),
                      )
                      .toList();
                },
                itemBuilder: (context, String suggestion) {
                  return ListTile(title: Text(suggestion));
                },
                onSelected: (String selected) {
                  controller.currencyController.text = selected;
                  if (onSelected != null) onSelected!(selected);
                },
              ),
            ),

            const SizedBox(height: TSizes.spaceBetweenInputFields),
            Container(
              width: TSizes.buttonWidth * 2.7,
              child: TypeAheadField<String>(
                builder: (context, textEditingController, focusNode) {
                  return TextFormField(
                    controller: controller.themeController,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Select Theme',
                      suffixIcon: Icon(Iconsax.toggle_off),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
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
                    ),
                  );
                },
                suggestionsCallback: (pattern) {
                  if (pattern.isEmpty) return themes;
                  return themes
                      .where(
                        (item) =>
                            item.toLowerCase().contains(pattern.toLowerCase()),
                      )
                      .toList();
                },
                itemBuilder: (context, String suggestion) {
                  return ListTile(title: Text(suggestion));
                },
                onSelected: (String selected) {
                  controller.themeController.text = selected;
                  if (onSelected != null) onSelected!(selected);
                },
              ),
            ),
          ],
        ),
        Obx(() {
          if (controller.hasCurrencySymbolChanged.value ||
              controller.hasCurrencyChanged.value ||
              controller.hasDescriptionChanged.value ||
              controller.hasThemeChanged.value) {
            return Row(
              children: [
                const SizedBox(width: TSizes.spaceBetwwenItems),
                GestureDetector(
                //  onTap: () => controller.updateAppConfig(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: TColors.primary,
                      border: Border.all(color: Colors.white.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('Save'),
                    ),
                  ),
                ),
              ],
            );
          }
          return SizedBox.shrink();
        }),
      ],
    );
  }
}
