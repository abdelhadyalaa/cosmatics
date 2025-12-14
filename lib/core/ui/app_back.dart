import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_image.dart';

class AppBack extends StatelessWidget {
  final double startPadding;

  const AppBack({super.key, this.startPadding = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: startPadding),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: CircleAvatar(
            radius: 18.r,
            backgroundColor: Color(0x1010100D),
            child: Transform.rotate(
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
      ),
    );
  }
}
