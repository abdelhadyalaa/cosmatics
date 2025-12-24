import 'package:cosmetics_app/views/auth/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/logic/helper_methods.dart';
import '../../core/ui/app_button.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_input.dart';

class CreatePasswordView extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  CreatePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(14.r).copyWith(top: 48.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppImage(image: "logo.png", height: 64.h, width: 64.w),
                SizedBox(height: 24.h),
                Center(
                  child: Text(
                    "Create Password",
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
                    "The password should have at least \n6 characters.",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff8E8EA9),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                AppInput(
                  label: "New password",
                  isPassword: true,
                  bottomSpace: 16,
                ),
                AppInput(
                  label: "Confirm password",
                  isPassword: true,
                  bottomSpace: 70,
                ),
                AppButton(
                  text: "Confirm",
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      goTo(page: SuccessDialog(), canPop: false);
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
