import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:cosmetics_app/views/auth/login.dart';
import 'package:cosmetics_app/views/home/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/ui/app_button.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_input.dart';
import '../../core/ui/app_login_or_register.dart';

class SuccessDialog extends StatelessWidget {
  final bool isFromCreateAccount;

  const SuccessDialog({super.key, this.isFromCreateAccount = false});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(24),
      children: [
        AppImage(
          image: "success.json",
          height: 100,
          width: 100,
          bottomSpace: 26.h,
        ),
        Center(
          child: Text(
            isFromCreateAccount ? "Account Activated!" : "Password Created!",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff434C6D),
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          textAlign: TextAlign.center,
          isFromCreateAccount
              ? "Congratulations! Your account has been successfully activated"
              : "Congratulations! Your password \nhas been successfully created",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xff8E8EA9),
          ),
        ),
        SizedBox(height: 26.h),

        AppButton(
          text: isFromCreateAccount ? "Go to home" : "Return to login",
          onPressed: () {
            goTo(page: isFromCreateAccount?HomeView():LoginView(), canPop: false);
          },
        ),
      ],
    );
  }
}
