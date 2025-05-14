// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
//
// import '../../api_services/api_services.dart';
//
// part 'get_offers_state.dart';
//
// class GetOffersCubit extends Cubit<GetOffersState> {
//   GetOffersCubit() : super(GetOffersInitial());
//
//   final ApiServices _api = ApiServices();
//   List<String> imageUrls=[];
//   Future<void> getOffersData() async {
//     imageUrls=[];
//     emit(GetOffersLoading());
//     try {
//       var data= await _api.getData(
//           path:
//           'offers_taple?select=image_url&order=created_at.desc');
//       for(var image in data.data ){
//         imageUrls.add(image['image_url']);
//       }
//       print(data.toString());
//       emit(GetOffersSuccess(imageUrls));
//     } on Exception catch (e) {
//       print("++++++++++++ GetOffersDataSuccess: $e");
//       emit(GetOffersError(e.toString()));
//     }
//   }
// }
