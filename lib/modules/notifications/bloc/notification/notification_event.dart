part of 'notification_bloc.dart';

sealed class NotificationEvent {
  const NotificationEvent();
}

final class GetNotification extends NotificationEvent {
  final ParamNotification param;

  const GetNotification({required this.param});
}
