import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:meta/meta.dart';

import '../../../api_services/api_services.dart';
import '../../../models/comment_model.dart';

part 'get_rate_state.dart';

class GetCommentsCubit extends Cubit<GetCommentsState> {
  GetCommentsCubit() : super(GetCommentsInitial());
  final ApiServices _api = ApiServices();



List<CommentModel>comments=[];
Future<void> getComments({required String product_id})async{
  comments=[];
  emit(GetCommentsLoading());
  
  try {
    Response response =await _api.getData(path: 'comments_table?select=*&for_product=eq.$product_id&order=created_at.desc');

    for(var item in response.data){
      comments.add(CommentModel.fromJson(item));
    }
    emit(GetCommentsSuccess(comments: comments));
  }catch (e) {
    log(e.toString());
    emit(GetCommentsError());
  }



}




  Future<void> addReplies({
    required String comment_id,
    required String replay,
  }) async {
    emit(AddRepliesLoading());
    try {
      await _api.patchData(
        path: 'comments_table?id=eq.$comment_id',
        data: {

          "replay": replay,
        },
      );
      emit(AddRepliesSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddRepliesError());
    }
  }
}
