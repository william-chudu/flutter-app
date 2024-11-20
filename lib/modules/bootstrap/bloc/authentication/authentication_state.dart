part of 'authentication_bloc.dart';

sealed class AuthenticationState {
  final Progress status;
  final AuthenticatedUser? user;
  const AuthenticationState({required this.status, required this.user});
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial({required super.user}) : super(status: Progress.initial);
}

final class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading() : super(status: Progress.loading, user: null);
}

final class AuthenticationLoaded extends AuthenticationState {
  const AuthenticationLoaded({required super.user}) : super(status: Progress.loaded);
}

final class AuthenticationSignOut extends AuthenticationState {
  const AuthenticationSignOut() : super(status: Progress.error, user: null);
}

final class AuthenticationError extends AuthenticationState {
  const AuthenticationError() : super(status: Progress.error, user: null);
}
