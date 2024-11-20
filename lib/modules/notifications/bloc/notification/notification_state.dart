part of 'notification_bloc.dart';

sealed class NotificationState {
  final Progress status;
  final List<NotificationModel> notis;

  const NotificationState({required this.status, required this.notis});
}

final class NotificationInitial extends NotificationState {
  const NotificationInitial() : super(notis: const [], status: Progress.initial);
}

final class NotificationLoading extends NotificationState {
  const NotificationLoading() : super(notis: const [], status: Progress.loading);
}

final class NotificationLoaded extends NotificationState {
  const NotificationLoaded({required super.notis}) : super(status: Progress.loaded);
}

final class NotificationError extends NotificationState {
  const NotificationError() : super(notis: const [], status: Progress.error);
}
