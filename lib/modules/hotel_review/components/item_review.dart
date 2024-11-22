part of '../index.dart';

final class ItemReview extends StatelessWidget {
  const ItemReview({
    super.key,
    required this.review,
    required this.paddingTop,
    required this.onTap,
    required this.label,
  });

  final ReviewContent review;
  final double paddingTop;
  final void Function(BuildContext context, List<HotelImage> photos, double top, int index) onTap;
  final LanguageLabel label;

  @override
  Widget build(BuildContext context) {
    final faci = review.jsonFaci();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(review.reviewedBy, style: context.text.titleMedium),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: review.snippetReviewRating.toString(), style: context.text.titleMedium),
                  TextSpan(
                    text: '/10',
                    style: context.text.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Utils.time.format(date: review.addDate, oF: TimeType.dMY),
              style: context.text.titleMedium?.copyWith(letterSpacing: 1),
            ),
            StarRating(star: review.rating, size: 18),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          review.titleVn,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.green[700],
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          review.contentVn,
          style: TextStyle(fontSize: context.text.titleMedium?.fontSize),
        ),
        const SizedBox(height: 10),
        DetailReviewScore(
          color: Colors.green,
          label: label,
          worthy: faci[label.worthTheMoney.toLowerCase()].toString(),
          food: faci[label.food.toLowerCase()].toString(),
          staff: faci[label.staff.toLowerCase()].toString(),
          room: faci[label.room.toLowerCase()].toString(),
          cleaness: faci[label.cleaness.toLowerCase()].toString(),
          location: faci[label.location.toLowerCase()].toString(),
        ),
        PhotoSlider(
          radius: 0,
          borderThickness: 3,
          photos: review.photos,
          onTapPhoto: (index, [isJump = false]) {
            onTap(context, review.photos, paddingTop, index);
          },
        ),
        const Divider(height: 40),
      ],
    );
  }
}
