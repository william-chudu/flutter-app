part of 'top_destination_bloc.dart';

sealed class TopDestinationState {
  final Progress status;
  final List<TopLocation> locations;

  const TopDestinationState({required this.status, required this.locations});
}

final class TopDestinationInitial extends TopDestinationState {
  const TopDestinationInitial() : super(status: Progress.initial, locations: const <TopLocation>[]);
}

final class TopDestinationLoading extends TopDestinationState {
  const TopDestinationLoading() : super(status: Progress.loading, locations: const <TopLocation>[]);
}

final class TopDestinationLoaded extends TopDestinationState {
  const TopDestinationLoaded({required super.locations}) : super(status: Progress.loaded);
}

final class TopDestinationError extends TopDestinationState {
  const TopDestinationError() : super(status: Progress.error, locations: const <TopLocation>[]);
}
