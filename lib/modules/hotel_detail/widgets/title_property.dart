part of '../index.dart';

class TitleProperty extends StatelessWidget {
  const TitleProperty({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18),
    );
  }
}
