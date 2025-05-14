part of 'edit_product_cubit.dart';

@immutable
sealed class EditProductState {}

final class EditProductInitial extends EditProductState {}




final class EditProductsLoading extends EditProductState {}
final class  EditProductsSuccess extends EditProductState {
  EditProductsSuccess();
}
final class  EditProductsError extends EditProductState {
  String errorMessage;
  EditProductsError(this.errorMessage);
}

final class UploadImageLoading extends EditProductState {}
final class UploadImageSuccess extends EditProductState {
  String path;
  String delete_path;
  UploadImageSuccess(this.path,this.delete_path);
}
final class UploadImageError extends EditProductState {

  String errorMessage;
  UploadImageError(this.errorMessage);
}


final class GetCategoryDetailsLoading extends EditProductState {}
final class GetCategoryDetailsSuccess extends EditProductState {
  List<CategoryModel> categories ;
  GetCategoryDetailsSuccess(this.categories);
}
final class GetCategoryDetailsError extends EditProductState {
  String errorMessage;
  GetCategoryDetailsError(this.errorMessage);
}


final class GetProductDataLoading extends EditProductState {}
final class GetProductDataSuccess extends EditProductState {
  List<ProductModel> products ;
  GetProductDataSuccess(this.products);
}
final class GetProductDataError extends EditProductState {
  String errorMessage;
  GetProductDataError(this.errorMessage);
}


final class DeleteProductDataLoading extends EditProductState {}
final class DeleteProductDataSuccess extends EditProductState {
  List<ProductModel> products ;
  DeleteProductDataSuccess(this.products);
}
final class DeleteProductDataError extends EditProductState {
  String errorMessage;
  DeleteProductDataError(this.errorMessage);
}