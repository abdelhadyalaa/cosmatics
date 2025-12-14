import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:cosmetics_app/core/ui/app_back.dart';
import 'package:cosmetics_app/core/ui/app_verify_code.dart';
import 'package:cosmetics_app/views/auth/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/ui/app_button.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_input.dart';
import '../../core/ui/app_login_or_register.dart';
import '../../core/ui/app_resend_otp.dart';
import 'new_password.dart';

class OtpView extends StatelessWidget {
  final bool isFromCreateAccount;
  const OtpView({super.key,  this.isFromCreateAccount=false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(14.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBack(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: AppImage(
                    image: "splash.png",
                    height: 62.h,
                    width: 67.w,
                  ),
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
                textAlign: TextAlign.center,
                TextSpan(
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff3B4569),
                  ),
                  children: [
                    TextSpan(
                      text: "We just sent a 4-digit verification code to\n",
                    ),
                    WidgetSpan(
                      child: Text(
                        "+20 1022658997\t",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0x3B4569BA).withValues(alpha: .99),
                        ),
                      ),
                    ),
                    TextSpan(
                      text: " Enter the code in the box\nbelow to continue.",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  onPressed: () {},
                  child: Text("Edit the number"),
                ),
              ),
              SizedBox(height: 20.h),
              AppVerifyCode(),
              SizedBox(height: 42.h),

              AppResendOtp(),
              SizedBox(height: 20.h),


              AppButton(text: "Done",
                onPressed: () {
                if(isFromCreateAccount){
                  showDialog(
                    context: context,
                    builder: (context) => SuccessDialog(
                      isFromCreateAccount: isFromCreateAccount,
                    ),
                  );
                }else {
                  goTo(page:CreatePasswordView());
                }
                },),
            ],
          ),
        ),
      ),
    );
  }
}
