

import 'package:clean_app/core/result/result.dart';
import 'package:clean_app/core/usecase/usecase.dart';
import 'package:clean_app/features/products/domain/model/product_model.dart';
import 'package:clean_app/features/products/domain/repo/product_repo.dart';

class GetProductUseCase implements UseCase<List<ProductModel>, NoParams> {
 final ProductRepo _productRepo;
  GetProductUseCase(this._productRepo);
 
 
 
  @override
  Future<Result<List<ProductModel>>> call(NoParams params) {
   
    return _productRepo.getProducts();
  }

}

class GetProductByIdUseCase implements UseCase<ProductModel, int> {
  final ProductRepo _productRepo;
  GetProductByIdUseCase(this._productRepo);

  @override
  Future<Result<ProductModel>> call(int params) {
    return _productRepo.productById(params);
  }}