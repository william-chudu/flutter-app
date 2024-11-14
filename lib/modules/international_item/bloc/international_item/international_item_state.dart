part of 'international_item_bloc.dart';

sealed class InternationalItemState {
  final Progress status;
  final List<InternationalElement> topDestinations;
  final List<InternationalElement> travelNews;
  final List<HeaderListItems<InternationalElement>> popularChoices;

  const InternationalItemState({
    required this.status,
    required this.topDestinations,
    required this.travelNews,
    required this.popularChoices,
  });
}

final class InternationalItemInitial extends InternationalItemState {
  const InternationalItemInitial()
      : super(
          status: Progress.initial,
          topDestinations: const [],
          travelNews: const [],
          popularChoices: const [],
        );
}

final class InternationalItemLoading extends InternationalItemState {
  const InternationalItemLoading()
      : super(
          status: Progress.loading,
          topDestinations: const [],
          travelNews: const [],
          popularChoices: const [],
        );
}

final class InternationalItemLoaded extends InternationalItemState {
  const InternationalItemLoaded({
    required super.popularChoices,
    required super.topDestinations,
    required super.travelNews,
  }) : super(status: Progress.loaded);
}

final class InternationalItemError extends InternationalItemState {
  const InternationalItemError()
      : super(
          status: Progress.error,
          topDestinations: const [],
          travelNews: const [],
          popularChoices: const [],
        );
}
