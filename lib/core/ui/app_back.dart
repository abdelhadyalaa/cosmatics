import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_image.dart';

class AppBack extends StatefulWidget {
  const AppBack({super.key});

  @override
  State<AppBack> createState() => _AppBackState();
}

class _AppBackState extends State<AppBack> {
  int currentView = 0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: CircleAvatar(
        radius: 18.r,
        backgroundColor: Color(0xff1010100D),
        child: IconButton(
          onPressed: () {
            currentView--;
            setState(() {});
          },
          icon: Transform.rotate(
            angle: pi,
            child: AppImage(
              image: "forward_stroke.svg",
              color: Colors.black,
              height: 24.h,
              width: 24.w,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
