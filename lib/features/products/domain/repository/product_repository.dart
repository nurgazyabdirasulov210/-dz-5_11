import 'package:clean_app/core/result/result.dart';
import 'package:clean_app/features/products/domain/model/enum/product_category.dart';
import 'package:clean_app/features/products/domain/model/product_model.dart';

abstract class ProductRepository {
  Future<Result<PaginatedProductsModel>> getProducts({
    ProductCategory? category,
    int limit,
    int skip
  });
  Future<Result<ProductModel>> getProductById(int id);
}