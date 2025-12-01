import 'package:cosmetics_app/views/home/view.dart';
import 'package:cosmetics_app/views/onboarding/pageone.dart';
import 'package:cosmetics_app/views/onboarding/pagethree.dart';
import 'package:cosmetics_app/views/onboarding/pagetwo.dart';
import 'package:cosmetics_app/views/splash/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          fontFamily: "Montserrat",
          cardColor: Color(0xffD9D9D9),
          appBarTheme: AppBarTheme(
            surfaceTintColor: Colors.transparent,
            titleTextStyle: TextStyle(
              color: Color(0xff434C6D),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            color: Colors.transparent,
            elevation: 0,
          ),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xff8E8EA9),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Color(0xffB3B3C1)),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          ),
          scaffoldBackgroundColor: Color(0xffD9D9D9),

          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffD75D72)),
        ),
        home:HomeView() ,
      ),

    );
  }
}
