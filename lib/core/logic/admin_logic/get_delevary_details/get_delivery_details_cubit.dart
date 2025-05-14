import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../../api_services/api_services.dart';
import '../../../models/cart_model.dart';

part 'get_delivery_details_state.dart';

class GetDeliveryDetailsCubit extends Cubit<GetDeliveryDetailsState> {
  GetDeliveryDetailsCubit() : super(GetDeliveryDetailsInitial());

  final ApiServices _api = ApiServices();
  List<CartModel> deliveryList = [];

  Future<void> getGetDeliveryDetails() async {
    emit(GetDeliveryDetailsLoading());
    try {
      var response = await _api.getData(
        path:
        'order_table?select=*,cart(*,product:products_table(*))&order=created_at.asc',
      );

      // تأكد إنك فعلاً جبت List من الـ Map
      final dataList = response.data as List;

      deliveryList = dataList
          .map((item) => CartModel.fromJson(item))
          .toList();

      log(deliveryList.toString());

      emit(GetDeliveryDetailsSuccess(deliveryList));
    } catch (e) {
      emit(GetDeliveryDetailsError(e.toString()));
    }
  }

}
