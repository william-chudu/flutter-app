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
      body: const Center(
        child: Text(
          '404',
          style: TextStyle(
            fontSize: 100,
            fontWeight: FontWeight.bold,
            color: Colors.black26,
            decoration: TextDecoration.underline,
            decorationColor: Colors.black12,
            decorationThickness: 0.5,
          ),
        ),
      ),
    );
  }
}
