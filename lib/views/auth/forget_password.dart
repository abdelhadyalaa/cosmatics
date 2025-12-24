import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:cosmetics_app/core/ui/app_back.dart';
import 'package:cosmetics_app/views/auth/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/ui/app_button.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_input.dart';

class ForgetPasswordView extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(14.r),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppBack(),
                SizedBox(height: 48.h),
                AppImage(image: "logo.png", height: 64.h, width: 64.w),
                SizedBox(height: 24.h),
                Center(
                  child: Text(
                    "Forget Password",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff434C6D),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Please enter your phone number below\nto recovery your password.",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff8E8EA9),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                AppInput(
                  keyboardType: TextInputType.number,
                  label: "Phone Number",
                  withCountryCode: true,
                  bottomSpace: 56,
                ),
                SizedBox(height: 44.h),
                AppButton(
                  text: "Next",
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      goTo(page: OtpView(), canPop: false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Sorry You Should Put Your Number ....",
                          ),
                          backgroundColor: Colors.red.shade800,
                        ),
                      );
                    }
                  },
                ),
                // Align(
                //   alignment: AlignmentDirectional.center,
                //     child: AppLoginOrRegister()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
