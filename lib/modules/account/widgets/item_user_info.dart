part of '../index.dart';

final class ItemUserInfo extends StatelessWidget {
  const ItemUserInfo({
    super.key,
    required this.title,
    required this.content,
    this.isStart = false,
  });

  final String title;
  final String content;
  final bool isStart;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isStart ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: context.text.labelMedium,
        ),
        const SizedBox(height: 5),
        Text(
          content,
          style: context.text.titleMedium,
        ),
      ],
    );
  }
}
