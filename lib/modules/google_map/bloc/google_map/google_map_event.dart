part of 'google_map_bloc.dart';

sealed class GoogleMapEvent {
  final MapParam? param;
  const GoogleMapEvent([this.param]);
}

final class GetInfoMap extends GoogleMapEvent {
  const GetInfoMap([super.param]);
}
