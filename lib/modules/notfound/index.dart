import 'package:chudu24/extensions/build_context.dart';
import 'package:flutter/material.dart';

final class NotFoundScreen extends StatelessWidget {
  static const String routeName = '/not-found';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const NotFoundScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          '404',
          style: context.text.headlineLarge?.copyWith(
            fontSize: 100,
            color: context.color.outline,
            decorationColor: context.color.outline,
            decorationThickness: 0.5,
          ),
        ),
      ),
    );
  }
}
