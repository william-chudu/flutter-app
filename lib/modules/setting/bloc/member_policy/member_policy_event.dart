part of 'member_policy_bloc.dart';

sealed class MemberPolicyEvent {
  const MemberPolicyEvent();
}

final class GetMemberPolicy extends MemberPolicyEvent {
  const GetMemberPolicy();
}
