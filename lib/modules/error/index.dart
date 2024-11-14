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
      body: const Center(
        child: Text(
          'ERROR',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.red),
        ),
      ),
    );
  }
}
