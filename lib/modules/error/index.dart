import 'package:chudu24/constants/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:flutter/material.dart';

final class ErrorScreen extends StatelessWidget {
  static const String routeName = '/error';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const ErrorScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          'ERROR',
          style: context.text.displayLarge?.copyWith(
            fontSize: 50,
            color: AppConstants.accent,
          ),
        ),
      ),
    );
  }
}
