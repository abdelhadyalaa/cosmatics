import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:cosmetics_app/core/ui/app_back.dart';
import 'package:cosmetics_app/core/ui/app_verify_code.dart';
import 'package:cosmetics_app/views/auth/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';

import '../../core/ui/app_button.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_resend_otp.dart';
import 'new_password.dart';

class OtpView extends StatefulWidget {
  final String phone;
  final bool isFromCreateAccount;

  const OtpView({
    super.key,
    this.isFromCreateAccount = false,
    required this.phone,
  });

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  bool isLoading = false;

  void verifyOtp() async {
    if (formKey.currentState?.validate() ?? false) {
      setState(() => isLoading = true);

      try {
        final response = await Dio().post(
          "http://www.cosmatics.growfet.com/api/Auth/verify-otp",
          data: {
            "otpCode": otpController.text,
            "phoneNumber": widget.phone,
            "countryCode": "+20",
          },
        );

        if (response.statusCode == 200) {
          if (mounted) {
            if (widget.isFromCreateAccount) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => SuccessDialog(isFromCreateAccount: true),
              );
            } else {
              goTo(
                page: CreatePasswordView(phone: widget.phone),
                canPop: false,
              );
            }
          }
        }
      } on DioException catch (e) {
        String msg =
            e.response?.data["message"] ?? "Invalid code, please try again";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg), backgroundColor: Colors.red),
        );
      } finally {
        if (mounted) setState(() => isLoading = false);
      }
    }
  }

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
                const AppBack(),
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
                      color: const Color(0xff434C6D),
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff3B4569),
                    ),
                    children: [
                      const TextSpan(
                        text: "We just sent a 4-digit verification code to\n",
                      ),
                      WidgetSpan(
                        child: Text(
                          "+20 ${widget.phone}\t", // استخدام الرقم الحقيقي هنا
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff3B4569).withOpacity(.99),
                          ),
                        ),
                      ),
                      const TextSpan(
                        text: " Enter the code in the box\nbelow to continue.",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context); // يرجع يعدل الرقم
                    },
                    child: const Text("Edit the number"),
                  ),
                ),
                SizedBox(height: 20.h),
                AppVerifyCode(controller: otpController),
                SizedBox(height: 42.h),
                const AppResendOtp(),
                SizedBox(height: 20.h),
                AppButton(
                  text: isLoading ? "Verifying..." : "Done",
                  onPressed: isLoading ? null : verifyOtp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }
}
