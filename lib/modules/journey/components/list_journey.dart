part of '../index.dart';

final class ListJourney extends StatelessWidget {
  const ListJourney({super.key, required this.index, required this.journey, required this.label});

  final int index;
  final List<JourneyItem> journey;
  final LanguageLabel label;

  @override
  Widget build(BuildContext context) {
    if (journey.isEmpty) {
      final str = StringBuffer(label.youHaveNoJourneyFor);
      str.write('\n');
      if (index == 0) {
        str.write(label.processing);
      } else if (index == 1) {
        str.write(label.prepareForCheckIn);
      } else {
        str.write(label.checkOut);
      }
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            str.toString(),
            textAlign: TextAlign.center,
            style: context.text.labelLarge?.copyWith(color: Colors.grey),
          ),
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: journey.length,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (ctxBuilder, ix) {
        final item = journey[ix];
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: index == 0
                    ? context.color.surfaceBright
                    : index == 1
                        ? Colors.blue
                        : Colors.green,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: ItemJourney(item: item, label: label),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: context.color.secondaryContainer,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item.soPhong} - ${item.soDem}',
                      style: context.text.titleSmall,
                    ),
                    Text(
                      item.tongGiaBan,
                      style: context.text.titleSmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
