import 'dart:developer';

import 'package:admin_dash_board/core/api_services/api_services.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'update_chart_status_state.dart';

class EditChartStatusCubit extends Cubit<EditChartStatusState> {
  EditChartStatusCubit() : super(UpdateChartStatusInitial());

  final _api=ApiServices();

  Future updateStatus(String orderId,int status) async{
    emit(UpdateChartStatusLoading());

    try{

      Response response = await _api.patchData(path: 'order_table?&id=eq.$orderId', data: {
        "status":status
      });
      log('Response Status Code: ${response.statusCode}');
      log('Response Data: ${response.data}');


      emit(UpdateChartStatusSuccess());
    }catch (e){
      emit(UpdateChartStatusError(e.toString()));
    }
  }
}
