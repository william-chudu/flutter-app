part of 'promotion_banner_bloc.dart';

sealed class PromotionBannerState {
  final Progress status;
  final List<PromotionBanner> banners;

  const PromotionBannerState({required this.status, required this.banners});
}

final class PromotionBannerInitial extends PromotionBannerState {
  const PromotionBannerInitial() : super(status: Progress.initial, banners: const []);
}

final class PromotionBannerLoading extends PromotionBannerState {
  const PromotionBannerLoading() : super(status: Progress.loading, banners: const []);
}

final class PromotionBannerLoaded extends PromotionBannerState {
  const PromotionBannerLoaded({required super.banners}) : super(status: Progress.loaded);
}

final class PromotionBannerError extends PromotionBannerState {
  const PromotionBannerError() : super(status: Progress.error, banners: const []);
}
