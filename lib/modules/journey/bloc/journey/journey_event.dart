part of 'journey_bloc.dart';

sealed class JourneyEvent {
  const JourneyEvent();
}

final class GetAllJourney extends JourneyEvent {
  final String accountId;

  const GetAllJourney({required this.accountId});
}
