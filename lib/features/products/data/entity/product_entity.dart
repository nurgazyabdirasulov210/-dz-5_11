
import 'package:clean_app/features/products/domain/model/enum/product_category.dart';
import 'package:clean_app/features/products/domain/model/product_model.dart';

class PaginatedProductsEntity extends PaginatedProductsModel {

  const PaginatedProductsEntity({
    required super.products,
    required super.total,
    required super.skip,
    required super.limit,
  });

  factory PaginatedProductsEntity.fromJson(Map<String, dynamic> json) {
    return PaginatedProductsEntity(
      products: (json["products"] as List).map((e) => ProductEntity.fromJson(e)).toList(), 
      total: json["total"], 
      skip: json["skip"], 
      limit: json["limit"]
    );
  }

}



class ProductEntity extends ProductModel {
  const ProductEntity({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
    required super.category,
    required super.description,
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      image: json['thumbnail'],
      category: ProductCategory.fromApi(json['category']),
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'thumbnail': image,
      'category': category.apiValue,
      'description': description,
    };
  }
}
