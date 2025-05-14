import 'dart:developer';
import 'dart:typed_data';

import 'package:admin_dash_board/core/models/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../api_services/api_services.dart';
import '../../../models/offer_model.dart';

part 'edit_offer_state.dart';

class EditOfferCubit extends Cubit<EditOfferState> {
  EditOfferCubit() : super(EditOfferInitial());


  final ApiServices _api = ApiServices();

  Future<void> EditOffer({required OfferModel offer ,required List<ProductModel> selected_products}) async {
    emit(EditOfferLoading());

    print({
      "image_url": offer.imageUrl,
      "name": offer.name,
      "delete_image_url": offer.delete_image_url,

    });

    try {
      await _api.patchData(
        path: 'offers_taple?&id=eq.${offer.id}',
        data: {
          "image_url": offer.imageUrl,
          "name": offer.name,
          "delete_image_url": offer.delete_image_url,
        },
      );

      for(var item in standardProductModelList){
        if(item.offer_id==offer.id){
          await _api.patchData(

            path: 'products_table?product_id=eq.${item.productId}',
            data: {
              "offer_id":null
            },
          );
        }
      }

      for(var item in selected_products){
        await _api.patchData(

          path: 'products_table?product_id=eq.${item.productId}',
          data: {
            "offer_id":offer.id
          },
        );
      }
      await getOffersDetails();
      emit(EditOfferSuccess());
    } on DioException catch (e) {
      emit(EditOfferError(e.toString()));
    }
  }

   String? path;
   String? delete_path;


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
    }
      on DioException catch (e) {
      emit(UploadImageError(e.toString()));
    }
  }

  List<OfferModel> offersModelList = [];

  Future<void> getOffersDetails() async {
    offersModelList = [];
    emit(GetOfferDetailsLoading());
    try {
      var data = await _api.getData(
        path: 'offers_taple?select=*&is_show=eq.true&order=created_at.desc',
      );
      for (var offer in data.data) {
        offersModelList.add(OfferModel.fromJson(offer));
      }
      print(data.toString());
      emit(GetOfferDetailsSuccess(offersModelList));
    } on Exception catch (e) {
      print("++++++++++++ GetProductDataSuccess: $e");
      emit(GetOfferDetailsError(e.toString()));
    }
  }


  Future<void> deleteOffer({required OfferModel offer}) async {
    emit(DeleteOfferLoading());
    try {
      offersModelList.removeWhere(
            (element) => element.id == offer.id,
      );
      await _api.patchData(
        path: 'offers_taple?&id=eq.${offer.id}',
        data: {"is_show": false},
      );

      log("----------${offer.delete_image_url!}");

      Dio dio = Dio();
      Response response = await dio.delete(
        offer.delete_image_url ?? "",

        options: Options(
          headers: {
            "apikey": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJvbW52YXh4dnpyendrYWJldXNlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQwMDYzMTIsImV4cCI6MjA1OTU4MjMxMn0.A5gkz2lcfNZuUDc_m1wQvPu_zdAwuvPw3MslXV2SSek",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJvbW52YXh4dnpyendrYWJldXNlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQwMDYzMTIsImV4cCI6MjA1OTU4MjMxMn0.A5gkz2lcfNZuUDc_m1wQvPu_zdAwuvPw3MslXV2SSek",
          },
        ),

      );
      print("-----------$response");
      emit(GetOfferDetailsSuccess(List.from(offersModelList)));
      emit(DeleteOfferSuccess(List.from(offersModelList)));
    } on DioException catch (e) {

      log("---------$e");
      emit(DeleteOfferError(e.toString()));
    }
  }


  List<ProductModel> standardProductModelList=[];

  Future<void> getStandardProductData() async {
    log('GetProductDataLoading');
    emit(GetProductDetailsLoading());
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
      emit(GetProductDetailsSuccess(standardProductModelList));
    } on Exception catch (e) {
      log('GetProductDataError');
      print("++++++++++++ GetProductDataSuccess: $e");
      emit(GetProductDetailsError(e.toString()));
    }
  }





}
