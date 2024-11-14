import 'dart:async';
import 'package:flutter/material.dart';

final class TouchableOpacity extends StatefulWidget {
  final Widget child;
  final void Function()? onTap;

  const TouchableOpacity({super.key, required this.child, this.onTap});

  @override
  State<TouchableOpacity> createState() => _TouchableOpacityState();
}

class _TouchableOpacityState extends State<TouchableOpacity> {
  final Duration duration = const Duration(milliseconds: 100);
  final double opacity = 0.2;
  bool isDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDown = true;
        });
        widget.onTap?.call();
        Timer(duration, () {
          setState(() {
            isDown = false;
          });
        });
      },
      child: AnimatedOpacity(
        duration: duration,
        opacity: isDown ? opacity : 1,
        child: widget.child,
      ),
    );
  }
}
