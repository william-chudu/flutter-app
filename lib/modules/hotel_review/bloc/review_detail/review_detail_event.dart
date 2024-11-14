part of 'review_detail_bloc.dart';

sealed class ReviewDetailEvent {
  const ReviewDetailEvent();
}

final class GetAllReviews extends ReviewDetailEvent {
  final int hotelIdInt;
  const GetAllReviews(this.hotelIdInt);
}
