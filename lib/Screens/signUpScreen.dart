import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ichiban_auto/Screens/logInScreen.dart';
import 'package:provider/provider.dart';

import '../Providers/auth_provider.dart';
import '../Widgets/LogInTextField.dart';
import '../common.dart';
import 'homePage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
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
            stops: [0.18, 0.78, 1.0], // Gradient stops
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
                SizedBox(height: 80.h),
                LogInTextField(_nameController, "Name"),
                SizedBox(height: 15.h),
                LogInTextField(_phoneController, "Phone"),
                SizedBox(height: 15.h),
                LogInTextField(_emailController, "Email"),
                SizedBox(height: 15.h),
                LogInTextField(_passwordController, "Password"),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Checkbox(
                      value: isAdmin,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      side: const BorderSide(style: BorderStyle.none),
                      fillColor: WidgetStateProperty.resolveWith((Set states) {
                        if (states.contains(WidgetState.disabled)) {
                          return textFieldFill.withOpacity(.66);
                        }
                        return textFieldFill.withOpacity(.66);
                      }),
                      checkColor: buttonRed,
                      onChanged: (bool? value) {
                        setState(() {
                          isAdmin = value ?? false;
                        });
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign up as an ',
                          style: TextStyle(color: textGreyDark, fontSize: 14),
                        ),
                        Text(
                          'ADMIN?',
                          style: TextStyle(color: buttonRed, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                if (authProvider.isLoading) CircularProgressIndicator(),
                if (!authProvider.isLoading)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 250.w, vertical: 14.h),
                      backgroundColor: buttonRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.sp),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool success = await authProvider.signUp(
                          name: _nameController.text.trim(),
                          phone: _phoneController.text.trim(),
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                          role: isAdmin ? 'Admin' : 'Mechanic',
                        );
                        if (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogInScreen()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    authProvider.error ?? 'Sign up failed')),
                          );
                        }
                      }
                    },
                    child: Text(
                      'SIGNUP',
                      style: TextStyle(color: Colors.white, fontSize: 42.sp),
                    ),
                  ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(color: textGreyDark),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/logInScreen');
                      },
                      child: Text(
                        ' Log In',
                        style: TextStyle(color: buttonRed),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                          height: 1.5, color: textGreyDark.withOpacity(.7)),
                    )),
                    Text(
                      ' Or ',
                      style: TextStyle(color: textGreyDark.withOpacity(.8)),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                          height: 1.5, color: textGreyDark.withOpacity(.7)),
                    )),
                  ],
                ),
                SizedBox(height: 25.h),
                Text(
                  'Use your socials to signup',
                  style: TextStyle(color: textGreyDark),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
