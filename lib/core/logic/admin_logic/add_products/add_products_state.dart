part of 'add_products_cubit.dart';

@immutable
sealed class AddProductsState {}

final class AddProductsInitial extends AddProductsState {}


final class AddProductsLoading extends AddProductsState {}
final class  AddProductsSuccess extends AddProductsState {
  AddProductsSuccess();
}
final class  AddProductsError extends AddProductsState {
  String errorMessage;
  AddProductsError(this.errorMessage);
}

final class UploadImageLoading extends AddProductsState {}
final class UploadImageSuccess extends AddProductsState {
  String path;
  String Deletepath;
  UploadImageSuccess(this.path,this.Deletepath);
}
final class UploadImageError extends AddProductsState {

  String errorMessage;
  UploadImageError(this.errorMessage);
}


final class GetCategoryDetailsLoading extends AddProductsState {}
final class GetCategoryDetailsSuccess extends AddProductsState {
  List<CategoryModel> categories ;
  GetCategoryDetailsSuccess(this.categories);
}
final class GetCategoryDetailsError extends AddProductsState {
  String errorMessage;
  GetCategoryDetailsError(this.errorMessage);
}

