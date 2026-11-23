
import 'package:clean_app/features/products/domain/model/enum/product_category.dart';
import 'package:equatable/equatable.dart';

class PaginatedProductsModel extends Equatable {
  final List<ProductModel> products;
  final int total;
  final int skip;
  final int limit; 

  const PaginatedProductsModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  @override
  List<Object?> get props => [products, total, skip, limit];
}

class ProductModel extends Equatable{
  final int id;
  final String title;
  final double price;
  final String image;
  final ProductCategory category;
  final String description;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.category,
    required this.description,
  });

  @override
  List<Object?> get props => [id, title, price, image, category, description];
}
