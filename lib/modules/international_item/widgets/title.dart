part of '../index.dart';

final class Title extends StatelessWidget {
  const Title({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.text.titleMedium?.copyWith(color: Colors.green),
    );
  }
}
