part of 'promotion_banner_bloc.dart';

sealed class PromotionBannerEvent {
  const PromotionBannerEvent();
}

final class GetPromotionBanner extends PromotionBannerEvent {
  const GetPromotionBanner();
}
