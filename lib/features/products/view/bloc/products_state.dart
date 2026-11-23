
import 'package:clean_app/features/products/domain/model/enum/product_category.dart';
import 'package:clean_app/features/products/domain/model/product_model.dart';
import 'package:equatable/equatable.dart';

sealed class ProductsState extends Equatable{
  final ProductCategory? category;

  const ProductsState({this.category});
  @override
  List<Object?> get props => [category];
}

class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

class ProductsLoading extends ProductsState {
  const ProductsLoading({super.category});
}

class ProductsLoaded extends ProductsState {
  final List<ProductModel> products;
  const ProductsLoaded(this.products, {super.category});
  @override
  List<Object?> get props => [products, category];
}

class ProductsError extends ProductsState {
  final String message;
  const ProductsError(this.message, {super.category});
  @override
  List<Object?> get props => [message, category];
}

class ProductsNextPageLoaded extends ProductsState {
  final List<ProductModel> products;
  final bool hasMore;
  final int limit;
  final int skip;
  final String? nextPageError;
  final bool isLoadingNextPage;

  const ProductsNextPageLoaded(
    this.products,
    this.hasMore,
    this.limit,
    this.skip,
    this.nextPageError,
    {this.isLoadingNextPage = false, super.category}
  );
  @override
  List<Object?> get props => [
    products,
    category,
    hasMore,
    limit, 
    skip, 
    nextPageError
    , isLoadingNextPage
  ];
}
