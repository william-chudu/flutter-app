part of '../index.dart';

final class ItemJourney extends StatelessWidget {
  const ItemJourney({
    super.key,
    required this.item,
    required this.label,
  });

  final JourneyItem item;
  final LanguageLabel label;

  @override
  Widget build(BuildContext context) {
    final checkIn = Utils.time.format(date: item.travelfromdate, oF: TimeType.edmy);
    final checkOut = Utils.time.format(date: item.traveltodate, oF: TimeType.edmy);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            item.hotelnames,
            style: context.text.titleMedium,
          ),
        ),
        const Divider(height: 2, thickness: 2, color: Colors.white),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextJourney(title: label.bookingCode),
                  TextJourney(title: item.reservationnumber),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextJourney(title: label.checkIn),
                  TextJourney(title: checkIn),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextJourney(title: label.checkOut),
                  TextJourney(title: checkOut),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                label.seemore,
                style: context.text.headlineSmall?.copyWith(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
  }
}
