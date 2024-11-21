part of 'journey_bloc.dart';

sealed class JourneyState {
  final Progress status;
  final List<JourneyItem> processing;
  final List<JourneyItem> checkIn;
  final List<JourneyItem> checkOut;

  const JourneyState({
    required this.status,
    required this.processing,
    required this.checkIn,
    required this.checkOut,
  });
}

final class JourneyInitial extends JourneyState {
  const JourneyInitial()
      : super(
          status: Progress.initial,
          processing: const [],
          checkIn: const [],
          checkOut: const [],
        );
}

final class JourneyLoading extends JourneyState {
  const JourneyLoading()
      : super(
          status: Progress.loading,
          processing: const [],
          checkIn: const [],
          checkOut: const [],
        );
}

final class JourneyLoaded extends JourneyState {
  const JourneyLoaded({
    required super.checkIn,
    required super.checkOut,
    required super.processing,
  }) : super(status: Progress.loaded);
}

final class JourneyError extends JourneyState {
  const JourneyError()
      : super(
          status: Progress.error,
          processing: const [],
          checkIn: const [],
          checkOut: const [],
        );
}
