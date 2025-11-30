import 'package:cosmetics_app/views/home/view.dart';
import 'package:cosmetics_app/views/onboarding/pageone.dart';
import 'package:cosmetics_app/views/onboarding/pagethree.dart';
import 'package:cosmetics_app/views/onboarding/pagetwo.dart';
import 'package:cosmetics_app/views/splash/view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25)
          ),

        ),
        scaffoldBackgroundColor: Color(0xffD9D9D9),


        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffD75D72)),
      ),
      home: HomeView(),
    );
  }
}


