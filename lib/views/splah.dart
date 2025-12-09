import 'dart:async';

import 'package:cosmetics_app/core/logic/helper_method.dart';
import 'package:cosmetics_app/views/onboarding/view.dart';
import 'package:flutter/material.dart';

import '../core/ui/app_image.dart';

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
    goTo(delaySeconds: 5, page: PageOne());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppImage(
              image: "splash.png",
              height: 200,
              width: 200,
              bottomSpace: 16,
            ),
            SizedBox.shrink(),
            AppImage(image: "splash_text.png", height: 46, width: 120),
          ],
        ),
      ),
    );
  }
}
