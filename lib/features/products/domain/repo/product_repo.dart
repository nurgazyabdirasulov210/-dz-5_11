import 'package:clean_app/core/result/result.dart';
import 'package:clean_app/features/products/domain/model/product_model.dart';

abstract class ProductRepo {
  Future<Result<List<ProductModel>>> getProducts();
  Future<Result<ProductModel>> productById(int id);
}