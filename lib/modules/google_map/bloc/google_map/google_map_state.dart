part of 'google_map_bloc.dart';

sealed class GoogleMapState {
  final Progress status;
  final Set<Marker> markers;

  const GoogleMapState({required this.status, required this.markers});
}

final class GoogleMapInitial extends GoogleMapState {
  const GoogleMapInitial() : super(status: Progress.initial, markers: const {});
}

final class GoogleMapLoading extends GoogleMapState {
  const GoogleMapLoading() : super(status: Progress.loading, markers: const {});
}

final class GoogleMapLoaded extends GoogleMapState {
  const GoogleMapLoaded({required super.markers}) : super(status: Progress.loaded);
}

final class GoogleMapError extends GoogleMapState {
  const GoogleMapError() : super(status: Progress.error, markers: const {});
}
