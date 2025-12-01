import 'package:cosmetics_app/core/components/app_button.dart';
import 'package:cosmetics_app/core/components/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/components/app_image.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(13.r).copyWith(top: 48.h),

          child: Column(
            children: [
              AppImage(image: "login_img.png", height: 277.h, width: 284.w),
              SizedBox(height: 24.h),
              Text(
                "Login Now",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff434C6D),
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                "Please enter the details below to continue",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff8E8EA9),
                ),
              ),
              SizedBox(height: 24.h),
              AppInput(label: "Phone Number", withCountryCode: true),
              AppInput(label: "Your Password"),
              TextButton(onPressed: () {}, child: Text("Forget Password?")),
              AppButton(),
            ],
          ),
        ),
      ),
    );
  }
}
