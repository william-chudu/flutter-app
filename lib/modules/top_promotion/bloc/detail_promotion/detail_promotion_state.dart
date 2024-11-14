part of 'detail_promotion_bloc.dart';

sealed class DetailPromotionState {
  final Progress status;
  final List<DetailPromotion> promotions;

  const DetailPromotionState({required this.status, required this.promotions});
}

final class DetailPromotionInitial extends DetailPromotionState {
  const DetailPromotionInitial() : super(status: Progress.initial, promotions: const []);
}

final class DetailPromotionLoading extends DetailPromotionState {
  const DetailPromotionLoading() : super(status: Progress.loading, promotions: const []);
}

final class DetailPromotionLoaded extends DetailPromotionState {
  const DetailPromotionLoaded({required super.promotions}) : super(status: Progress.loaded);
}

final class DetailPromotionError extends DetailPromotionState {
  const DetailPromotionError() : super(status: Progress.error, promotions: const []);
}
