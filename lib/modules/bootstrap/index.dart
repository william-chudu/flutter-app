import 'package:chudu24/enum/index.dart';
import 'package:chudu24/modules/bootstrap/bloc/app_search/app_search_bloc.dart';
import 'package:chudu24/modules/bootstrap/bloc/app_theme/app_theme_bloc.dart';
import 'package:chudu24/modules/bootstrap/bloc/authentication/authentication_bloc.dart';
import 'package:chudu24/modules/bootstrap/bloc/config/config_bloc.dart';
import 'package:chudu24/modules/bootstrap/bloc/history_search/history_search_bloc.dart';
import 'package:chudu24/modules/bootstrap/bloc/language/language_bloc.dart';
import 'package:chudu24/modules/bootstrap/bloc/setting/setting_bloc.dart';
import 'package:chudu24/modules/bootstrap/bloc/shopping_cart/shopping_cart_bloc.dart';
import 'package:chudu24/modules/bootstrap/components/setting.dart';
import 'package:chudu24/modules/bottom/index.dart';
import 'package:chudu24/modules/notfound/index.dart';
import 'package:chudu24/router/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class Bootstrap extends StatelessWidget {
  const Bootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConfigBloc()..add(const GetConfig()),
        ),
        BlocProvider(
          create: (context) => AppSearchBloc(),
        ),
        BlocProvider(
          create: (context) => AppThemeBloc(),
        ),
        BlocProvider(
          create: (context) => LanguageBloc()..add(const InitializeLanguage()),
        ),
        BlocProvider(
          create: (context) => SettingBloc(),
        ),
        BlocProvider(
          create: (context) => AuthenticationBloc()..add(const InitializeAuthentication()),
        ),
        BlocProvider(
          create: (context) => HistorySearchBloc()..add(const GetHistorySearch()),
        ),
        BlocProvider(
          create: (context) => ShoppingCartBloc()..add(const InitializeCart()),
        ),
      ],
      child: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (_, config) {
          if (config.status == Progress.loaded) {
            return BlocBuilder<LanguageBloc, LanguageState>(
              builder: (_, state) {
                return BlocBuilder<SettingBloc, SettingState>(
                  builder: (_, setting) {
                    return MaterialApp(
                      title: 'ChuduApp',
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(
                        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        useMaterial3: true,
                      ),
                      onGenerateRoute: AppRouter.onGenerateRoute,
                      home: Builder(builder: (context) {
                        if (setting.isSetting) {
                          return const Setting();
                        }
                        return const BottomTabsScreen();
                      }),
                    );
                  },
                );
              },
            );
          }
          return MaterialApp(
            title: 'ChuduApp',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              useMaterial3: true,
            ),
            home: Builder(builder: (context) {
              if (config.status == Progress.error) {
                return const NotFoundScreen();
              }
              const size = 200.0;
              return Scaffold(
                appBar: null,
                backgroundColor: Colors.white,
                body: Center(
                  child: Image.asset(
                    'assets/images/chudu24App.png',
                    width: size,
                    height: size,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
