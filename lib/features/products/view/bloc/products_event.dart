

import 'package:clean_app/features/products/domain/model/enum/product_category.dart';

sealed class ProductsEvent {
  const ProductsEvent();
}

class ProductsRequested extends ProductsEvent {
  const ProductsRequested();
}

class ProductsRefreshed extends ProductsEvent {
  const ProductsRefreshed();
}

class ProductsCategoryChanged extends ProductsEvent {
  final ProductCategory? category;
  const ProductsCategoryChanged(this.category);
}

class ProductsNextPageRequested extends ProductsEvent {
  const ProductsNextPageRequested();
}
