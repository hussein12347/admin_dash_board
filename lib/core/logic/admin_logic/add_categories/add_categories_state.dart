part of 'add_categories_cubit.dart';

@immutable
sealed class AddCategoriesState {}

final class AddCategoriesInitial extends AddCategoriesState {}


final class AddCategoriesLoading extends AddCategoriesState {}
final class AddCategoriesSuccess extends AddCategoriesState {}
final class AddCategoriesError extends AddCategoriesState {
  String errorMessage;
  AddCategoriesError(this.errorMessage);
}


final class UploadImageLoading extends AddCategoriesState {}
final class UploadImageSuccess extends AddCategoriesState {
  String path;
  String delete_path;
  UploadImageSuccess(this.path,this.delete_path);
}
final class UploadImageError extends AddCategoriesState {

  String errorMessage;
  UploadImageError(this.errorMessage);
}