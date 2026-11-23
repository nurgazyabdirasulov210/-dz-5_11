import 'package:clean_app/core/result/result.dart';
import 'package:clean_app/core/usecase/usecase.dart';
import 'package:clean_app/features/products/domain/model/enum/product_category.dart';
import 'package:clean_app/features/products/domain/model/product_model.dart';
import 'package:clean_app/features/products/domain/repository/product_repository.dart';

class GetProductUseCase
    implements UseCase<PaginatedProductsModel, PaginatedProductsParams> {
  final ProductRepository _productRepository;

  GetProductUseCase(this._productRepository);

  @override
  Future<Result<PaginatedProductsModel>> call(PaginatedProductsParams params) {
    return _productRepository.getProducts(
      category: params.category,
      limit: params.limit,
      skip: params.skip,
    );
  }
}

class PaginatedProductsParams {
  final ProductCategory? category;
  final int limit;
  final int skip;

  const PaginatedProductsParams({
    this.category,
    this.limit = 20,
    this.skip = 0,
  });
}

class GetProductByIdUseCase implements UseCase<ProductModel, int> {
  final ProductRepository _productRepository;

  GetProductByIdUseCase(this._productRepository);

  @override
  Future<Result<ProductModel>> call(int params) {
    return _productRepository.getProductById(params);
  }
}
