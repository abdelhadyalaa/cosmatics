
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/ui/app_button.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_input.dart';
import '../../core/ui/app_login_or_register.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: AppImage(image: "splash.png", height: 62.h, width: 67.w),
            ),
          ),
          SizedBox(height: 24.h),
          Center(
            child: Text(
              "Verify Code",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xff434C6D),
              ),
            ),
          ),
          SizedBox(height: 50.h),
          Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xff3B4569),
              ),
              children: [
                TextSpan(text: "We just sent a 4-digit verification code to\n"),
                TextSpan(
                  text: "+20 1022658997",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0x3B4569BA).withValues(alpha: .99),
                  ),
                ),
                TextSpan(text: " Enter the code in the box\n"),

                TextSpan(text: "below to continue."),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
