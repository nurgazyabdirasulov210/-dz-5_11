import 'package:clean_app/core/base/base_repository.dart';
import 'package:clean_app/core/result/result.dart';
import 'package:clean_app/features/products/data/datasource/product_datasource.dart';
import 'package:clean_app/features/products/domain/model/enum/product_category.dart';
import 'package:clean_app/features/products/domain/model/product_model.dart';
import 'package:clean_app/features/products/domain/repository/product_repository.dart';

class ProductRepositoryImpl extends BaseRepository implements ProductRepository {
  final ProductDatasource _remote;
  ProductRepositoryImpl(this._remote);

  @override
  Future<Result<ProductModel>> getProductById(int id) async {
    try {
      return Success(await _remote.getProductById(id));
    } catch (e) {
      return Failed(handleError(e));
    }
  }

  @override
  Future<Result<PaginatedProductsModel>> getProducts({
    ProductCategory? category,
    int limit = 10,
    int skip = 0,
  }) async {
    try {
      final products = await _remote.getProducts(
        category: category,
        limit: limit,
        skip: skip,
      );
      return Success(products);
    } catch (e) {
      return Failed(handleError(e));
    }
  }
}