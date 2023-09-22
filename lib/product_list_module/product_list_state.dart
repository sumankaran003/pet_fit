part of 'product_list_bloc.dart';


abstract class ProductListState {}

class ProductListInitial extends ProductListState {}

class ProductsLoaded extends ProductListState {
  final List<ProductModel> products;

  ProductsLoaded(this.products);
}


class ProductsLoading extends ProductListState {}

class ProductsLoadingError extends ProductListState {
  final String errorMessage;

  ProductsLoadingError(this.errorMessage);
}
