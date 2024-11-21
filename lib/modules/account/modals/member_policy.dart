part of '../index.dart';

final class MemberPolicy extends StatelessWidget {
  static void showModal(BuildContext context) {
    showBottomSheet(
      context: context,
      shape: Border.all(color: Colors.transparent),
      builder: (_) {
        return BlocProvider(
          create: (context) => MemberPolicyBloc()..add(const GetMemberPolicy()),
          child: const MemberPolicy(),
        );
      },
    );
  }

  const MemberPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberPolicyBloc, MemberPolicyState>(
      builder: (context, state) {
        return Utils.w(state.status) ??
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: HtmlBox(content: state.policy),
            );
      },
    );
  }
}
