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
        color: Colors.grey[200],
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
          hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
