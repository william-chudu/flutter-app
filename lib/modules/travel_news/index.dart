import 'package:chudu24/constants/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final class TravelNews extends StatefulWidget {
  static const String routeName = '/travel-news';
  static const Widget screen = TravelNews();
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => screen,
      settings: const RouteSettings(name: routeName),
    );
  }

  const TravelNews({super.key});

  @override
  State<TravelNews> createState() => _TravelNewsState();
}

class _TravelNewsState extends State<TravelNews> {
  late WebViewController controller;
  int progress = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(Uri.parse(AppConstants.link.travelNewsUrl))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int value) {
            setState(() {
              progress = value;
            });
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.shared.label.travelNews,
          style: context.text.displayMedium,
        ),
      ),
      body: SafeArea(
        top: false,
        child: progress < 100
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(20),
                    value: progress / 100,
                    minHeight: 10,
                    color: AppConstants.accent,
                  ),
                ),
              )
            : WebViewWidget(controller: controller),
      ),
    );
  }
}
