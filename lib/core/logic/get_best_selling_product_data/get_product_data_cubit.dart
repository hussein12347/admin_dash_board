// import 'package:bloc/bloc.dart';
//
// import 'package:meta/meta.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// import '../../api_services/api_services.dart';
// import '../../models/product_model.dart';
//
// part 'get_product_data_state.dart';
//
// class GetProductDataCubit extends Cubit<GetProductDataState> {
//   GetProductDataCubit() : super(GetProductDataInitial());
//   final ApiServices _api = ApiServices();
//    List<ProductModel> bestSellingProductModelList=[];
//   Future<void> getBestSellingProductData() async {
//     bestSellingProductModelList=[];
//     emit(GetProductDataLoading());
//     try {
//      var data= await _api.getData(
//           path:
//               'products_table?select=*,favorite_products(*)&order=bought_times.desc');
//      for(var product in data.data ){
//        bestSellingProductModelList.add(ProductModel.fromJson(product,Supabase.instance.client.auth.currentUser!.id));
//      }
//      print(data.toString());
//      emit(GetProductDataSuccess(bestSellingProductModelList));
//     } on Exception catch (e) {
//       print("++++++++++++ GetProductDataSuccess: $e");
//       emit(GetProductDataError(e.toString()));
//     }
//   }
//
//
//
// }
