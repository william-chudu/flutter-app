import 'package:chudu24/components/button.dart';
import 'package:chudu24/components/image_builder.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/modules/account/index.dart';
import 'package:flutter/material.dart';

final class NotLogin extends StatelessWidget {
  const NotLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageBuilder(
              AppConstants.link.logoApp,
              width: 300,
              height: 50,
              fit: BoxFit.fitHeight,
            ),
            const SizedBox(height: 50),
            ButtonFilledWidget(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 10),
              onTap: () {
                Navigator.of(context).pushNamed(Account.routeName);
              },
              child: Center(
                child: Text(
                  label.signIn,
                  style: context.text.titleLarge?.copyWith(color: context.color.surfaceTint),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(label.or),
            const SizedBox(height: 20),
            ButtonOutlinedWidget(
              borderColor: Colors.blue,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 10),
              onTap: () {
                Navigator.of(context).pushNamed(Account.routeName);
              },
              child: Center(
                child: Text(
                  label.register,
                  style: context.text.titleLarge?.copyWith(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
