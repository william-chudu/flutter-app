part of 'authentication_bloc.dart';

sealed class AuthenticationState {
  final Progress status;
  final String? user;
  const AuthenticationState({required this.status, required this.user});
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial() : super(status: Progress.initial, user: null);
}

final class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading() : super(status: Progress.loading, user: null);
}

final class AuthenticationLoaded extends AuthenticationState {
  const AuthenticationLoaded({required super.user}) : super(status: Progress.loaded);
}

final class AuthenticationError extends AuthenticationState {
  const AuthenticationError() : super(status: Progress.error, user: null);
}
