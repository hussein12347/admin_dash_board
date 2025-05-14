import 'dart:developer';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../api_services/api_services.dart';
import '../../../models/category_model.dart';
import '../../../models/product_model.dart';

part 'edit_product_state.dart';

class EditProductCubit extends Cubit<EditProductState> {
  EditProductCubit() : super(EditProductInitial());

  final ApiServices _api = ApiServices();

  Future<void> EditProduct({required ProductModel product}) async {
    emit(EditProductsLoading());

    print({
      "image_url": product.imageUrl,
      "product_name": product.productName,
      "price": product.price,
      "available_quantity": product.available_quantity,
      "bought_times": product.boughtTimes,
      "description": product.description,
      "old_price": product.oldPrice,
      "category_id": product.category_id,
    });

    try {
      await _api.patchData(
        path: 'products_table?&product_id=eq.${product.productId}',
        data: {
          "image_url": product.imageUrl,
          "product_name": product.productName,
          "price": product.price,
          "available_quantity": product.available_quantity,
          "bought_times": product.boughtTimes,
          "description": product.description,
          "old_price": product.oldPrice,
          "category_id": product.category_id,
          "delete_image_url":product.delete_image_url
        },
      );
      await getStandardProductData();
      emit(EditProductsSuccess());
    } on Exception catch (e) {
      emit(EditProductsError(e.toString()));
    }
  }

  late String path;
  late String delete_path;


  Future<void> uploadImage({
    required Uint8List image,
    required String imageName,
    required String bucketName,
    required String delete_image_url,
  }) async {

    Dio dio = Dio();
    emit(UploadImageLoading());
    const String storageBaseUrl =
        'https://bomnvaxxvzrzwkabeuse.supabase.co/storage/v1/object';
    const String apiKey =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJvbW52YXh4dnpyendrYWJldXNlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQwMDYzMTIsImV4cCI6MjA1OTU4MjMxMn0.A5gkz2lcfNZuUDc_m1wQvPu_zdAwuvPw3MslXV2SSek';
    final String uploadUrl = "$storageBaseUrl/$bucketName/$imageName";
    final dio0 = Dio();
    try {
      Response deleteResponse = await dio.delete(
        delete_image_url ,

        options: Options(
          headers: {
            "apikey": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJvbW52YXh4dnpyendrYWJldXNlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQwMDYzMTIsImV4cCI6MjA1OTU4MjMxMn0.A5gkz2lcfNZuUDc_m1wQvPu_zdAwuvPw3MslXV2SSek",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJvbW52YXh4dnpyendrYWJldXNlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQwMDYzMTIsImV4cCI6MjA1OTU4MjMxMn0.A5gkz2lcfNZuUDc_m1wQvPu_zdAwuvPw3MslXV2SSek",
          },
        ),

      );
      log(deleteResponse.toString());
      Response response = await dio0.post(
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
      path ='$storageBaseUrl/public/'+response.data["Key"];
      delete_path = '$storageBaseUrl/'+response.data["Key"];

      emit(UploadImageSuccess('$storageBaseUrl/public/'+response.data["Key"],'$storageBaseUrl/'+response.data["Key"]));
    } catch (e) {
      emit(UploadImageError(e.toString()));
    }
  }

  List<CategoryModel> categoriesModelList = [];

  Future<void> getCategoryDetails() async {
    categoriesModelList = [];
    emit(GetCategoryDetailsLoading());
    try {
      var data = await _api.getData(
        path: 'category?select=*&is_show=eq.true&order=created_at.desc',
      );
      for (var category in data.data) {
        categoriesModelList.add(CategoryModel.fromJson(category));
      }
      print(data.toString());
      emit(GetCategoryDetailsSuccess(categoriesModelList));
    } on Exception catch (e) {
      print("++++++++++++ GetProductDataSuccess: $e");
      emit(GetCategoryDetailsError(e.toString()));
    }
  }

  List<ProductModel> standardProductModelList = [];

  Future<void> deleteProduct({required ProductModel product}) async {
    emit(DeleteProductDataLoading());
    try {
      standardProductModelList.removeWhere(
        (element) => element.productId == product.productId,
      );
      await _api.patchData(
        path: 'products_table?&product_id=eq.${product.productId}',
        data: {"is_show": false},
      );

      log(product.delete_image_url!);

      Dio dio = Dio();
       Response response = await dio.delete(
        product.delete_image_url ?? "",

         options: Options(
           headers: {
             "apikey": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJvbW52YXh4dnpyendrYWJldXNlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQwMDYzMTIsImV4cCI6MjA1OTU4MjMxMn0.A5gkz2lcfNZuUDc_m1wQvPu_zdAwuvPw3MslXV2SSek",
             "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJvbW52YXh4dnpyendrYWJldXNlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQwMDYzMTIsImV4cCI6MjA1OTU4MjMxMn0.A5gkz2lcfNZuUDc_m1wQvPu_zdAwuvPw3MslXV2SSek",
           },
         ),

      );
       print("-----------$response");
      emit(GetProductDataSuccess(List.from(standardProductModelList)));
      emit(DeleteProductDataSuccess(List.from(standardProductModelList)));
    } on Exception catch (e) {
      emit(DeleteProductDataError(e.toString()));
    }
  }

  Future<void> getStandardProductData() async {
    emit(GetProductDataLoading());
    try {
      standardProductModelList = [];
      var data = await _api.getData(
        path:
            'products_table?select=*,favorite_products(*)&order=created_at.desc&is_show=eq.true',
      );
      for (var product in data.data) {
        standardProductModelList.add(ProductModel.fromJson(product));
      }
      print(data.toString());
      emit(GetProductDataSuccess(standardProductModelList));
    } on Exception catch (e) {
      print("++++++++++++ GetProductDataSuccess: $e");
      emit(GetProductDataError(e.toString()));
    }
  }
}
