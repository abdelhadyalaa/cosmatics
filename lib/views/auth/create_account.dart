
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/ui/app_button.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_input.dart';
import '../../core/ui/app_login_or_register.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                "Create Account",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff434C6D),
                ),
              ),
            ),
            SizedBox(height: 50.h),

            AppInput(label: "Your Name"),
            AppInput(withCountryCode: true, label: "Phone Number"),
            AppInput(isPassword: true, label: "Create your password"),
            AppInput(isPassword: true, label: "Confirm password"),
            SizedBox(height: 90.h),
            AppButton(text: "Next"),
          ],
        ),
      ),
      bottomNavigationBar: AppLoginOrRegister(isLogin: false),
    );
  }
}
