part of 'edit_offer_cubit.dart';

@immutable
sealed class EditOfferState {}

final class EditOfferInitial extends EditOfferState {}

final class EditOfferLoading extends EditOfferState {}
final class  EditOfferSuccess extends EditOfferState {
  EditOfferSuccess();
}
final class  EditOfferError extends EditOfferState {
  String errorMessage;
  EditOfferError(this.errorMessage);
}

final class UploadImageLoading extends EditOfferState {}
final class UploadImageSuccess extends EditOfferState {
  String path;
  String delete_path;
  UploadImageSuccess(this.path,this.delete_path);
}
final class UploadImageError extends EditOfferState {

  String errorMessage;
  UploadImageError(this.errorMessage);
}


final class GetOfferDetailsLoading extends EditOfferState {}
final class GetOfferDetailsSuccess extends EditOfferState {
  List<OfferModel> offers ;
  GetOfferDetailsSuccess(this.offers);
}
final class GetOfferDetailsError extends EditOfferState {
  String errorMessage;
  GetOfferDetailsError(this.errorMessage);
}

final class GetProductDetailsLoading extends EditOfferState {}
final class GetProductDetailsSuccess extends EditOfferState {
  List<ProductModel> products ;
  GetProductDetailsSuccess(this.products);
}
final class GetProductDetailsError extends EditOfferState {
  String errorMessage;
  GetProductDetailsError(this.errorMessage);
}





final class DeleteOfferLoading extends EditOfferState {}
final class DeleteOfferSuccess extends EditOfferState {
  List<OfferModel> offers ;
  DeleteOfferSuccess(this.offers);
}
final class DeleteOfferError extends EditOfferState {
  String errorMessage;
  DeleteOfferError(this.errorMessage);
}
