import 'package:flutter/material.dart';

import '../common.dart';

class BookingTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;

  const BookingTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: textFieldFill.withOpacity(.8),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: textGreyDark.withOpacity(.3),
            blurRadius: 0,
            spreadRadius: 0
          ),
          const BoxShadow(
            color: Colors.white,
            spreadRadius: 0.0,
            blurRadius: 20.0,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: textGrey2),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        ),
      ),
    );
  }
}
