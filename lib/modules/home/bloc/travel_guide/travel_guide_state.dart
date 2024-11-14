part of 'travel_guide_bloc.dart';

sealed class TravelGuideState {
  final Progress status;
  final List<TravelGuideInfo> guides;

  const TravelGuideState({required this.status, required this.guides});
}

final class TravelGuideInitial extends TravelGuideState {
  const TravelGuideInitial() : super(guides: const <TravelGuideInfo>[], status: Progress.initial);
}

final class TravelGuideLoading extends TravelGuideState {
  const TravelGuideLoading() : super(guides: const <TravelGuideInfo>[], status: Progress.loading);
}

final class TravelGuideLoaded extends TravelGuideState {
  const TravelGuideLoaded({required super.guides}) : super(status: Progress.loaded);
}

final class TravelGuideError extends TravelGuideState {
  const TravelGuideError() : super(guides: const <TravelGuideInfo>[], status: Progress.error);
}
