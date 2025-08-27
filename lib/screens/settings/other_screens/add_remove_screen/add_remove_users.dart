import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/screens/layouts/headers/header.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/screens/settings/other_screens/add_remove_screen/controller/add_remove_user_controller.dart';
import 'package:admin_panel/screens/settings/other_screens/add_remove_screen/widgets/user_add_items.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/constants/validator.dart';
import 'package:admin_panel/util/device/device_utility.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

class AddRemoveUsersScreen extends StatelessWidget {
  const AddRemoveUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: AddRemoveUsersResp(),
      tablet: AddRemoveUsersResp(),
      mobile: AddRemoveUsersResp(),
    );
  }
}

class AddRemoveUsersResp extends StatefulWidget {
  const AddRemoveUsersResp({super.key});

  @override
  State<AddRemoveUsersResp> createState() => _AddRemoveUsersRespState();
}

class _AddRemoveUsersRespState extends State<AddRemoveUsersResp> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(AddRemoveUserController());
  late bool dark;
  @override
  void initState() {
    super.initState();
    controller.fetchUsers(); // call fetch here
  }

  @override
  Widget build(BuildContext context) {
    dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manage Users',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: TSizes.spaceBetwwenSections),
              if(TDeviceUtils.isMobileScreen(context))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
        
                  
                  Container(
                    decoration: BoxDecoration(
                      color:
                          dark ? Colors.white.withOpacity(0.05) : Colors.white,
                      border: Border.all(
                        color:
                            dark
                                ? Colors.grey.withOpacity(0.5)
                                : TColors.dark.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add New Users',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: TSizes.spaceBetwwenItems),
                            Container(
                              width: TSizes.buttonWidth * 3,
                              child: TextFormField(
                                controller: controller.nameController,
                                decoration: InputDecoration(
                                  labelText: 'User Name',
                                  hintText: 'Enter User Name',
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
                                ),
                                validator:
                                    (value) => TValidator.validateEmptyText(
                                      'User Name',
                                      value,
                                    ),
                              ),
                            ),
                            const SizedBox(height: TSizes.spaceBetwwenItems),
                            Container(
                              width: TSizes.buttonWidth * 3,
                              child: TextFormField(
                                controller: controller.emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email',
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
                                  hintText: 'Enter Email Address',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email is required';
                                  }
                                  final emailRegex = RegExp(
                                    r'^[^@]+@[^@]+\.[^@]+',
                                  );
                                  if (!emailRegex.hasMatch(value)) {
                                    return 'Enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: TSizes.spaceBetweenInputFields,
                            ),
                  
                            Container(
                              width: TSizes.buttonWidth * 3,
                              child: TextFormField(
                                controller: controller.passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Password',
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
                                  hintText: 'Enter Password',
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: TSizes.spaceBetwwenItems),
                  
                            Obx(
                              () => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: TSizes.sm,
                                ),
                                child: DropdownButton<String>(
                                  value:
                                      controller.selectedRole.value.isEmpty
                                          ? null
                                          : controller.selectedRole.value,
                                  items:
                                      controller.roles
                                          .map(
                                            (role) => DropdownMenuItem<String>(
                                              value: role,
                                              child: Row(
                                                children: [
                                                  TRoundedContainer(
                                                    width: 20,
                                                    height: 20,
                                                    backgroundColor:
                                                        THelperFunctions.getRoleColor(
                                                          role,
                                                        ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(role),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (value) {
                                    if (value != null)
                                      controller.selectedRole.value = value;
                                  },
                                  underline: const SizedBox(),
                                  hint: const Text(
                                    'Select Role',
                                  ), // Optional, for null initial value
                                ),
                              ),
                            ),
                  
                            const SizedBox(height: TSizes.spaceBetwwenItems),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  controller.addNewUser();
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: TColors.primary,
                                  border: Border.all(
                                    color:
                                        dark
                                            ? Colors.grey.withOpacity(0.5)
                                            : TColors.dark.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    'Add',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .apply(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBetwwenItems),
        
                  Container(
                    decoration: BoxDecoration(
                      color:
                          dark ? Colors.white.withOpacity(0.05) : Colors.white,
                      border: Border.all(
                        color:
                            dark
                                ? Colors.grey.withOpacity(0.5)
                                : TColors.dark.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Users',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                  
                          SizedBox(
                            height: TDeviceUtils.getScreenHeight() * 0.5,
                            child: Obx(() {
                              if (controller.users.isEmpty) {
                                return const Center(
                                  child: Text('No users found'),
                                );
                              }
                              return ListView.separated(
                                itemCount: controller.users.length,
                                separatorBuilder: (_, __) => Divider(),
                                itemBuilder: (context, index) {
                                  final user = controller.users[index];
                                  return UserAddRemoveItem(
                                    email: user['email'],
                                    role: user['role'],
                                    controller: controller,
                                  );
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ... your existing Users list here ...
                ],
              ),
              if(TDeviceUtils.isDesktopScreen(context) || TDeviceUtils.isTabletScreen(context))
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
        
                  
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            dark ? Colors.white.withOpacity(0.05) : Colors.white,
                        border: Border.all(
                          color:
                              dark
                                  ? Colors.grey.withOpacity(0.5)
                                  : TColors.dark.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add New Users',
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: TSizes.spaceBetwwenItems),
                              Container(
                                width: TSizes.buttonWidth * 3,
                                child: TextFormField(
                                  controller: controller.nameController,
                                  decoration: InputDecoration(
                                    labelText: 'User Name',
                                    hintText: 'Enter User Name',
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
                                  ),
                                  validator:
                                      (value) => TValidator.validateEmptyText(
                                        'User Name',
                                        value,
                                      ),
                                ),
                              ),
                              const SizedBox(height: TSizes.spaceBetwwenItems),
                              Container(
                                width: TSizes.buttonWidth * 3,
                                child: TextFormField(
                                  controller: controller.emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
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
                                    hintText: 'Enter Email Address',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email is required';
                                    }
                                    final emailRegex = RegExp(
                                      r'^[^@]+@[^@]+\.[^@]+',
                                    );
                                    if (!emailRegex.hasMatch(value)) {
                                      return 'Enter a valid email address';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: TSizes.spaceBetweenInputFields,
                              ),
        
                              Container(
                                width: TSizes.buttonWidth * 3,
                                child: TextFormField(
                                  controller: controller.passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
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
                                    hintText: 'Enter Password',
                                  ),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password is required';
                                    }
                                    if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: TSizes.spaceBetwwenItems),
        
                              Obx(
                                () => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: TSizes.sm,
                                  ),
                                  child: DropdownButton<String>(
                                    value:
                                        controller.selectedRole.value.isEmpty
                                            ? null
                                            : controller.selectedRole.value,
                                    items:
                                        controller.roles
                                            .map(
                                              (role) => DropdownMenuItem<String>(
                                                value: role,
                                                child: Row(
                                                  children: [
                                                    TRoundedContainer(
                                                      width: 20,
                                                      height: 20,
                                                      backgroundColor:
                                                          THelperFunctions.getRoleColor(
                                                            role,
                                                          ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Text(role),
                                                  ],
                                                ),
                                              ),
                                            )
                                            .toList(),
                                    onChanged: (value) {
                                      if (value != null)
                                        controller.selectedRole.value = value;
                                    },
                                    underline: const SizedBox(),
                                    hint: const Text(
                                      'Select Role',
                                    ), // Optional, for null initial value
                                  ),
                                ),
                              ),
        
                              const SizedBox(height: TSizes.spaceBetwwenItems),
                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    controller.addNewUser();
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: TColors.primary,
                                    border: Border.all(
                                      color:
                                          dark
                                              ? Colors.grey.withOpacity(0.5)
                                              : TColors.dark.withOpacity(0.2),
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      'Add',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .apply(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBetwwenItems),
        
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            dark ? Colors.white.withOpacity(0.05) : Colors.white,
                        border: Border.all(
                          color:
                              dark
                                  ? Colors.grey.withOpacity(0.5)
                                  : TColors.dark.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Users',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
        
                            SizedBox(
                              height: TDeviceUtils.getScreenHeight() * 0.5,
                              child: Obx(() {
                                if (controller.users.isEmpty) {
                                  return const Center(
                                    child: Text('No users found'),
                                  );
                                }
                                return ListView.separated(
                                  itemCount: controller.users.length,
                                  separatorBuilder: (_, __) => Divider(),
                                  itemBuilder: (context, index) {
                                    final user = controller.users[index];
                                    return UserAddRemoveItem(
                                      email: user['email'],
                                      role: user['role'],
                                      controller: controller,
                                    );
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // ... your existing Users list here ...
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
