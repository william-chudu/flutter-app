part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

final class InitializeAuthentication extends AuthenticationEvent {
  const InitializeAuthentication();
}

final class SignInEvent extends AuthenticationEvent {
  final ParamLogin param;

  const SignInEvent({required this.param});
}
