part of '../index.dart';

class TitleProperty extends StatelessWidget {
  const TitleProperty({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: context.text.titleLarge?.copyWith(color: Colors.blue),
    );
  }
}
