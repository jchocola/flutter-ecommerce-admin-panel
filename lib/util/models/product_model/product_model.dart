import 'package:admin_panel/util/models/brand_model.dart';
import 'package:admin_panel/util/models/category_model.dart';
import 'package:admin_panel/util/models/product_model/attributes_model.dart';
import 'package:admin_panel/util/models/product_model/variation_model.dart';

class ProductModel {
  final String? id;
  final String? sku;
  final bool? isFeatured;
  final String? title;
  final BrandModel? brand;
  final List<ProductVariantionsModel>? variation;
  final String? description;
  final String? productType;
  final int? stock;
  final double? price;
  final List<String>? images;
  final double? salesPrice;
  final String? thumbnail;
  final List<ProductAttributeModel>? productAttributes;
  final DateTime? date;
  final String? offerValue;
  final String? selectedTab;
    final List<CategoryModel>? categories;


  ProductModel({
    this.id,
    this.sku,
    this.isFeatured,
    this.title,
    this.brand,
    this.variation,
    this.description,
    this.productType,
    this.stock,
    this.price,
    this.images,
    this.salesPrice,
    this.thumbnail,
    this.productAttributes,
    this.date,
    this.offerValue,
    this.selectedTab,
    this.categories,
  });

 factory ProductModel.fromJson(Map<String, dynamic> json) {
  return ProductModel(
    id: json['id'] as String?,
    sku: json['sku'] as String?,
    isFeatured: json['is_featured'] as bool? ?? false,
    title: json['title'] as String?,
    brand: json['brand'] != null
        ? BrandModel.fromJson(Map<String, dynamic>.from(json['brand']))
        : null,
    variation: (json['variation'] as List?)?.map((x) => 
      ProductVariantionsModel.fromJson(Map<String, dynamic>.from(x))
    ).toList() ?? [],
    description: json['description'] as String?,
    productType: json['product_type'] as String?,
    stock: json['stock'] is int ? json['stock'] as int : 0,
    price: (json['price'] is num)
        ? (json['price'] as num).toDouble()
        : double.tryParse('${json['price']}') ?? 0.0,
    images: json['images'] != null ? List<String>.from(json['images']) : [],
    salesPrice: (json['sales_price'] is num)
        ? (json['sales_price'] as num).toDouble()
        : double.tryParse('${json['sales_price']}') ?? 0.0,
    thumbnail: json['thumbnail'] as String? ?? '',
    productAttributes: (json['product_attributes'] as List?)?.map((x) => 
      ProductAttributeModel.fromJson(Map<String, dynamic>.from(x))
    ).toList() ?? [],
    date: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
    offerValue: json['offerValue'] as String?,
    selectedTab: json['home_tab_id'] as String?,
    categories: (json['categories'] as List?)?.map((x) =>
      CategoryModel.fromJson(Map<String, dynamic>.from(x))
    ).toList() ?? [],
  );
}

Map<String, dynamic> toJson() => {
  'id': id ?? '',  // Provide default empty string if null
  'sku': sku ?? '',
  'is_featured': isFeatured ?? false,
  'title': title ?? '',
  'brand': brand?.toJson() ?? {},
  'variation': variation?.map((v) => v.toJson()).toList() ?? [],
  'description': description ?? '',
  'product_type': productType ?? '',
  'stock': stock ?? 0,
  'price': price ?? 0.0,
  'images': images ?? [],
  'sales_price': salesPrice ?? 0.0,
  'thumbnail': thumbnail ?? '',
  'product_attributes': productAttributes?.map((a) => a.toJson()).toList() ?? [],
  'created_at': date?.toIso8601String() ?? DateTime.now().toIso8601String(),
  'offerValue': offerValue,
  'home_tab_id': selectedTab,
  'categories': categories?.map((a) => a.toJson()).toList() ?? [],
};


}
