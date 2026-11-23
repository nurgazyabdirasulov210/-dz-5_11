import 'package:clean_app/core/result/result.dart';
import 'package:clean_app/features/products/domain/model/enum/product_category.dart';
import 'package:clean_app/features/products/domain/usecases/get_products_usecase.dart';
import 'package:clean_app/features/products/view/bloc/products_event.dart';
import 'package:clean_app/features/products/view/bloc/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUsecase _getProducts;

  ProductsBloc(this._getProducts) : super(const ProductsInitial()) {
    on<ProductsRequested>(
      ((event, emit) => _onRequested(state.category, emit)),
    );
    on<ProductsRefreshed>(
      ((event, emit) => _onRequested(state.category, emit)),
    );
    on<ProductsCategoryChanged>(
      ((event, emit) => _onRequested(event.category, emit)),
    );
    on<ProductsNextPageRequested>(
      ((event, emit) => _onNextPageRequested(state.category, emit)),
    );
  }

  Future<void> _onRequested(
    ProductCategory? category,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading(category: category));

    final result = await _getProducts(
      PaginatedProductsParams(category: category, limit: 20, skip: 0),
    );

    switch (result) {
      case Success(:final data):
        if (data.total > data.products.length) {
          emit(ProductsNextPageLoaded(data.products, true, 20, 0, null, category: category));
        } else {
          emit(ProductsNextPageLoaded(data.products, false, 20, 0, null, category: category));
        }
      case Failed(:final failure):
        emit(ProductsError(failure.message, category: category));
    }
  }

  Future<void> _onNextPageRequested(
    ProductCategory? category,
    Emitter<ProductsState> emit,
  ) async {
      final currentState = state;
      if (currentState is! ProductsNextPageLoaded ||
          !currentState.hasMore || currentState.isLoadingNextPage) {
        return;
      }

      emit(ProductsNextPageLoaded(
        currentState.products,
        currentState.hasMore,
        currentState.limit,
        currentState.skip,
        null,
        isLoadingNextPage: true,
        category: category,
      ));

      final result = await _getProducts(
        PaginatedProductsParams(
          category: category, 
          limit: 20,
          skip: currentState.skip + currentState.limit
        ),
      );

      switch (result) {
        case Success(:final data):
          final products = [...currentState.products, ...data.products];
          final nextSkip = currentState.skip + currentState.limit;
          emit(ProductsNextPageLoaded(
            products,
            nextSkip + data.products.length < data.total,
            currentState.limit,
            nextSkip,
            null,
            category: category,
          ));
        case Failed(:final failure):
          emit(ProductsNextPageLoaded(
            currentState.products,
            currentState.hasMore,
            currentState.limit,
            currentState.skip,
            failure.message,
            category: category,
          ));
      }
    
  }
}
