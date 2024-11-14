part of 'top_sale_bloc.dart';

sealed class TopSaleState {
  final Progress status;
  final List<DataHangMuc> data;

  const TopSaleState({required this.status, required this.data});
}

final class TopSaleInitial extends TopSaleState {
  const TopSaleInitial() : super(status: Progress.initial, data: const <DataHangMuc>[]);
}

final class TopSaleLoading extends TopSaleState {
  const TopSaleLoading() : super(status: Progress.loading, data: const <DataHangMuc>[]);
}

final class TopSaleLoaded extends TopSaleState {
  const TopSaleLoaded({required super.data}) : super(status: Progress.loaded);
}

final class TopSaleError extends TopSaleState {
  const TopSaleError() : super(status: Progress.error, data: const <DataHangMuc>[]);
}
