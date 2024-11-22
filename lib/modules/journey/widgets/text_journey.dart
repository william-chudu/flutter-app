part of '../index.dart';

final class TextJourney extends StatelessWidget {
  const TextJourney({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.text.labelSmall?.copyWith(color: Colors.white),
    );
  }
}
