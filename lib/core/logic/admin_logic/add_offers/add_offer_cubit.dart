import 'dart:developer';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../api_services/api_services.dart';
import '../../../models/product_model.dart';

part 'add_offer_state.dart';

class AddOfferCubit extends Cubit<AddOfferState> {
  AddOfferCubit() : super(AddOfferInitial());

  final ApiServices _api =ApiServices();

  Future<void> addOffer({required String imageUrl,required String delete_image_url,required String offerName, required List<ProductModel>products}) async {
    emit(AddOfferLoading());
    try {
      await _api.postData(
        path: 'offers_taple',
        data: {
          "image_url": imageUrl,
          "delete_image_url": delete_image_url,
          "name": offerName,
        },
      );
       Response data = await _api.getData(path: 'offers_taple?select=*&is_show=eq.true&order=created_at.desc');
      for (var item in  products)   {
        log("----------${item.productId}");
        log("----------"+data.data[0]['id']);
        await _api.patchData(

          path: 'products_table?product_id=eq.${item.productId}',
          data: {
            "offer_id":data.data[0]['id']
          },
        );
      }

      emit(AddOfferSuccess());
    } on Exception catch (e) {
      emit(AddOfferError(e.toString()));
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


  List<ProductModel> standardProductModelList=[];

  Future<void> getStandardProductData() async {
    log('GetProductDataLoading');
    emit(GetProductDataLoading());
    try {
      standardProductModelList=[];
      var data= await _api.getData(
          path:
          'products_table?select=*&is_show=eq.true&order=created_at.desc');
      for(var product in data.data ){
        log(product.toString());
        standardProductModelList.add(ProductModel.fromJson(product));
      }
      print(data.toString());
      log('GetProductDataSuccess');
      emit(GetProductDataSuccess(standardProductModelList));
    } on Exception catch (e) {
      log('GetProductDataError');
      print("++++++++++++ GetProductDataSuccess: $e");
      emit(GetProductDataError(e.toString()));
    }
  }
}



