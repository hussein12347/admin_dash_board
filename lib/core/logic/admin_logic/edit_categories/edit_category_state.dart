part of 'edit_category_cubit.dart';

@immutable
sealed class EditCategoryState {}

final class EditCategoryInitial extends EditCategoryState {}



final class EditCategoryLoading extends EditCategoryState {}
final class  EditCategorySuccess extends EditCategoryState {
  EditCategorySuccess();
}
final class  EditCategoryError extends EditCategoryState {
  String errorMessage;
  EditCategoryError(this.errorMessage);
}

final class UploadImageLoading extends EditCategoryState {}
final class UploadImageSuccess extends EditCategoryState {
  String path;
  String delete_path;
  UploadImageSuccess(this.path,this.delete_path);
}
final class UploadImageError extends EditCategoryState {

  String errorMessage;
  UploadImageError(this.errorMessage);
}


final class GetCategoryDetailsLoading extends EditCategoryState {}
final class GetCategoryDetailsSuccess extends EditCategoryState {
  List<CategoryModel> categories ;
  GetCategoryDetailsSuccess(this.categories);
}
final class GetCategoryDetailsError extends EditCategoryState {
  String errorMessage;
  GetCategoryDetailsError(this.errorMessage);
}





final class DeleteCategoryLoading extends EditCategoryState {}
final class DeleteCategorySuccess extends EditCategoryState {
  List<CategoryModel> categories ;
  DeleteCategorySuccess(this.categories);
}
final class DeleteCategoryError extends EditCategoryState {
  String errorMessage;
  DeleteCategoryError(this.errorMessage);
}
