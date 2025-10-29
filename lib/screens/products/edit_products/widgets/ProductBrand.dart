// import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
// import 'package:admin_panel/screens/brands/create_brands/controller/brand_controller.dart';
// import 'package:admin_panel/screens/products/create_products/controller/create_product_controller.dart';
// import 'package:admin_panel/util/constants/colors.dart';
// import 'package:admin_panel/util/constants/image_strings.dart';
// import 'package:admin_panel/util/constants/sizes.dart';
// import 'package:admin_panel/util/helpers/helpers_function.dart';
// import 'package:admin_panel/util/models/brand_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:get/instance_manager.dart';
// import 'package:get/utils.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:uuid/uuid.dart';

// class ProductBrandEdit extends StatefulWidget {
//   const ProductBrandEdit({super.key, this.selectedBrand});

//   final BrandModel? selectedBrand;

//   @override
//   State<ProductBrandEdit> createState() => _ProductBrandEditState();
// }

// class _ProductBrandEditState extends State<ProductBrandEdit> {
//     final controller = Get.put(CreateProductController());
//     final brandController = Get.put(BrandController());
//       final TextEditingController brandTextController = TextEditingController();
//   @override
//   void initState() {
//     super.initState();

//     // ✅ If a brand is passed (editing), set text and value once
//     if (widget.selectedBrand != null) {
//       controller.selectBrand.value = widget.selectedBrand!;
//       brandTextController.text = widget.selectedBrand!.title ?? '';
//     }

//     // Assign to global controller (optional)
//     controller.brandTextField = brandTextController;
//   }
//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);
  

  
    
    
//     return TRoundedContainer(
//       backgroundColor: Colors.transparent,
//       showBorder: true,
//       radius: 5,
//       borderColor:
//           dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2),
//           padding: EdgeInsets.all(TSizes.defaultSpace),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Brand', style: Theme.of(context).textTheme.headlineSmall),
//           const SizedBox(height: TSizes.spaceBetwwenItems),
// TypeAheadField<BrandModel>(
//   builder: (context, ctr, focusNode) {
//     controller.brandTextField  ??= ctr;
//     return TextFormField(
      
//       focusNode: focusNode,
//       controller: brandTextController,
//       decoration:  InputDecoration(
//         border: OutlineInputBorder(),
//         labelText: 'Select Brand',
//         suffixIcon: Icon(Iconsax.box),
//             enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(5)),
//           borderSide: BorderSide(
//             color:
//                 dark
//                     ? Colors.grey.withOpacity(0.5)
//                     : TColors.dark.withOpacity(0.2),
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(5)),
//           borderSide: BorderSide(
//             color:
//                 dark
//                     ? Colors.white.withOpacity(1)
//                     : TColors.dark.withOpacity(1),
//           ),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(5)),
//           borderSide: BorderSide(color: Colors.red),
//         ),
//       ),
//     );
//   },
//   suggestionsCallback: (pattern) {
//     final brands = brandController.brands;
//     if (pattern.isEmpty) return brands;
//     return brands.where((b) => b.title != null && b.title!.toLowerCase().contains(pattern.toLowerCase())).toList();
//   },
//   itemBuilder: (context, BrandModel suggestion) {
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundColor: Colors.transparent,
//         backgroundImage: NetworkImage(suggestion.imageUrl ?? ''),
//       ),
//       title: Text(suggestion.title ?? 'Unknown Brand'),
//     );
//   },
//   onSelected: (BrandModel selectedBrand) {
//     controller.brandTextField!.text = selectedBrand.title ?? '';
//     controller.selectBrand.value = selectedBrand;
//   },
// ),

//         ],
//       ),
//     );
//   }
// }
