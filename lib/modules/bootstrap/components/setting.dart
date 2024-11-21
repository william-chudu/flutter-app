import 'package:chudu24/constants/index.dart';
import 'package:flutter/material.dart';

final class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          label.setting,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Text(label.language),
                Transform.scale(
                  scale: 0.75,
                  child: Switch.adaptive(
                    value: true,
                    thumbIcon: WidgetStatePropertyAll(
                      Icon(Icons.language),
                    ),
                    onChanged: (_) {},
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
