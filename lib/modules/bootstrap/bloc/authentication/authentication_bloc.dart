import 'dart:convert';

import 'package:chudu24/constants/user_duy.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/models/authenticated_user.dart';
import 'package:chudu24/modules/bootstrap/models/param_sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationInitial(user: null)) {
    const key = 'USER';
    on<InitializeAuthentication>((
      InitializeAuthentication event,
      Emitter<AuthenticationState> emit,
    ) async {
      try {
        emit(const AuthenticationLoading());
        await Future.delayed(const Duration(seconds: 0));

        final box = await Hive.openBox<AuthenticatedUser>(ConstantType.authenticatedUser.first);
        final user = box.get(key);

        emit(AuthenticationInitial(user: user));
        await box.close();
      } on Exception catch (e) {
        e.pError();
        emit(const AuthenticationError());
      }
    });

    on<SignInEvent>((SignInEvent event, Emitter<AuthenticationState> emit) async {
      try {
        emit(const AuthenticationLoading());
        await Future.delayed(const Duration(seconds: 0));
        // final param = await event.param.toJson();
        // final data = await ApiClient.shared.mPost(UrlPath.shared.signIn, param);
        final data = UserDuy.shared.apin;
        final json = jsonDecode(data);

        if (json['code'] != 500000) {
          emit(const AuthenticationError());
          return;
        }
        await Future.delayed(const Duration(seconds: 2));
        final user = AuthenticatedUser.fromJson(json['data']);
        final box = await Hive.openBox<AuthenticatedUser>(ConstantType.authenticatedUser.first);
        await box.put(key, user);
        emit(AuthenticationLoaded(user: user));
        await box.close();
      } on Exception catch (e) {
        e.pError();
        emit(const AuthenticationError());
      }
    });

    on<SignOutEvent>((SignOutEvent event, Emitter<AuthenticationState> emit) async {
      final box = await Hive.openBox<AuthenticatedUser>(ConstantType.authenticatedUser.first);
      await box.clear();
      emit(const AuthenticationSignOut());
      await box.close();
    });
  }
}
