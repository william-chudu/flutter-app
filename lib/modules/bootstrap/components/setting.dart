import 'package:chudu24/constants/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/modules/bootstrap/bloc/app_theme/app_theme_bloc.dart';
import 'package:chudu24/modules/bootstrap/bloc/language/language_bloc.dart';
import 'package:chudu24/modules/bootstrap/bloc/setting/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          label.setting,
          style: context.text.displayMedium,
        ),
        leading: IconButton(
          onPressed: () {
            context.read<SettingBloc>().add(const SettingEvent(isSetting: false));
          },
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label.english,
                    style: context.text.bodyLarge?.copyWith(fontSize: 18),
                  ),
                  BlocBuilder<LanguageBloc, LanguageState>(
                    builder: (context, state) {
                      return Transform.scale(
                        scale: 0.8,
                        child: Switch.adaptive(
                          value: state.isEn,
                          thumbIcon: const WidgetStatePropertyAll(
                            Icon(Icons.language, color: AppConstants.accent),
                          ),
                          onChanged: (bool isEN) {
                            context.read<LanguageBloc>().add(ChangeLanguage(isEN: isEN));
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label.darkTheme,
                    style: context.text.bodyLarge?.copyWith(fontSize: 18),
                  ),
                  BlocBuilder<AppThemeBloc, AppThemeState>(
                    builder: (context, state) {
                      return Transform.scale(
                        scale: 0.8,
                        child: Switch.adaptive(
                          value: !state.isLight,
                          thumbIcon: const WidgetStatePropertyAll(
                            Icon(Icons.light_mode_outlined, color: AppConstants.accent),
                          ),
                          onChanged: (bool isLight) {
                            context.read<AppThemeBloc>().add(
                                  ChangeAppTheme(isLight: !isLight),
                                );
                          },
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
