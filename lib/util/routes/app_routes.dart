import 'package:admin_panel/app.dart';
import 'package:admin_panel/screens/banners/banners/banners.dart';
import 'package:admin_panel/screens/banners/create_banners/create_banner.dart';
import 'package:admin_panel/screens/banners/edit_banners/edit_banners.dart';
// import 'package:admin_panel/screens/brands/brands/brands.dart';
// import 'package:admin_panel/screens/brands/create_brands/create_brands.dart';
// import 'package:admin_panel/screens/brands/create_brands/responsive_design/create_brands_desktop.dart';
// import 'package:admin_panel/screens/brands/edit_brands/edit_brands.dart';
import 'package:admin_panel/screens/category/all_categories/category.dart';
import 'package:admin_panel/screens/category/create_categories/create_categories.dart';
import 'package:admin_panel/screens/category/create_categories/responive_screens/create_category_desktop.dart';
import 'package:admin_panel/screens/category/edit_categories/edit_categories.dart';
import 'package:admin_panel/screens/collections/all_collections/collections.dart';
import 'package:admin_panel/screens/customers/all_customers/customers.dart';
import 'package:admin_panel/screens/customers/create_customers/create_customers.dart';
import 'package:admin_panel/screens/customers/edit_customers/edit_customers.dart';
import 'package:admin_panel/screens/dashboard/dahsboard.dart';
import 'package:admin_panel/screens/discounts/all_discounts/discounts.dart';
import 'package:admin_panel/screens/forgot-password/forgot_password.dart';
import 'package:admin_panel/screens/login/login.dart';
import 'package:admin_panel/screens/media/media.dart';
import 'package:admin_panel/screens/orders/all_orders/orders.dart';
import 'package:admin_panel/screens/orders/create_order/create_order.dart';
import 'package:admin_panel/screens/orders/edit_orders/edit_orders.dart';
import 'package:admin_panel/screens/orders/edit_orders/responsive_design/edit_order_desktop.dart';
import 'package:admin_panel/screens/product_settings/product_settings.dart';
import 'package:admin_panel/screens/products/all_products/products.dart';
import 'package:admin_panel/screens/products/all_products/responsive_design/products_desktop.dart';
import 'package:admin_panel/screens/products/create_products/create_products.dart';
import 'package:admin_panel/screens/products/create_products/responsive_design/create_products_desktop.dart';
import 'package:admin_panel/screens/products/edit_products/edit_products.dart';
import 'package:admin_panel/screens/products/edit_products/responsive_design/edit_products_desktop.dart';
import 'package:admin_panel/screens/reset-password/reset_password.dart';
import 'package:admin_panel/screens/restriced/restricted_screen.dart';
import 'package:admin_panel/screens/reviews/all_reviews/reviews.dart';
import 'package:admin_panel/screens/settings/other_screens/add_remove_screen/add_remove_users.dart';
import 'package:admin_panel/screens/settings/other_screens/change_password/change_password.dart';
import 'package:admin_panel/screens/settings/other_screens/set_roles_permission/set_roles_permission.dart';
import 'package:admin_panel/screens/settings/other_screens/user_activity_screen/user_activity_screen.dart';
import 'package:admin_panel/screens/settings/settings.dart';
// import 'package:admin_panel/screens/tabs/all_tabs/tabs.dart';
// import 'package:admin_panel/screens/tabs/create_tabs/create_tabs.dart';
// import 'package:admin_panel/screens/tabs/edit_tabs/edit_tabs.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';

class TAppRoute {
  static final List<GetPage> page = [
    GetPage(name: TRoutes.login, page: () => const LoginScreen()),
    GetPage(
      name: TRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: TRoutes.resetPassword,
      page: () => const ResetPasswordScreen(),
    ),
    GetPage(name: TRoutes.res, page: () => const ResponsiveDesignScreen()),
    GetPage(name: TRoutes.dashboard, page: () => const DashboardScreen()),
    GetPage(name: TRoutes.media, page: () => const MediaScreen()),

    GetPage(name: TRoutes.categories, page: () => const CategoryScreen()),
    GetPage(
      name: TRoutes.createCategory,
      page: () => const CreateCategoriesScreen(),
    ),
    GetPage(
      name: TRoutes.editCategory,
      page: () => const EditCategoriesScreen(),
    ),

    //Brands
    // GetPage(name: TRoutes.brands, page: () => const BrandsScreen()),
    // GetPage(name: TRoutes.createBrand, page: () => const CreateBrandScreen()),
    // GetPage(name: TRoutes.editBrand, page: () => const EditBrandScreen()),

    //Banners
    GetPage(name: TRoutes.banners, page: () => const BannersScreen()),
    GetPage(
      name: TRoutes.createbanners,
      page: () => const CreateBannerScreen(),
    ),
    GetPage(name: TRoutes.editbanners, page: () => const EditBannersScreen()),

    //Banners
    GetPage(name: TRoutes.products, page: () => const ProductsScreen()),
    GetPage(
      name: TRoutes.createProducts,
      page: () => const CreateProductsScreen(),
    ),
    GetPage(name: TRoutes.editProducts, page: () => const EditProductsScreen()),

    //Customers
    GetPage(name: TRoutes.customers, page: () => const CustomersScreen()),
    GetPage(
      name: TRoutes.createCustomers,
      page: () => const CreateCustomersScreen(),
    ),
    GetPage(
      name: TRoutes.editCustomers,
      page: () => const EditCustomersScreen(),
    ),

    //Discounts
    GetPage(name: TRoutes.discounts, page: ()=> const DiscountsScreen()),

    //Collections
    GetPage(name: TRoutes.collections, page: ()=>const CollectionsScreen()),

    //Reviews
    GetPage(name: TRoutes.reviews, page: ()=> const ReviewsScreen()),

    //Tabs
    // GetPage(name: TRoutes.tabs, page: () => const TabsScreen()),
    // GetPage(name: TRoutes.createTabs, page: () => const CreateTabsScreen()),
    // GetPage(name: TRoutes.editTabs, page: () => const EditTabsScreen()),

    //Settings
    GetPage(name: TRoutes.settings, page: () => const SettingsScreen()),
    GetPage(
      name: TRoutes.product_settings,
      page: () => const ProductSettingsScreen(),
    ),

    //Combo Offer

    //Orders
    GetPage(name: TRoutes.orders, page: () => const OrdersScreen()),
    GetPage(name: TRoutes.createOrders, page: () => const CreateOrderScreen()),
    GetPage(name: TRoutes.editOrders, page: () => const EditOrdersScreen()),

    //Settings
    GetPage(
      name: TRoutes.changePassword,
      page: () => const ChangePasswordScreen(),
    ),

    GetPage(
      name: TRoutes.manageUsers,
      page: () => const AddRemoveUsersScreen(),
    ),
    
    GetPage(
      name: TRoutes.setRoles,
      page: () => const SetRolesPermissionScreen(),
    ),
    
     GetPage(
      name: TRoutes.userActivityLog,
      page: () => const UserActivityScreen(),
    ),

     GetPage(
      name: TRoutes.restrictedScreen,
      page: () => const RestrictedScreen(),
    ),
  ];
}
