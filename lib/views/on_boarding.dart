import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/logic/helper_methods.dart';
import '../core/ui/app_button.dart';
import '../core/ui/app_image.dart';
import 'auth/login.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final list = [
    _Model(
      image: "on_boarding1.png",
      title: "WELCOME!",
      desc:
          "Makeup has the power to transform your mood and empowers you to be a more confident person.",
    ),
    _Model(
      image: "on_boarding2.png",
      title: "SEARCH & PICK",
      desc:
          "We have dedicated set of products and routines hand picked for every skin type.",
    ),
    _Model(
      image: "on_boarding3.png",
      title: "PUCH NOTIFICATIONS ",
      desc: "Allow notifications for new makeup & cosmetics offers.",
    ),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool isLast = currentIndex == list.length - 1;
    final currentModel = list[currentIndex];
    void goToLogin() {
      goTo(page: LoginView());
    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!isLast)
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () {
                    goTo(page: LoginView());
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff434C6D),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 100.h),

            AppImage(image: currentModel.image, width: 283.w, height: 259.h),
            SizedBox(height: 27.h),
            Center(
              child: Text(
                currentModel.title,
                style: TextStyle(
                  color: Color(0xff434C6D),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 40),
              child: Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff434C6D),
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
                currentModel.desc,
              ),
            ),
            SizedBox(height: 30),
            isLast
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60.0),
                    child: AppButton(
                      onPressed: () {
                        goTo(page: LoginView());
                      },
                      color: Color(0xff434C6D),
                      text: "let’s start!",
                    ),
                  )
                : Center(
                    child: FloatingActionButton(
                      child: AppImage(image: "forward_stroke.svg"),

                      onPressed: () {
                        currentIndex++;
                        setState(() {});
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class _Model {
  final String image, title, desc;

  _Model({required this.image, required this.title, required this.desc});
}
