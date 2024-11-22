import 'package:chudu24/constants/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final class Webview extends StatefulWidget {
  static const String routeName = '/webview';
  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return Webview(
          link: (settings.arguments as String?) ?? 'https://chudu24.com/thongtindulich',
        );
      },
      settings: settings,
    );
  }

  const Webview({super.key, required this.link});

  final String link;

  @override
  State<Webview> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  late final WebViewController controller;
  int progress = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(Uri.parse(widget.link))
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
