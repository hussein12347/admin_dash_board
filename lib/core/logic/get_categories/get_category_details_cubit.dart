// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
//
// import '../../api_services/api_services.dart';
// import '../../models/category_model.dart';
//
// part 'get_category_details_state.dart';
//
// class GetCategoryDetailsCubit extends Cubit<GetCategoryDetailsState> {
//   GetCategoryDetailsCubit() : super(GetCategoryDetailsInitial());
//
//   final ApiServices _api = ApiServices();
//   List<CategoryModel> categoriesModelList=[];
//   Future<void> getCategoryDetails() async {
//     categoriesModelList=[];
//     emit(GetCategoryDetailsLoading());
//     try {
//       var data= await _api.getData(
//           path:
//           'category?select=*&order=created_at.desc');
//       for(var category in data.data ){
//         categoriesModelList.add(CategoryModel.fromJson(category,));
//       }
//       print(data.toString());
//       emit(GetCategoryDetailsSuccess(categoriesModelList));
//     } on Exception catch (e) {
//       print("++++++++++++ GetProductDataSuccess: $e");
//       emit(GetCategoryDetailsError(e.toString()));
//     }
//   }
// }
