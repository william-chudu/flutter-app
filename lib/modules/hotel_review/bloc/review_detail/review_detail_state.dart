part of 'review_detail_bloc.dart';

sealed class ReviewDetailState {
  final Progress status;
  final List<HotelInfoDetail> info;
  final List<HotelImage> images;
  final List<ReviewContent> reviews;
  final bool isLastPage;

  const ReviewDetailState({
    required this.status,
    required this.info,
    required this.images,
    required this.reviews,
    required this.isLastPage,
  });
}

final class ReviewDetailInitial extends ReviewDetailState {
  const ReviewDetailInitial()
      : super(
          images: const [],
          info: const [],
          reviews: const [],
          isLastPage: false,
          status: Progress.initial,
        );
}

final class ReviewDetailLoading extends ReviewDetailState {
  const ReviewDetailLoading()
      : super(
          images: const [],
          info: const [],
          reviews: const [],
          isLastPage: false,
          status: Progress.loading,
        );
}

final class ReviewDetailLoaded extends ReviewDetailState {
  const ReviewDetailLoaded({
    required super.images,
    required super.info,
    required super.reviews,
    required super.isLastPage,
  }) : super(status: Progress.loaded);
}

final class ReviewDetailError extends ReviewDetailState {
  const ReviewDetailError()
      : super(
          images: const [],
          info: const [],
          reviews: const [],
          isLastPage: false,
          status: Progress.error,
        );
}
