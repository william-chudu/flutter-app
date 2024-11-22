import 'package:chudu24/request/index.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'modules/bootstrap/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  _AppState() {
    // ApiClient.shared.init();
  }
  @override
  void dispose() {
    Hive.close();
    ApiClient.shared.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Bootstrap();
  }
}
