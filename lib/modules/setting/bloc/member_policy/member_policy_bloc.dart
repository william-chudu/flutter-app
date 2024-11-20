import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'member_policy_event.dart';
part 'member_policy_state.dart';

class MemberPolicyBloc extends Bloc<MemberPolicyEvent, MemberPolicyState> {
  MemberPolicyBloc() : super(const MemberPolicyInitial()) {
    on<GetMemberPolicy>((GetMemberPolicy event, Emitter<MemberPolicyState> emit) async {
      try {
        emit(const MemberPolicyLoading());
        await Future.delayed(const Duration(seconds: 0));
        final data = await ApiClient.shared.mPost(UrlPath.shared.policy, {'type': 'quycheTV'});
        if (data.statusCode != 200) {
          emit(const MemberPolicyError());
          return;
        }
        final json = jsonDecode(data.body);
        if (ApiClient.isNotOk(json['error'])) {
          emit(const MemberPolicyError());
          return;
        }
        final content = json['data']['quycheTV'] as String;
        emit(MemberPolicyLoaded(policy: content));
      } on Exception catch (e) {
        e.pError();
        emit(const MemberPolicyError());
      }
    });
  }
}
