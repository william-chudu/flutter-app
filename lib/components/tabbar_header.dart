import 'package:chudu24/constants/index.dart';
import 'package:flutter/material.dart';

final class TabbarHeader extends StatelessWidget {
  const TabbarHeader({
    super.key,
    required this.labels,
    this.textStyle,
  });

  final List<String> labels;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
      enableFeedback: true,
      isScrollable: true,
      tabAlignment: TabAlignment.center,
      indicatorColor: AppConstants.accent,
      labelColor: AppConstants.accent,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: List.generate(
        labels.length,
        (int index) => Text(
          labels[index],
          textAlign: TextAlign.center,
          style: textStyle,
        ),
      ),
    );
  }
}
