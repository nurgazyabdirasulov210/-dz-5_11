
import 'package:clean_app/features/products/domain/model/product_model.dart';
import 'package:equatable/equatable.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

class ProductsLoaded extends ProductsState {
  final List<ProductModel> products;
  const ProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductsError extends ProductsState {
  final String message;
  const ProductsError(this.message);

  @override
  List<Object> get props => [message];
}