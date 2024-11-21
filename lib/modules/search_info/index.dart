import 'package:chudu24/components/info_search.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:flutter/material.dart';

final class SearchInfo extends StatelessWidget {
  static const String routeName = '/search-info';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const SearchInfo(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const SearchInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              title: Text(
                AppConstants.shared.label.search,
                style: context.text.displayMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                height: size.height / 2 - 100,
                child: InfoSearch(onSelectDate: (_) {}),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
