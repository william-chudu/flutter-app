part of '../index.dart';

final class HotelProperty extends StatelessWidget {
  const HotelProperty({
    super.key,
    required this.label,
    required this.content,
    required this.seemore,
    required this.onTap,
  });

  final String label;
  final String content;
  final String seemore;
  final void Function(String label) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleProperty(label: label),
          Html(
            data: Utils.string.subHtml(content),
            style: {
              '*': Style(fontSize: FontSize(16), padding: HtmlPaddings.zero, margin: Margins.zero),
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  onTap(label);
                },
                child: Text(
                  seemore,
                  style: const TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
            ],
          ),
          const Divider(height: 40),
        ],
      ),
    );
  }
}
