import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final double borderRadius;

  const TextFieldInput({
    Key? key,
    required this.hintText,
    required this.textInputType,
    required this.textEditingController,
    this.borderRadius = 15.0, // Default border radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: TextField(
        controller: textEditingController,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
      ),
    );
  }
}
