part of 'other_promotion_bloc.dart';

sealed class OtherPromotionState {
  final Progress status;
  final List<HeaderListItems<DataHangMuc>> promotions;

  const OtherPromotionState({required this.status, required this.promotions});
}

final class OtherPromotionInitial extends OtherPromotionState {
  const OtherPromotionInitial() : super(status: Progress.initial, promotions: const []);
}

final class OtherPromotionLoading extends OtherPromotionState {
  const OtherPromotionLoading() : super(status: Progress.loading, promotions: const []);
}

final class OtherPromotionLoaded extends OtherPromotionState {
  const OtherPromotionLoaded({required super.promotions}) : super(status: Progress.loaded);
}

final class OtherPromotionError extends OtherPromotionState {
  const OtherPromotionError() : super(status: Progress.error, promotions: const []);
}
