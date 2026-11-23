
sealed class ProductsEvent {
  const ProductsEvent();
}

class ProductsRequested extends ProductsEvent {
  const ProductsRequested();
}

class ProductsRefreshed extends ProductsEvent {
  const ProductsRefreshed();
}