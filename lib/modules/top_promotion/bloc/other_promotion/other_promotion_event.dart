part of 'other_promotion_bloc.dart';

sealed class OtherPromotionEvent {
  const OtherPromotionEvent();
}

final class GetOtherPromotion extends OtherPromotionEvent {
  const GetOtherPromotion();
}
