// import 'package:bloc/bloc.dart';
//
// import 'package:meta/meta.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// import '../../api_services/api_services.dart';
// import '../../models/delivery_model.dart';
//
// part 'get_delivery_details_state.dart';
//
// class GetDeliveryDetailsCubit extends Cubit<GetDeliveryDetailsState> {
//   GetDeliveryDetailsCubit() : super(GetDeliveryDetailsInitial());
//
//   final ApiServices _api = ApiServices();
//   List<DeliveryModel> deliveryList = [];
//
//   Future<void> getGetDeliveryDetails() async {
//     emit(GetDeliveryDetailsLoading());
//     try {
//       var response = await _api.getData(
//         path:
//         'order_table?user_id=eq.${Supabase.instance.client.auth.currentUser!.id}&select=*&order=created_at.desc',
//       );
//
//       // تأكد إنك فعلاً جبت List من الـ Map
//       final dataList = response.data as List;
//
//       deliveryList = dataList
//           .map((item) => DeliveryModel.fromMap(item))
//           .toList();
//
//       emit(GetDeliveryDetailsSuccess(deliveryList));
//     } catch (e) {
//       emit(GetDeliveryDetailsError(e.toString()));
//     }
//   }
//
// }
