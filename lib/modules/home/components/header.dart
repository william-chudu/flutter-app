import 'package:chudu24/components/button.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:flutter/material.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    return Column(
      children: [
        Container(
          color: context.color.secondaryContainer,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label.constructiveOpinion,
                style: context.text.bodyMedium,
              ),
              ButtonFilledWidget(
                radius: 3,
                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: Text(
                  label.opinion.toUpperCase(),
                  style: context.text.bodySmall?.copyWith(
                    color: context.color.surfaceTint,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                AppConstants.link.logoApp,
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.phone, color: AppConstants.accent, size: 22),
                  const SizedBox(width: 5),
                  Text(
                    '0375656505',
                    style: context.text.displaySmall?.copyWith(
                      color: context.color.primary,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
