import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../api_services/api_services.dart';
import '../../models/product_model.dart';

part 'product_search_state.dart';

class ProductSearchCubit extends Cubit<ProductSearchState> {
  ProductSearchCubit() : super(ProductSearchInitial());

  final ApiServices _api = ApiServices();

  List<ProductModel> standardProductModelList=[];

  Future<void> getStandardProductData({required String search_query}) async {
    emit(ProductSearchLoading());
    try {
      standardProductModelList=[];
      var data= await _api.getData(
          path:
          'products_table?select=*,favorite_products(*)&is_show=eq.true&order=created_at.desc&product_name=ilike.*$search_query*&description=ilike.*$search_query*');
      for(var product in data.data ){
        standardProductModelList.add(ProductModel.fromJson(product,));
      }
      print(data.toString());
      emit(ProductSearchSuccess(standardProductModelList));
    } on Exception catch (e) {
      print("++++++++++++ GetProductDataSuccess: $e");
      emit(ProductSearchError(e.toString()));
    }
  }
}
