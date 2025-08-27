import 'package:admin_panel/app.dart';
import 'package:flutter/material.dart';

class TRoutes {
  static const login = '/login';
  static const forgotPassword = '/forgot-Password/';
  static const resetPassword = '/reset-Password';
  static const res = '/res';
  static const dashboard = '/dashboard';
  static const media = '/media';

  static const categories = '/categories';
  static const createCategory = '/createCategory';
  static const editCategory = '/editCategory';

  static const brands = '/brands';
  static const createBrand = '/createBrand';
  static const editBrand = '/editBrand';

  static const banners = '/banners';
  static const createbanners = '/createbanners';
  static const editbanners = '/editbanners';

  static const products = '/products';
  static const createProducts = '/createProducts';
  static const editProducts = '/editProducts';

  static const customers = '/customers';
  static const createCustomers = '/createCustomers';
  static const editCustomers = '/editCustomers';

  static const tabs = '/tabs';
  static const createTabs = '/createTabs';
  static const editTabs = '/editTabs';

  static const settings = '/settings';

  static const product_settings = '/product-settings';


  //Create Combo Offer
  static const createCombo = '/createComboOffer';


  //Order
  static const orders = '/orders';
  static const createOrders = '/createOrders';
  static const editOrders = '/editOrders';

  //Settings
  static const changePassword = '/changePassword';
  static const manageUsers = '/manageUsers';
  static const setRoles = '/setRoles';
  static const userActivityLog = '/userActivityLog';

  static const restrictedScreen = '/restricted';

  //Create Order

  static List sideBarMenuItems = [dashboard, media, categories, brands];
}
