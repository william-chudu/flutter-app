import 'package:chudu24/components/loading.dart';
import 'package:flutter/material.dart';

final class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(child: LoadingWidget()),
    );
  }
}
