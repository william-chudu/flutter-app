part of 'travel_guide_bloc.dart';

sealed class TravelGuideEvent {
  const TravelGuideEvent();
}

final class GetTravelGuide extends TravelGuideEvent {
  const GetTravelGuide();
}
