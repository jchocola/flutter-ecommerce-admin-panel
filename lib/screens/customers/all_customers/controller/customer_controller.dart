import 'package:admin_panel/util/models/address_model.dart';
import 'package:admin_panel/util/models/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class CustomerController extends GetxController {
  static CustomerController get instance => Get.find();

  //final supabase = Supabase.instance.client;
  final RxList<Map<String, dynamic>> customers = <Map<String, dynamic>>[].obs;

  final isLoading = true.obs;

  //Editing COntrollers
  final TextEditingController customerNameController = TextEditingController();
  var customerName = ''.obs;
  final hasCustomerNameChanged = false.obs;

  final TextEditingController customerEmailController = TextEditingController();
  var customerEmail = ''.obs;
  final hasCustomerEmailChanged = false.obs;

  final TextEditingController customerPhoneNumberController =
      TextEditingController();
  var customerPhoneNumber = ''.obs;
  final hasPhoneNumberChanged = false.obs;

  final TextEditingController shippingStreetController =
      TextEditingController();
  var shippngStreet = ''.obs;
  final hasShippingStreetChanged = false.obs;

  final TextEditingController shippingCityController = TextEditingController();
  var shippingCity = ''.obs;
  final hasShippingCityChanged = false.obs;

  final TextEditingController shippingStateController = TextEditingController();
  var shippingState = ''.obs;
  final hasShippingStateChanged = false.obs;

  final TextEditingController shippingCountryController =
      TextEditingController();
  var shpippingCountry = ''.obs;
  final hasShippingCountryChanged = false.obs;

  final TextEditingController billingStreetController = TextEditingController();
  var billingStreet = ''.obs;
  final hasBillingStreetChanged = false.obs;

  final TextEditingController billingCityController = TextEditingController();
  var billingCity = ''.obs;
  final hasBillingCityChanged = false.obs;

  final TextEditingController billingStateController = TextEditingController();
  var billingState = ''.obs;
  final hasBillingStateChanged = false.obs;

  final TextEditingController billingCountryController =
      TextEditingController();
  var billingCountry = ''.obs;
  final hasBillingCountryChanged = false.obs;
  //Editing Controllers
  @override
  void onInit() {
    super.onInit();
    fetchCustomers();

    customerNameController.addListener(() {
      hasCustomerNameChanged.value = isCustomerName();
    });

    customerEmailController.addListener(() {
      hasCustomerEmailChanged.value = isCutomerEmail();
    });
    customerPhoneNumberController.addListener(() {
      hasPhoneNumberChanged.value = isCustomerPhoneNumber();
    });

    shippingStreetController.addListener(() {
      hasShippingStreetChanged.value = isShippingStreet();
    });

    shippingCityController.addListener(() {
      hasShippingCityChanged.value = isShippingCity();
    });

    shippingStateController.addListener(() {
      hasShippingStateChanged.value = isShippingState();
    });

    shippingCountryController.addListener(() {
      hasShippingCountryChanged.value = isShippingCountry();
    });

    billingStreetController.addListener(() {
      hasBillingStreetChanged.value = isBillingStreet();
    });

    billingCityController.addListener(() {
      hasBillingCityChanged.value = isBillingCity();
    });

    billingStateController.addListener(() {
      hasBillingStateChanged.value = isBillingState();
    });

    billingCountryController.addListener(() {
      hasBillingCountryChanged.value = isBillingCountry();
    });
  }

  bool isCustomerName() {
    return customerNameController.text != customerName.value;
  }

  bool isCutomerEmail() {
    return customerEmailController.text != customerEmail.value;
  }

  bool isCustomerPhoneNumber() {
    return customerPhoneNumberController.text != customerPhoneNumber.value;
  }

  bool isShippingStreet() {
    return shippingStreetController.text != shippngStreet.value;
  }

  bool isShippingCity() {
    return shippingCityController.text != shippingCity.value;
  }

  bool isShippingState() {
    return shippingStateController.text != shippingState.value;
  }

  bool isShippingCountry() {
    return shippingCountryController.text != shpippingCountry.value;
  }

  bool isBillingStreet() {
    return billingStreetController.text != billingStreet.value;
  }

  bool isBillingCity() {
    return billingCityController.text != billingCity.value;
  }

  bool isBillingState() {
    return billingStateController.text != billingState.value;
  }

  bool isBillingCountry() {
    return billingCountryController.text != billingCountry.value;
  }

  //Supabase Functions

  Future<void> fetchCustomers() async {
    // final response = await Supabase.instance.client
    //     .from('customers')
    //     .select()
    //     .order('created_at', ascending: false);

    //customers.value = List<Map<String, dynamic>>.from(response);
    allCustomers.assignAll(customers);
    filterCustomer.assignAll(customers); // <-- Initial filtered list
    isLoading.value = false;
  }

  void filterCustomersByQuery(String query) {
    final search = query.trim().toLowerCase();
    if (search.isEmpty) {
      filterCustomer.assignAll(allCustomers);
    } else {
      filterCustomer.assignAll(
        allCustomers.where((customer) {
          final name =
              (customer['customerName'] ?? '').toString().toLowerCase();
          return name.contains(search);
        }).toList(),
      );
    }
  }

  void resetSearch() {
    filterCustomer.assignAll(allCustomers);
  }

  Future<CustomerModel?> getCustomerById(String customerId) async {
    try {
      // final response = await supabase
      //     .from('customers')
      //     .select()
      //     .eq('customerID', customerId)
      //     .maybeSingle();  // gets a single row or null

      // if (response != null) {
      //   return CustomerModel.fromJson(response);
      // } else {
      //   print('❌ No customer found with ID: $customerId');
      //   return null;
      // }
    } catch (e) {
      print('❌ Error fetching customer by ID: $e');
      return null;
    }
  }

  Future<void> checkAndCreateCustomer() async {
    final shippingAddress = AddressModel(
      id: Uuid().v4(),
      name: customerNameController.text.toString(),
      phone: customerPhoneNumberController.text.toString(),
      street: shippingStreetController.text.toString(),
      postalCode: 'postalCode',
      city: shippingCityController.text.toString(),
      state: shippingStateController.text.toString(),
      country: shippingCountryController.text.toString(),
    );
    final billingAddress = AddressModel(
      id: Uuid().v4(),
      name: customerNameController.text.toString(),
      phone: customerPhoneNumberController.text.toString(),
      street: billingStreetController.text.toString(),
      postalCode: 'postalCode',
      city: billingCityController.text.toString(),
      state: billingStateController.text.toString(),
      country: billingCountryController.text.toString(),
    );

    final customer = CustomerModel(
      customerID: Uuid().v4(),
      customerName: customerNameController.text.toString(),
      customerPhoneNumber: customerPhoneNumberController.text.toString(),
      customerEmail: customerEmailController.text.toString(),
      totalOrder: '',
      totalSpent: 'totalSpent',
      currentOrders: 'currentOrders',
      created_at: DateTime.now(),
      customerImage: 'No Image',
      shippingAddress: [shippingAddress],
      billingAddress: [billingAddress],
    );
    try {
      // final response =
      //     await supabase
      //         .from('customers')
      //         .select('customerID')
      //         .eq('customerEmail', customerEmailController.text.toString()!)
      //         .maybeSingle();

      // if (response != null) {
      //   print('🟢 Customer already exists:');
      // } else {
      //   // Insert new customer
      //   final insertResponse = await supabase
      //       .from('customers')
      //       .insert(customer.toJson());

      //   print('✅ New customer created: ');
      // }
    } catch (e) {
      print('❌ Error in checkAndCreateCustomer: $e');
    }
  }

  Future<bool> checkCustomerExist(String id) async {
    // final response =
    //     await supabase
    //         .from('customers')
    //         .select('customerID')
    //         .eq('customerID', id)
    //         .maybeSingle();

    //  return response != null;
    return false;
  }

  Future<void> addCustomer(String id) async {
    final newCustomer = CustomerModel(
      customerID: id,
      customerName: 'customerName',
      customerPhoneNumber: 'customerPhoneNumber',
      customerEmail: 'customerEmail',
      totalOrder: 'totalOrder',
      totalSpent: 'totalSpent',
      currentOrders: 'currentOrders',
      created_at: DateTime.now(),
      customerImage: 'No Image',
    );
    print(id);
    try {
      // final response = await supabase
      //     .from('customers')
      //     .insert(newCustomer.toJson());
    } catch (e) {
      print("🎫🎫 ${e.toString()}");
    }
  }

  final RxList<Map<String, dynamic>> allCustomers =
      <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filterCustomer =
      <Map<String, dynamic>>[].obs;
}
