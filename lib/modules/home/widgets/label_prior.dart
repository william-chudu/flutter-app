import 'package:chudu24/constants/index.dart';
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
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (detail != null)
              Text(
                detail ?? '',
                style: const TextStyle(color: Colors.black54, fontSize: 16),
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
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
