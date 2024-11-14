import 'package:chudu24/models/info_cart_hotel.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'modules/bootstrap/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(CartHotelAdapter());
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
