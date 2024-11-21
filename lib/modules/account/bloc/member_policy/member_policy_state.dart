part of 'member_policy_bloc.dart';

sealed class MemberPolicyState {
  final Progress status;
  final String policy;

  const MemberPolicyState({required this.status, required this.policy});
}

final class MemberPolicyInitial extends MemberPolicyState {
  const MemberPolicyInitial() : super(policy: '', status: Progress.initial);
}

final class MemberPolicyLoading extends MemberPolicyState {
  const MemberPolicyLoading() : super(policy: '', status: Progress.loading);
}

final class MemberPolicyLoaded extends MemberPolicyState {
  const MemberPolicyLoaded({required super.policy}) : super(status: Progress.loaded);
}

final class MemberPolicyError extends MemberPolicyState {
  const MemberPolicyError() : super(policy: '', status: Progress.error);
}
