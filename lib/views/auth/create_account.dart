import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:cosmetics_app/views/auth/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/ui/app_button.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_input.dart';
import '../../core/ui/app_login_or_register.dart';

class CreateAccountView extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  CreateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: AppImage(
                      image: "splash.png",
                      height: 70.h,
                      width: 70.w,
                    ),
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
                AppInput(withCountryCode: true, label: "Phone Number",keyboardType: TextInputType.number,),
                AppInput(isPassword: true, label: "Create your password"),
                AppInput(isPassword: true, label: "Confirm password"),
                SizedBox(height: 90.h),
                AppButton(
                  text: "Next",
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      goTo(
                        page: OtpView(isFromCreateAccount: true),
                        canPop: true,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Sorry You Should Put Your Data ...."),
                          backgroundColor: Colors.red.shade800,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppLoginOrRegister(isLogin: false),
    );
  }
}
