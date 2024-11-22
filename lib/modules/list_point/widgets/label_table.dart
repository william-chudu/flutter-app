part of '../index.dart';

final class LabelTable extends StatelessWidget {
  const LabelTable({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: context.text.titleMedium,
          ),
        ),
      ),
    );
  }
}
