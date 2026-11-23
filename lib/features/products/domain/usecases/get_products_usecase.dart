
import 'package:clean_app/core/result/result.dart';
import 'package:clean_app/core/usecase/usecase.dart';
import 'package:clean_app/features/products/domain/model/enum/product_category.dart';
import 'package:clean_app/features/products/domain/model/product_model.dart';
import 'package:clean_app/features/products/domain/repository/product_repository.dart';

class PaginatedProductsParams {
  final ProductCategory? category;
  final int limit;
  final int skip;
  
  const PaginatedProductsParams({
    this.category,
    this.limit = 200,
    this.skip = 0
  });
}


class GetProductsUsecase implements UseCase<PaginatedProductsModel, PaginatedProductsParams> {
  final ProductRepository _repository;
  GetProductsUsecase(this._repository);

  @override
  Future<Result<PaginatedProductsModel>> call(PaginatedProductsParams params) {
    return _repository.getProducts(
      category: params.category,
      limit: params.limit,
      skip: params.skip
    );
  }
}

class GetProductsByIdUsecase implements UseCase<ProductModel, int> {
  final ProductRepository _repository;
  GetProductsByIdUsecase(this._repository);
  
  @override
  Future<Result<ProductModel>> call(int params) {
    return _repository.getProductById(params);
  }
}