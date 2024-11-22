part of '../index.dart';

final class InfoHotel extends StatelessWidget {
  const InfoHotel({super.key, required this.room, required this.label});

  final RoomRateInfo room;
  final LanguageLabel label;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width / 5;
    final height = width + 20;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 3),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: ImageBuilder(
              room.thumbnail.imgUrl,
              width: width,
              height: height,
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      room.hotelName,
                      style: context.text.titleMedium?.copyWith(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.delete, color: Colors.red),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                room.address,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  StarRating(star: int.tryParse(room.star) ?? 0),
                  const Spacer(),
                  const Icon(
                    Icons.thumb_up,
                    size: 14,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${room.reviews} ${label.review}',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
