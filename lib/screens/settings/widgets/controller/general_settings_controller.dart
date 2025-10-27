import 'package:admin_panel/util/models/app_config_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class GeneralSettingsController extends GetxController {
  static GeneralSettingsController get instance => Get.find();

  var maintenanceMode = false.obs;
  final TextEditingController appCurrencySymbol = TextEditingController();
  var currencySymbol = ''.obs;
  final hasCurrencySymbolChanged = false.obs;

  final TextEditingController currencyController = TextEditingController();
  var currency = ''.obs;
  final hasCurrencyChanged = false.obs;

  final TextEditingController appDescriptionController =
      TextEditingController();
  var description = ''.obs;
  final hasDescriptionChanged = false.obs;

  final TextEditingController themeController = TextEditingController();
  var appTheme = ''.obs;
  final hasThemeChanged = false.obs;

  final TextEditingController colorController = TextEditingController();
  var appColor = ''.obs;
  final hasColorChanged = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMaintenanceMode();
    getExistinAppValues();

    appCurrencySymbol.addListener(() {
      hasCurrencyChanged.value = isCurrencySymbol();
    });

    currencyController.addListener(() {
      hasCurrencyChanged.value = isAppCurrency();
    });

    colorController.addListener(() {
      hasColorChanged.value = isColor();
    });
    appDescriptionController.addListener(() {
      hasDescriptionChanged.value = isAppDescription();
    });

    themeController.addListener(() {
      hasThemeChanged.value = isAppTheme();
    });
  }

  bool isCurrencySymbol() {
    return appCurrencySymbol.text != currencySymbol.value;
  }

  bool isColor() {
    return colorController.text != appColor.value;
  }

  bool isAppCurrency() {
    return currencyController.text != currency.value;
  }

  bool isAppDescription() {
    return appDescriptionController.text != description.value;
  }

  bool isAppTheme() {
    return themeController.text != appTheme.value;
  }

  Future<void> getExistinAppValues() async {
    //final supabase = Supabase.instance.client;

  //   final appNameData =
  //       await supabase
  //           .from('app_config')
  //           .select()
  //           .eq('title', 'currencySymbol')
  //           .maybeSingle();

  //   final appDescriptionData =
  //       await supabase
  //           .from('app_config')
  //           .select()
  //           .eq('title', 'app_store_location')
  //           .maybeSingle();

  //   final appCurrencyData =
  //       await supabase
  //           .from('app_config')
  //           .select()
  //           .eq('title', 'app_currency')
  //           .maybeSingle();

  //   final appThemeData =
  //       await supabase
  //           .from('app_config')
  //           .select()
  //           .eq('title', 'app_theme')
  //           .maybeSingle();

  //   final appColorTheme =
  //       await supabase
  //           .from('app_config')
  //           .select()
  //           .eq('title', 'app_color')
  //           .maybeSingle();

  //   if (appColorTheme != null) {
  //     final value = appColorTheme['value'] ?? '';
  //     colorController.text = value;
  //     appColor.value = value;
  //   }

  //   if (appNameData != null) {
  //     final value = appNameData['value'] ?? '';
  //     appCurrencySymbol.text = value;
  //     currency.value = value;
  //   }

  //   if (appDescriptionData != null) {
  //     final value = appDescriptionData['value'] ?? '';
  //     appDescriptionController.text = value;
  //     description.value = value;
  //   }

  //   if (appThemeData != null) {
  //     final value = appThemeData['value'] ?? '';
  //     themeController.text = value;
  //     appTheme.value = value;
  //   }

  //   if (appCurrencyData != null) {
  //     final value = appCurrencyData['value'] ?? '';
  //     currencyController.text = value;
  //     currency.value = value;
  //   }

  //   hasCurrencySymbolChanged.value = false;
  //   hasDescriptionChanged.value = false;
  //   hasThemeChanged.value = false;
  //   hasCurrencyChanged.value = false;
  // }

  // Future<void> updateAppConfig() async {
  //   updateAppName();
  //   updateAppDescription();
  //   updateAppCurrency();
  //   updateAppTheme();
  //   updateAppColor();

  //   hasCurrencyChanged.value = false;
  //   hasCurrencySymbolChanged.value = false;
  //   hasDescriptionChanged.value = false;
  //   hasThemeChanged.value = false;
  // }

  // void updateAppColor() async {
  //   final supabase = Supabase.instance.client;

  //   final appThemeData =
  //       await supabase
  //           .from('app_config')
  //           .select()
  //           .eq('title', 'app_color')
  //           .maybeSingle();

  //   if (appThemeData != null) {
  //     final respone = await supabase
  //         .from('app_config')
  //         .update({'value': appColor.value})
  //         .eq('title', 'app_color');
  //   } else {
  //     final newAppDesctiption = AppConfigModel(
  //       title: 'app_color',
  //       description: 'App Color',
  //       value: appColor.value,
  //       created_at: DateTime.now().toString(),
  //     );
  //     final respone = await supabase
  //         .from('app_config')
  //         .insert(newAppDesctiption.toJson());
  //   }
  // }

  // void updateAppTheme() async {
  //   final supabase = Supabase.instance.client;

  //   final appThemeData =
  //       await supabase
  //           .from('app_config')
  //           .select()
  //           .eq('title', 'app_theme')
  //           .maybeSingle();

  //   if (appThemeData != null) {
  //     final respone = await supabase
  //         .from('app_config')
  //         .update({'value': themeController.text})
  //         .eq('title', 'app_theme');
  //   } else {
  //     final newAppDesctiption = AppConfigModel(
  //       title: 'app_theme',
  //       description: 'App Theme',
  //       value: themeController.text,
  //       created_at: DateTime.now().toString(),
  //     );
  //     final respone = await supabase
  //         .from('app_config')
  //         .insert(newAppDesctiption.toJson());
  //   }
  }

  void updateAppCurrency() async {
    // final supabase = Supabase.instance.client;

    // final appDesctiptionDate =
    //     await supabase
    //         .from('app_config')
    //         .select()
    //         .eq('title', 'app_currency')
    //         .maybeSingle();

    // if (appDesctiptionDate != null) {
    //   final respone = await supabase
    //       .from('app_config')
    //       .update({'value': currencyController.text})
    //       .eq('title', 'app_currency');
    // } else {
    //   final newAppDesctiption = AppConfigModel(
    //     title: 'app_currency',
    //     description: 'App Currency',
    //     value: currencyController.text,
    //     created_at: DateTime.now().toString(),
    //   );
    //   final respone = await supabase
    //       .from('app_config')
    //       .insert(newAppDesctiption.toJson());
    // }
  }

  void updateAppDescription() async {
  //   final supabase = Supabase.instance.client;

  //   final appDesctiptionDate =
  //       await supabase
  //           .from('app_config')
  //           .select()
  //           .eq('title', 'app_store_location')
  //           .maybeSingle();

  //   if (appDesctiptionDate != null) {
  //     final respone = await supabase
  //         .from('app_config')
  //         .update({'value': appDescriptionController.text})
  //         .eq('title', 'app_store_location');
  //   } else {
  //     final newAppDesctiption = AppConfigModel(
  //       title: 'app_store_location',
  //       description: 'App Description',
  //       value: appDescriptionController.text,
  //       created_at: DateTime.now().toString(),
  //     );
  //     final respone = await supabase
  //         .from('app_config')
  //         .insert(newAppDesctiption.toJson());
  //   }
  // }

  // void updateAppName() async {
  //   final supabase = Supabase.instance.client;

  //   final appNameData =
  //       await supabase
  //           .from('app_config')
  //           .select()
  //           .eq('title', 'currencySymbol')
  //           .maybeSingle();

  //   if (appNameData != null) {
  //     final respone = await supabase
  //         .from('app_config')
  //         .update({'value': appCurrencySymbol.text})
  //         .eq('title', 'currencySymbol');
  //   } else {
  //     final newAppName = AppConfigModel(
  //       title: 'currencySymbol',
  //       description: 'Currency Symbol',
  //       value: appCurrencySymbol.text,
  //       created_at: DateTime.now().toString(),
  //     );
  //     final respone = await supabase
  //         .from('app_config')
  //         .insert(newAppName.toJson());
  //   }
  }

  Future<void> fetchMaintenanceMode() async {
    // final supabase = Supabase.instance.client;
    // final data =
    //     await supabase
    //         .from('app_config')
    //         .select()
    //         .eq('title', 'maintenanceMode')
    //         .maybeSingle();

    // if (data != null && data['value'] != null) {
    //   maintenanceMode.value = data['value'] == 'true';
    // } else {
    //   // Optional: set a default if not found in DB
    //   maintenanceMode.value = false;
    // }
  }

  Future<void> updateMaintenanceMode(bool value) async {
    // await Supabase.instance.client.from('app_config').upsert({
    //   'title': 'maintenanceMode',
    //   'value': value.toString(),
    //   'description': 'Enable/Disable site maintenance mode',
    //   'created_at': DateTime.now().toIso8601String(),
    // }, onConflict: 'title');

    // maintenanceMode.value = value; // update local state
  }
}
