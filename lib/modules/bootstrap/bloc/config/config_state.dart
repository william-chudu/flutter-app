part of 'config_bloc.dart';

sealed class ConfigState {
  final Progress status;
  final Map? config;

  const ConfigState({required this.status, this.config});
}

final class ConfigInitial extends ConfigState {
  const ConfigInitial() : super(status: Progress.initial, config: null);
}

final class ConfigLoading extends ConfigState {
  const ConfigLoading() : super(status: Progress.loading, config: null);
}

final class ConfigLoaded extends ConfigState {
  const ConfigLoaded({required super.config}) : super(status: Progress.loaded);
}

final class ConfigError extends ConfigState {
  const ConfigError() : super(status: Progress.error, config: null);
}
