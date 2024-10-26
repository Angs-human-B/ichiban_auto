import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ichiban_auto/Screens/bookingCelenderScreen.dart';
import 'package:provider/provider.dart';

import 'Providers/booking_provider.dart';
import 'Screens/addBookingScreen.dart';
import 'Screens/signUpScreen.dart';
import 'Screens/logInScreen.dart';
import 'Providers/auth_provider.dart';
import 'Screens/splashScreen.dart';
import 'common.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(720, 1280),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Jersey25',
            bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Colors.white,
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: buttonRed),
            useMaterial3: true,
          ),
          title: 'IchibanAuto',
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/logInScreen': (context) => const LogInScreen(),
            '/signUpScreen': (context) => const SignUpScreen(),
            '/bookingCelenderScreen': (context) => const BookingCalendarScreen(),
            '/addBookingScreen': (context) => const AddBookingScreen(),

          },
        );
      },
    );
  }
}