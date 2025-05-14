part of 'add_offer_cubit.dart';

@immutable
sealed class AddOfferState {}

final class AddOfferInitial extends AddOfferState {}

final class AddOfferLoading extends AddOfferState {}
final class AddOfferSuccess extends AddOfferState {}
final class AddOfferError extends AddOfferState {
  String errorMessage;
  AddOfferError(this.errorMessage);
}


final class UploadImageLoading extends AddOfferState {}
final class UploadImageSuccess extends AddOfferState {
  String path;
  String delete_path;
  UploadImageSuccess(this.path,this.delete_path);
}
final class UploadImageError extends AddOfferState {

  String errorMessage;
  UploadImageError(this.errorMessage);
}



final class GetProductDataLoading extends AddOfferState {}
final class GetProductDataSuccess extends AddOfferState {
  List<ProductModel> product ;
  GetProductDataSuccess(this.product);
}
final class GetProductDataError extends AddOfferState {
  String errorMessage;
  GetProductDataError(this.errorMessage);
}