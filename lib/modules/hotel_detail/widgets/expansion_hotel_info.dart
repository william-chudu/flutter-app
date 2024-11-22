part of '../index.dart';

final class ExpansionHotelInfo extends StatelessWidget {
  const ExpansionHotelInfo({super.key, required this.label, required this.list});

  final String label;
  final List<Expansion> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 40),
          TitleProperty(label: label),
          const SizedBox(height: 10),
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: List.generate(
              list.length,
              (int ix) {
                final item = list[ix];
                final color = Colors.blueGrey[50] ?? Colors.blueGrey;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ExpansionTile(
                    shape: const Border(),
                    initiallyExpanded: false,
                    backgroundColor: color,
                    collapsedBackgroundColor: color,
                    tilePadding: const EdgeInsets.only(right: 20),
                    iconColor: AppConstants.accent,
                    minTileHeight: 0,
                    collapsedIconColor: AppConstants.accent,
                    childrenPadding: EdgeInsets.zero,
                    title: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        item.title,
                        style: context.text.labelSmall,
                      ),
                    ),
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: color, width: 2),
                          color: Colors.white,
                        ),
                        child: HtmlBox(content: item.content),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
