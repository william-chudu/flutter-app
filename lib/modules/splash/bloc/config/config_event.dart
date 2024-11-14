part of 'config_bloc.dart';

sealed class ConfigEvent {
  const ConfigEvent();
}

final class GetConfig extends ConfigEvent {
  const GetConfig();
}
