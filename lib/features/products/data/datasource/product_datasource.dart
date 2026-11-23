
import 'package:clean_app/core/error/exceptions.dart';
import 'package:clean_app/features/products/data/entity/product_entity.dart';
import 'package:clean_app/features/products/domain/model/enum/product_category.dart';
import 'package:dio/dio.dart';

abstract class ProductDatasource {
  Future<PaginatedProductsEntity> getProducts({
    ProductCategory? category,
    int limit,
    int skip
  });
  Future<ProductEntity> getProductById(int id);
}

class ProductDatasourceImpl implements ProductDatasource {
  final Dio _dio;
  ProductDatasourceImpl(this._dio);

  @override
  Future<ProductEntity> getProductById(int id) async {
    try {
      final response = await _dio.get("/products/$id");
      return ProductEntity.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerExceptions(e.message ?? "Unknown error");
    }
  }

  @override
  Future<PaginatedProductsEntity> getProducts({
    ProductCategory? category,
    int limit = 10,
    int skip = 0
  }) async {
    try {
      final path = category == null
        ? "/products"
        : "/products/category/${category.apiValue}";

      final response = await _dio.get(
        path, 
        queryParameters: {
          "limit": limit,
          "skip": skip
      });
      return PaginatedProductsEntity.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerExceptions(e.message ?? "Unknown error");
    }
  }
}