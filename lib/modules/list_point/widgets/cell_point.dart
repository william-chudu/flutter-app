part of '../index.dart';

final class CellPoint extends StatelessWidget {
  const CellPoint({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: context.text.titleMedium?.fontSize),
      ),
    );
  }
}

final class CellPointPadding extends StatelessWidget {
  const CellPointPadding({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: context.text.titleMedium?.fontSize),
        ),
      ),
    );
  }
}
