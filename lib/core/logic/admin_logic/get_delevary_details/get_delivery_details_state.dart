part of 'get_delivery_details_cubit.dart';

@immutable
sealed class GetDeliveryDetailsState {}

final class GetDeliveryDetailsInitial extends GetDeliveryDetailsState {}

final class GetDeliveryDetailsLoading extends GetDeliveryDetailsState {}
final class GetDeliveryDetailsSuccess extends GetDeliveryDetailsState {
  List<CartModel > cartModel;
  GetDeliveryDetailsSuccess(this.cartModel);
}
final class GetDeliveryDetailsError extends GetDeliveryDetailsState {
  String messageError;
  GetDeliveryDetailsError(this.messageError);
}
