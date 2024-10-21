import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../Widgets/LogInTextField.dart';
import '../common.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF9F9F9),
              Color(0xFF9C9C9C),
              Color(0xFF545454),
            ],
            stops: [0.22, 0.78, 1.0], // Gradient stops
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(50.w),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image.asset(
                  'assets/logo/ichibanAutoLogo.png',
                  width: 500.w,
                ),
                SizedBox(height: 110.h),
                LogInTextField(_emailController, "Email"),
                SizedBox(height: 30.h),
                LogInTextField(_passwordController, "Password"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          side: const BorderSide(style: BorderStyle.none),
                          fillColor:
                              WidgetStateProperty.resolveWith((Set states) {
                            if (states.contains(WidgetState.disabled)) {
                              return textFieldFill.withOpacity(.66);
                            }
                            return textFieldFill.withOpacity(.66);
                          }),
                          checkColor: buttonRed,
                          onChanged: (bool? value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                        ),
                         Text(
                          'Remember me',
                          style: TextStyle(color: textGrey1),
                        ),
                      ],
                    ),

                    // Forgot Password link
                    TextButton(
                      onPressed: () {},
                      child:  Text(
                        'Forgot Password?',
                        style: TextStyle(color: textGrey1),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 60.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 250.w, vertical: 14.h),
                    backgroundColor: buttonRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        color: textFieldFill, fontSize: 42.sp),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      'New Member? ',
                      style: TextStyle(color: textGreyDark),
                    ),
                    InkWell(
                      onTap: () {},
                      child:  Text(
                        ' Register Now',
                        style: TextStyle(color: buttonRed),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(height: 1.5,color: textGreyDark.withOpacity(.7)),
                    )),
                     Text(
                      ' Or ',
                      style: TextStyle(color: textGreyDark.withOpacity(.8)),
                    ),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(height: 1.5,color: textGreyDark.withOpacity(.7)),
                    )),

                  ],
                ),
                SizedBox(height: 40.h),
                Text(
                  'Use your socials to login',
                  style: TextStyle(color: textGreyDark),
                ),
                SizedBox(height: 25.h),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/logo/facebook.svg',
                      width: 75.w,
                    ),
                    SizedBox(width: 10.w),
                    SvgPicture.asset(
                      'assets/logo/Twitter.svg',
                      width: 75.w,
                    ),
                    SizedBox(width: 10.w),
                    SvgPicture.asset(
                      'assets/logo/Google.svg',
                      width: 75.w,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
