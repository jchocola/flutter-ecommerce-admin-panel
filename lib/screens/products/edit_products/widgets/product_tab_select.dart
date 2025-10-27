import 'package:admin_panel/screens/products/create_products/controller/create_product_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TabConfigButtonsEdit extends StatefulWidget {
  const TabConfigButtonsEdit({super.key, this.tabID});

  final String? tabID;
  @override
  State<TabConfigButtonsEdit> createState() => _TabConfigButtonsEditState();
}

class _TabConfigButtonsEditState extends State<TabConfigButtonsEdit> {
  //final supabase = Supabase.instance.client;

  // updated structure: label => list of {id, title}
  Map<String, List<Map<String, dynamic>>> attributeMap = {};
  Map<String, String> selectedValues = {}; // label => selected tab ID
  bool isLoading = true;
    final controller = Get.put(CreateProductController());

  @override
  void initState() {
    super.initState();
    fetchTabConfig();

    controller.selectedTab.value = widget.tabID; 
  }

Future<void> fetchTabConfig() async {
  try {
    // final response = await supabase
    //     .from('tab_config')
    //     .select()
    //     .eq('tab_location', 'home1');

    // if (response is List<dynamic>) {
    //   final Map<String, List<Map<String, dynamic>>> map = {};

    //   for (var item in response) {
    //     final label = item['tab_location'];
    //     final title = item['title'];
    //     final id = item['id'];

    //     if (label == null || title == null || id == null) {
    //       continue;
    //     }

    //     final labelStr = label.toString();
    //     final entry = {
    //       'id': id.toString(),
    //       'title': title.toString(),
    //     };

    //     if (!map.containsKey(labelStr)) {
    //       map[labelStr] = [];
    //     }

    //     map[labelStr]!.add(entry);
    //   }

    //   if(!mounted) return;
    //   setState(() {
    //     attributeMap = map;
    //     // Initialize selectedValues based on controller.selectedTab
    //     for (final label in map.keys) {
    //       // If selectedTab is among options, select it
    //       final tabId = controller.selectedTab.value;
    //       final found = map[label]!.any((tab) => tab['id'] == tabId);
    //       selectedValues[label] = (found ? tabId : '')!;
    //     }

    //     isLoading = false;
    //   });
    // } else {
    //   throw Exception('Unexpected response format');
    // }
  } catch (e) {
    print('Error fetching tab_config: $e');
    setState(() => isLoading = false);
  }
}


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (attributeMap.isEmpty) {
      return const Center(child: Text('No tab config found.'));
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: dark ? Colors.white.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: attributeMap.entries.map((entry) {
          final label = entry.key;
          final values = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Home Tab',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: values.map((tab) {
                  final String tabId = tab['id'];
                  final String title = tab['title'];
                  final isSelected = selectedValues[label] == tabId;

                  return ChoiceChip(
                    label: Text(title),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedValues[label] = selected ? tabId : '';
                      });
                      controller.selectedTab.value = tabId;
                      print('Selected Tab: $tabId');
                    },
                    selectedColor: Colors.blue,
                    backgroundColor: Colors.grey.withOpacity(0.05),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.white,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
          );
        }).toList(),
      ),
    );
  }
}
