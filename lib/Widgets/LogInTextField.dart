import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common.dart';

class LogInTextField extends StatefulWidget {
  final TextEditingController textCon;
  final String labelText;
  const LogInTextField(this.textCon, this.labelText, {super.key});

  @override
  State<LogInTextField> createState() => _LogInTextFieldState();
}

class _LogInTextFieldState extends State<LogInTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: textFieldFill.withOpacity(.66),
      ),
      child: TextFormField(
        controller: widget.textCon,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: buttonRed, fontSize: 35.sp),
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle:
              TextStyle(color: textGrey1, fontSize: 32.sp),
          border: InputBorder.none, // Remove default border
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15.h),
        ),
        obscureText: widget.labelText == "Password",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your ${widget.labelText}';
          }
          if (widget.labelText == "Password") {
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
          }
          if (widget.labelText == "Email" &&
              !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
      ),
    );
  }
}
