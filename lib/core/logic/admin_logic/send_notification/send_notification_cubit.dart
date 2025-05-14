import 'dart:developer';

import 'package:admin_dash_board/core/api_services/api_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../notification_helper/notifications_helper.dart';

part 'send_notification_state.dart';

class SendNotificationCubit extends Cubit<SendNotificationState> {
  SendNotificationCubit() : super(SendNotificationInitial());
  final ApiServices _api = ApiServices();

  Future<void> sendNotification({
    required String title,
    required String object,
  }) async {
    emit(SendNotificationLoading());

    try {
      await _api.postData(
        path: 'notification',
        data: {"tittle": title, "object": object},
      );
      await NotificationService.sendNotificationToAllUsers(title, object);
      emit(SendNotificationSuccess());
    }   catch (e) {
      // TODO
      log(e.toString());
    }
  }
}
