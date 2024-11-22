import 'package:chudu24/constants/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:flutter/material.dart';

final class LabelPrior extends StatelessWidget {
  const LabelPrior({
    super.key,
    required this.label,
    this.onTapSeemore,
    this.detail,
  });

  final String label;
  final void Function()? onTapSeemore;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: context.text.displayLarge,
            ),
            if (detail != null)
              Text(
                detail ?? '',
                style: context.text.bodyLarge?.copyWith(
                  color: context.color.outline,
                ),
              ),
          ],
        ),
        if (onTapSeemore != null)
          TextButton(
            onPressed: onTapSeemore,
            style: const ButtonStyle(
              enableFeedback: true,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              '${AppConstants.shared.label.seemore} >',
              style: context.text.bodyLarge?.copyWith(
                color: Colors.blueAccent,
              ),
            ),
          ),
      ],
    );
  }
}
