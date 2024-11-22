import 'package:chudu24/extensions/build_context.dart';
import 'package:flutter/material.dart';

final class InputBox extends StatelessWidget {
  const InputBox({
    super.key,
    this.inputController,
    required this.label,
    this.keyboardType,
    this.isObscured = false,
    this.validator,
    this.formKey,
  });

  final TextEditingController? inputController;
  final String label;
  final TextInputType? keyboardType;
  final bool isObscured;
  final String? Function(String? text)? validator;
  final GlobalKey<FormState>? formKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.color.secondaryContainer,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextFormField(
        key: formKey,
        keyboardType: keyboardType,
        obscureText: isObscured,
        controller: inputController,
        validator: validator,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: context.text.bodyLarge?.copyWith(
            color: Colors.grey,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
