import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final double borderRadius;
  final bool obscureText; // Add this property
  final bool isPassword;

  const TextFieldInput({
    Key? key,
    required this.hintText,
    required this.textInputType,
    required this.textEditingController,
    this.borderRadius = 30.0,
    this.obscureText = false, // Default is false
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0), // Adjust padding for left and right
      child: TextField(
        controller: textEditingController,
        keyboardType: textInputType,
        obscureText: obscureText, // Ensure this is here
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.grey[800],
          hintStyle: TextStyle(color: Colors.white70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
