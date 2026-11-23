import 'package:clean_app/core/base/base_repository.dart';
import 'package:clean_app/core/result/result.dart';
import 'package:clean_app/features/products/data/datasource/product_datasource.dart';
import 'package:clean_app/features/products/domain/model/product_model.dart';
import 'package:clean_app/features/products/domain/repo/product_repo.dart';

class ProductRepoImpl extends BaseRepository implements ProductRepo {
  final ProductDatasource _remote;

  ProductRepoImpl(this._remote);

  @override
  Future<Result<List<ProductModel>>> getProducts() async {
    try {
      final paginated = await _remote.getProducts();
      return Success(paginated.products);
    } catch (error) {
      return Failed(handleError(error));
    }
  }

  @override
  Future<Result<ProductModel>> productById(int id) async {
    try {
      return Success(await _remote.getProductById(id));
    } catch (error) {
      return Failed(handleError(error));
    }
  }
}



