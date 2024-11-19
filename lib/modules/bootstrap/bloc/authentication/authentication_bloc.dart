import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/modules/bootstrap/models/param_sign_in.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationInitial()) {
    on<InitializeAuthentication>((
      InitializeAuthentication event,
      Emitter<AuthenticationState> emit,
    ) async {
      try {
        emit(const AuthenticationLoading());
        await Future.delayed(const Duration(seconds: 0));
        emit(const AuthenticationLoaded(user: null));
      } on Exception catch (e) {
        e.pError();
        emit(const AuthenticationError());
      }
    });

    on<SignInEvent>((SignInEvent event, Emitter<AuthenticationState> emit) async {
      try {
        emit(const AuthenticationLoading());
        await Future.delayed(const Duration(seconds: 0));
        final param = await event.param.toJson();
        print(jsonEncode(param));
        return;
        final data = await ApiClient.shared.mPost(UrlPath.shared.signIn, param);
        if (data.statusCode != 200) {
          emit(const AuthenticationError());
          return;
        }
        final json = jsonDecode(data.body);

        if (ApiClient.isNotOk(json['error'])) {
          emit(const AuthenticationError());
          return;
        }
      } on Exception catch (e) {
        e.pError();
        emit(const AuthenticationError());
      }
    });
  }
}
