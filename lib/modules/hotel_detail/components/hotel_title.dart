part of '../index.dart';

class HotelTitle extends StatelessWidget {
  const HotelTitle({super.key, required this.hotel});

  final HotelInfoDetail hotel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[50],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              hotel.hotelname,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              hotel.address1,
              style: TextStyle(fontSize: context.text.titleMedium?.fontSize),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            StarRating(star: int.tryParse(hotel.starrating) ?? 0, size: 20),
            const SizedBox(height: 5),
            HotelListTags(
              fontSize: 12,
              crossAxisAlignment: CrossAxisAlignment.center,
              isColumn: false,
              tags: hotel.hotelTags,
            ),
          ],
        ),
      ),
    );
  }
}
