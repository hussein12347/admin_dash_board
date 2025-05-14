import 'dart:developer';
import 'dart:typed_data';

import 'package:admin_dash_board/core/models/category_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../api_services/api_services.dart';

part 'edit_category_state.dart';

class EditCategoryCubit extends Cubit<EditCategoryState> {
  EditCategoryCubit() : super(EditCategoryInitial());


  final ApiServices _api = ApiServices();

  Future<void> EditCategory({required CategoryModel category}) async {
    emit(EditCategoryLoading());

    print({
      "image_url": category.imageUrl,
      "name": category.name,
      "delete_image_url": category.deleteImage,

    });

    try {
      await _api.patchData(
        path: 'category?&id=eq.${category.id}',
        data: {
          "image_url": category.imageUrl,
          "name": category.name,
          "delete_image_url": category.deleteImage,
        },
      );
      await getCategoryDetails();
      emit(EditCategorySuccess());
    } on Exception catch (e) {
      emit(EditCategoryError(e.toString()));
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


  Future<void> deleteCategory({required CategoryModel category}) async {
    emit(DeleteCategoryLoading());
    try {
      categoriesModelList.removeWhere(
            (element) => element.id == category.id,
      );
      await _api.patchData(
        path: 'category?&id=eq.${category.id}',
        data: {"is_show": false},
      );

      log("----------${category.deleteImage!}");

      Dio dio = Dio();
      Response response = await dio.delete(
        category.deleteImage ?? "",

        options: Options(
          headers: {
            "apikey": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJvbW52YXh4dnpyendrYWJldXNlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQwMDYzMTIsImV4cCI6MjA1OTU4MjMxMn0.A5gkz2lcfNZuUDc_m1wQvPu_zdAwuvPw3MslXV2SSek",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJvbW52YXh4dnpyendrYWJldXNlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQwMDYzMTIsImV4cCI6MjA1OTU4MjMxMn0.A5gkz2lcfNZuUDc_m1wQvPu_zdAwuvPw3MslXV2SSek",
          },
        ),

      );
      print("-----------$response");
      emit(GetCategoryDetailsSuccess(List.from(categoriesModelList)));
      emit(DeleteCategorySuccess(List.from(categoriesModelList)));
    } on DioException catch (e) {

      log("---------$e");
      emit(DeleteCategoryError(e.toString()));
    }
  }







}
