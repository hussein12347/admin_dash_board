import 'dart:developer';
import 'dart:typed_data';

import 'package:admin_dash_board/core/api_services/api_services.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../models/category_model.dart';
import '../../../models/product_model.dart';

part 'add_products_state.dart';

class AddProductsCubit extends Cubit<AddProductsState> {
  AddProductsCubit() : super(AddProductsInitial());
  final ApiServices _api = ApiServices();

  Future<void> addProduct({required ProductModel product}) async {
    emit(AddProductsLoading());

    print({
      "image_url": product.imageUrl,
      "delete_image_url": product.delete_image_url,
      "product_name": product.productName,
      "price": product.price,
      "available_quantity": product.available_quantity,
      "bought_times": product.boughtTimes,
      "description": product.description,
      "old_price": product.oldPrice,
      "category_id": product.category_id,
    });


    try {
      await _api.postData(
        path: 'products_table',
        data: {
          "image_url": product.imageUrl,
          "delete_image_url": product.delete_image_url,
          "product_name": product.productName,
          "price": product.price,
          "available_quantity": product.available_quantity,
          "bought_times": product.boughtTimes,
          "description": product.description,
          "old_price": product.oldPrice,
          "category_id": product.category_id,
        },
      );
      emit(AddProductsSuccess());
    } on Exception catch (e) {
      emit(AddProductsError(e.toString()));
    }
  }

  Future<void> uploadImage({
    required Uint8List image,
    required String imageName,
    required String bucketName,
  }) async {
    emit(UploadImageLoading());
    const String storageBaseUrl =
        'https://bomnvaxxvzrzwkabeuse.supabase.co/storage/v1/object';
    const String apiKey =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJvbW52YXh4dnpyendrYWJldXNlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQwMDYzMTIsImV4cCI6MjA1OTU4MjMxMn0.A5gkz2lcfNZuUDc_m1wQvPu_zdAwuvPw3MslXV2SSek';
    final String uploadUrl = "$storageBaseUrl/$bucketName/$imageName";
    final dio = Dio();
    try {
      Response response = await dio.post(
        data: FormData.fromMap({
          "file": MultipartFile.fromBytes(image, filename: imageName),
        }),
        uploadUrl,
        options: Options(
          headers: {
            "apikey": apiKey,
            "authorization": apiKey,
            "Content-Type": 'multipart/form-data',
          },
        ),
      );
      log(response.data["Key"]);

      emit(UploadImageSuccess('$storageBaseUrl/public/'+response.data["Key"],'$storageBaseUrl/'+response.data["Key"]));
    } catch (e) {
      emit(UploadImageError(e.toString()));
    }
  }



  List<CategoryModel> categoriesModelList=[];
  Future<void> getCategoryDetails() async {
    emit(GetCategoryDetailsLoading());
    categoriesModelList=[];
    try {
      var data= await _api.getData(
          path:
          'category?select=*&is_show=eq.true&order=created_at.desc');
      for(var category in data.data ){
        categoriesModelList.add(CategoryModel.fromJson(category,));
      }
      print(data.toString());
      emit(GetCategoryDetailsSuccess(categoriesModelList));
    } on Exception catch (e) {
      print("++++++++++++ GetProductDataSuccess: $e");
      emit(GetCategoryDetailsError(e.toString()));
    }
  }
}
