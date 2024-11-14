import 'package:chudu24/constants/index.dart';
import 'package:flutter/material.dart';

class ButtonFilledWidget extends StatelessWidget {
  const ButtonFilledWidget({
    super.key,
    required this.child,
    this.onTap,
    this.radius = 5,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.color,
    this.isDisabled = false,
    this.isLoading = false,
  });

  final Widget child;
  final void Function()? onTap;
  final double radius;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final bool isDisabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? null : onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          border: Border.all(
            color: color ?? AppConstants.accent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(radius),
          color: color ?? AppConstants.accent,
        ),
        child: isLoading
            ? Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  child,
                  const SizedBox(width: 10),
                  const SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : child,
      ),
    );
  }
}

final class ButtonOutlinedWidget extends StatelessWidget {
  const ButtonOutlinedWidget({
    super.key,
    required this.child,
    this.onTap,
    this.borderColor,
    this.radius = 5,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.isDisabled = false,
    this.isLoading = false,
  });

  final Widget child;
  final void Function()? onTap;
  final double radius;
  final double? height;
  final double? width;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool isDisabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? null : onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? AppConstants.accent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: isLoading
            ? Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  child,
                  const SizedBox(width: 10),
                  const SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : child,
      ),
    );
  }
}
