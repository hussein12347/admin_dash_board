part of 'send_notification_cubit.dart';

@immutable
sealed class SendNotificationState {}

final class SendNotificationInitial extends SendNotificationState {}

final class SendNotificationLoading extends SendNotificationState {}
final class SendNotificationSuccess extends SendNotificationState {}
final class SendNotificationError extends SendNotificationState {}
