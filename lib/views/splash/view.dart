import 'dart:async';

import 'package:flutter/material.dart';

import '../onboarding/pageone.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => PageOne()),
              (route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/splash.png", height: 200, width: 200),
            SizedBox.shrink(),
            Image.asset("assets/images/textImage.png", height: 46, width: 120),
          ],
        ),
      ),
    );
  }
}
