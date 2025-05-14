import 'dart:developer';
import 'dart:typed_data';

import 'package:admin_dash_board/core/api_services/api_services.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'add_categories_state.dart';

class AddCategoriesCubit extends Cubit<AddCategoriesState> {
  AddCategoriesCubit() : super(AddCategoriesInitial());

  final ApiServices _api =ApiServices();

  Future<void> addCategory({required String imageUrl,required String deleteImageUrl,required String name,}) async {
    emit(AddCategoriesLoading());
    try {
      await _api.postData(
        path: 'category',
        data: {
          "image_url": imageUrl,
          "delete_image_url": deleteImageUrl,
          "name": name,

        },
      );
      emit(AddCategoriesSuccess());
    } on Exception catch (e) {
      emit(AddCategoriesError(e.toString()));
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


}
