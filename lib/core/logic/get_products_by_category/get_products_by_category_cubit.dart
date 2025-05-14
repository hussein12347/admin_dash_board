// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// import '../../api_services/api_services.dart';
// import '../../models/product_model.dart';
//
// part 'get_products_by_category_state.dart';
//
// class GetProductsByCategoryCubit extends Cubit<GetProductsByCategoryState> {
//   GetProductsByCategoryCubit() : super(GetProductsByCategoryInitial());
//
//   final ApiServices _api = ApiServices();
//
//   List<ProductModel> categoryProductModelList=[];
//
//   Future<void> getStandardProductData({required String category_id}) async {
//     emit(GetProductsByCategoryLoading());
//     try {
//       categoryProductModelList=[];
//       var data= await _api.getData(
//           path:
//           'products_table?select=*,favorite_products(*)&order=created_at.desc&category_id=eq.${category_id}');
//       for(var product in data.data ){
//         categoryProductModelList.add(ProductModel.fromJson(product,Supabase.instance.client.auth.currentUser!.id));
//       }
//       print(data.toString());
//       emit(GetProductsByCategorySuccess(categoryProductModelList));
//     } on Exception catch (e) {
//       print("++++++++++++ GetProductsByCategorySuccess: $e");
//       emit(GetProductsByCategoryError(e.toString()));
//     }
//   }
// }
