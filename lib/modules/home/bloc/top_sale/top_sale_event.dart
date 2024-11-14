part of 'top_sale_bloc.dart';

sealed class TopSaleEvent {
  const TopSaleEvent();
}

final class GetTopSale extends TopSaleEvent {
  const GetTopSale();
}
