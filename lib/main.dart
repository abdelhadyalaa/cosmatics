import 'package:cosmetics_app/views/auth/create_account.dart';
import 'package:cosmetics_app/views/auth/forget_password.dart';
import 'package:cosmetics_app/views/auth/login.dart';
import 'package:cosmetics_app/views/auth/new_password.dart';
import 'package:cosmetics_app/views/auth/otp.dart';
import 'package:cosmetics_app/views/home/pages/cart.dart';
import 'package:cosmetics_app/views/home/view.dart';
import 'package:cosmetics_app/views/onboarding/view.dart';
import 'package:cosmetics_app/views/splah.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/logic/helper_method.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      minTextAdapt: true,

      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              fixedSize: Size.fromHeight(65),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
            ),
          ),
          fontFamily: "Montserrat",

          cardColor: Color(0xffD9D9D9),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color(0xff434C6D)
          ),
          appBarTheme: AppBarTheme(
            surfaceTintColor: Colors.transparent,

            titleTextStyle: TextStyle(
              color: Color(0xff434C6D),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xff5A6690)),
            ),
            labelStyle: TextStyle(
              fontSize: 12.sp,
              color: Color(0xff8E8EA9).withValues(alpha: .4),
            ),
            floatingLabelStyle: TextStyle(
              fontSize: 14,
              color: Color(0xff8E8EA9),
            ),
            hintStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xff8E8EA9),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffB3B3C1)),
            ),

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          ),
          scaffoldBackgroundColor: Color(0xffD9D9D9),

          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffD75D72)),
        ),
        home: PageView(
          children: [
            // OtpView(),
            // PageOne(),
            SplashScreen(),
            // NewPasswordView(),
            // ForgetPasswordView(),
            // HomeView(),
            // CartPage(),
            // CreateAccountView(),
            // LoginView()
          ],
        ),
        navigatorKey: navKey,
      ),
    );
  }
}
