import 'package:flutter/material.dart';

class CustomTextFieldStyle extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? icon;
  final VoidCallback? onPressed;
  final TextInputType keyboardType;
  final int? maxLength;
  final String? Function(String?)? validator; // Add the validator

  CustomTextFieldStyle({
    required this.controller,
    required this.labelText,
    required this.keyboardType,
    this.icon,
    this.onPressed,
    this.maxLength,
    this.validator, // Provide the validator
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        validator: validator, // Set the validator
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          suffixIcon: icon != null && onPressed != null
              ? GestureDetector(
                  onTap: onPressed,
                  child: Icon(
                    icon,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
