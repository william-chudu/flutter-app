part of 'international_item_bloc.dart';

sealed class InternationalItemEvent {
  const InternationalItemEvent();
}

final class GetInternationalElements extends InternationalItemEvent {
  const GetInternationalElements();
}
