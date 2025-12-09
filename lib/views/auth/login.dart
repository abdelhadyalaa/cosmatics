
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/ui/app_button.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_input.dart';
import '../../core/ui/app_login_or_register.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(14.r).copyWith(top: 48.h),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppImage(image: "login_img.png", height: 277.h, width: 284.w),
              SizedBox(height: 24.h),
              Center(
                child: Text(
                  "Login Now",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff434C6D),
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Center(
                child: Text(
                  "Please enter the details below to continue",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff8E8EA9),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              AppInput(label: "Phone Number", withCountryCode: true),
              AppInput(
                label: "Your Password",
                isPassword: true,
                bottomSpace: 0,
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () {},
                  child: Text("Forget Password?"),
                ),
              ),
              SizedBox(height: 44.h),
              AppButton(text: "Login"),
              // Align(
              //   alignment: AlignmentDirectional.center,
              //     child: AppLoginOrRegister()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppLoginOrRegister(),
    );
  }
}
