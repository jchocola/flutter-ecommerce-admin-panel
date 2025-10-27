import 'package:admin_panel/common/widgets/chips/t_choice_chips.dart';
import 'package:admin_panel/screens/settings/other_screens/user_activity_screen/controller/user_activity_controller.dart';
import 'package:admin_panel/screens/tabs/controller/tab_controller.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uuid/uuid.dart';

class CreateTabsForm extends StatefulWidget {
  const CreateTabsForm({
    super.key,
    required this.title,
    required this.tabId,
    required this.tabTitle,
    this.isEdit,
    this.buttonTitle = 'Create', this.onRefresh,
  });

  final String title, tabTitle;
  final String tabId;
  final String buttonTitle;

  final bool? isEdit;
  final void Function()? onRefresh;


  @override
  State<CreateTabsForm> createState() => _CreateTabsFormState();
}

class _CreateTabsFormState extends State<CreateTabsForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tabNameController = TextEditingController();

  List<Map<String, dynamic>> categories = [];
  Set<String> selectedCategoryIds = {};

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _tabNameController.text = widget.tabTitle;
    loadCategories();
    
  }

  Future<void> loadCategories() async {
    // final response = await Supabase.instance.client
    //     .from('tab_categories')
    //     .select()
    //     .order('title', ascending: true);
    // final data = List<Map<String, dynamic>>.from(response);

    setState(() {
      // categories = data;

      // // Preselect categories where tab_id matches current tabId
      // selectedCategoryIds =
      //     data
      //         .where((cat) => cat['tab_id']?.toString() == widget.tabId)
      //         .map((cat) => cat['id'].toString())
      //         .toSet();
    });
  }

  String? _selectedTabLocation = 'home'; // default value

Future<void> updateTab() async {
  final tabName = _tabNameController.text.trim();
  if (tabName.isEmpty) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter tab name')),
      );
    }
    return;
  }

  if (mounted) setState(() => isLoading = true);

  try {
    // 1. Update tab_config
    // await Supabase.instance.client
    //     .from('tab_config')
    //     .update({
    //       'title': tabName,
    //       'tab_location': _selectedTabLocation,
    //     })
    //     .eq('id', widget.tabId);

    // // 2. Update selected categories
    // if (selectedCategoryIds.isNotEmpty) {
    //   await Supabase.instance.client
    //       .from('tab_categories')
    //       .update({'tab_id': widget.tabId})
    //       .inFilter('id', selectedCategoryIds.toList());
    // }

    // if (mounted) {
    //      final logController  = Get.put(UserActivityController());

    //  logController.updateUserLog('Tab', 'Tab Updated');
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Tab "$tabName" updated')),
    //   );
    // }

    // // ✅ Return to previous screen and trigger refresh
    // Get.back(result: true);
    // final controller = Get.put(TabsController());

    // controller.fetchTabs();
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating tab: $e')),
      );
    }
  } finally {
    if (mounted) setState(() => isLoading = false);
  }
}


  Future<void> createTab() async {
    final tabName = _tabNameController.text.trim();
    if (tabName.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter tab name')));
      return;
    }

    

    setState(() {
      isLoading = true;
    });

    try {
      // 1. Insert new tab in tab_config
    //   final insertResponse =
    //       await Supabase.instance.client
    //           .from('tab_config')
    //           .insert({
    //             'title': tabName,
    //             'is_active': true,
    //             'tab_location': _selectedTabLocation,
    //             'order': 1, // change as needed
                
    //           })
    //           .select()
    //           .single();

    //   final String newTabId = insertResponse['id']?.toString() ?? '';

    //   if (newTabId.isEmpty) {
    //     throw Exception('Failed to get new tab id');
    //   }
    //      final logController  = Get.put(UserActivityController());

    //  logController.updateUserLog('Tab', 'Tab Created');
    //   // 2. Update selected categories to link to this tab_id
    //   await Supabase.instance.client
    //       .from('tab_categories')
    //       .update({'tab_id': newTabId})
    //       .filter('id', 'in', selectedCategoryIds.toList());

    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(
    //         'Tab "$tabName" created with ${selectedCategoryIds.length} categories',
    //       ),
    //     ),
    //   );

    //   _tabNameController.clear();
    //   setState(() {
    //     selectedCategoryIds.clear();
        
    //   });
    //    loadCategories();
    //   Get.back();
    //   // Reload categories after update
     
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error creating tab: $e')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return TRoundedContainer(
      backgroundColor: dark ? Colors.white.withOpacity(0.05) : Colors.white,
      showBorder: true,
      borderColor:
          dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: TSizes.sm),
            Row(
              spacing: 10,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  widget.tabTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium!.apply(color: TColors.primary),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBetwwenSections),
            TextFormField(
              controller: _tabNameController,
              decoration: const InputDecoration(
                labelText: 'New Tab Name',

                prefixIcon: Icon(Iconsax.box),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter tab name';
                }
                return null;
              },
            ),
            const SizedBox(height: TSizes.spaceBetweenInputFields),
            Text(
              'Select Categories',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: TSizes.spaceBetweenInputFields / 2),
            categories.isEmpty
                ? const Text('No available categories to assign')
                : Wrap(
                  spacing: TSizes.sm,
                  children:
                      categories.map((category) {
                        final String id = category['id']?.toString() ?? '';
                        final title =
                            category['title']?.toString() ?? 'Unknown';
                        final isSelected = selectedCategoryIds.contains(id);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: TSizes.sm),
                          child: TChoiceChips(
                            text: title,
                            selected: isSelected,
                            onSelected: (value) {
                              setState(() {
                                if (value) {
                                  selectedCategoryIds.add(id);
                                } else {
                                  selectedCategoryIds.remove(id);
                                }
                              });
                            },
                          ),
                        );
                      }).toList(),
                ),
            const SizedBox(height: TSizes.spaceBetweenInputFields),

            DropdownButton<String>(
              value: _selectedTabLocation,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTabLocation = newValue;
                });
              },
              items: const [
                DropdownMenuItem<String>(
                  value: 'home',
                  child: Text('Home Screen Tab 1'),
                ),
                DropdownMenuItem<String>(
                  value: 'home1',
                  child: Text('Home Screen Tab 2'),
                ),

                 DropdownMenuItem<String>(
                  value: 'store',
                  child: Text('Store Screen Tab 1'),
                ),
              ],
              dropdownColor: TColors.primary,
              icon: const Icon(Iconsax.arrow_down),
            ),

            const SizedBox(height: TSizes.spaceBetweenInputFields),

            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap:
                    isLoading
                        ? null
                        : () {
                          if (_formKey.currentState?.validate() ?? false) {
                            widget.isEdit == true ? updateTab() : createTab();
                          }
                        },
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        isLoading
                            ? (dark
                                ? Colors.grey.shade600
                                : Colors.grey.shade400)
                            : (dark
                                ? Colors.white.withOpacity(0.05)
                                : TColors.primary),
                    border: Border.all(
                      color:
                          dark
                              ? Colors.grey.withOpacity(0.2)
                              : TColors.dark.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child:
                          isLoading
                              ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                              : Text(
                                widget.buttonTitle,
                                style: TextStyle(
                                  color:
                                      dark ? TColors.textWhite : Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
