import 'package:chudu24/modules/bootstrap/bloc/app_search/app_search_bloc.dart';
import 'package:chudu24/modules/bootstrap/bloc/authentication/authentication_bloc.dart';
import 'package:chudu24/modules/bootstrap/bloc/history_search/history_search_bloc.dart';
import 'package:chudu24/modules/bootstrap/bloc/language/language_bloc.dart';
import 'package:chudu24/modules/bootstrap/bloc/shopping_cart/shopping_cart_bloc.dart';
import 'package:chudu24/modules/splash/index.dart';
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
          create: (context) => AppSearchBloc(),
        ),
        BlocProvider(
          create: (context) => LanguageBloc()..add(const InitializeLanguage()),
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
      child: MaterialApp(
        title: 'ChuduApp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          useMaterial3: true,
        ),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
