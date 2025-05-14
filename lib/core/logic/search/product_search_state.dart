part of 'product_search_cubit.dart';

@immutable
sealed class ProductSearchState {}

final class ProductSearchInitial extends ProductSearchState {}
final class ProductSearchLoading extends ProductSearchState {}
final class ProductSearchSuccess extends ProductSearchState {
  List<ProductModel> products ;
  ProductSearchSuccess(this.products);
}
final class ProductSearchError extends ProductSearchState {
  String errorMessage;
  ProductSearchError(this.errorMessage);
}
