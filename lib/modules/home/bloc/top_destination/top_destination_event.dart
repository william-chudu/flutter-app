part of 'top_destination_bloc.dart';

sealed class TopDestinationEvent {
  const TopDestinationEvent();
}

final class GetTopDestination extends TopDestinationEvent {
  const GetTopDestination();
}
