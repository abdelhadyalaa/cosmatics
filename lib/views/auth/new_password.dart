import 'package:cosmetics_app/views/auth/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/ui/app_button.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_input.dart';

class CreatePasswordView extends StatelessWidget {
  const CreatePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  showDialog(
                    context: context,
                    builder: (context) => SuccessDialog(),
                  );
                },
              ),
              // Align(
              //   alignment: AlignmentDirectional.center,
              //     child: AppLoginOrRegister()),
            ],
          ),
        ),
      ),
    );
  }
}
