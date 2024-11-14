import 'package:chudu24/enum/index.dart';
import 'package:chudu24/modules/bottom/index.dart';
import 'package:chudu24/modules/notfound/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/config/config_bloc.dart';

final class SplashScreen extends StatelessWidget {
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => BlocProvider(
        create: (context) => ConfigBloc()..add(const GetConfig()),
        child: const SplashScreen(),
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  const SplashScreen({super.key});
  final double size = 200;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConfigBloc, ConfigState>(
      listener: (context, state) {
        if (state.status == Progress.error) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            NotFoundScreen.routeName,
            (route) => false,
          );
        } else if (state.status == Progress.loaded) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            BottomTabsScreen.routeName,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
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
      },
    );
  }
}
