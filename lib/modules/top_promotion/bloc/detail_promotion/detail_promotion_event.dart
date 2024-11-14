part of 'detail_promotion_bloc.dart';

sealed class DetailPromotionEvent {
  const DetailPromotionEvent();
}

final class GetDetailPromotion extends DetailPromotionEvent {
  final ParamDetailPromotion param;

  const GetDetailPromotion({required this.param});
}
