import 'package:cosmetics_app/core/logic/dio_helper.dart';
import 'package:cosmetics_app/core/logic/end_points.dart';
import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:cosmetics_app/core/ui/app_back.dart';
import 'package:cosmetics_app/views/auth/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';

import '../../core/ui/app_button.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_input.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  bool isLoading = false;

  void sendCode() async {
    if (formKey.currentState?.validate() ?? false) {
      setState(() => isLoading = true);

      try {
        final response = await DioHelper().postData(
          EndPoints.forgetPassword,
          data: {"countryCode": "+20", "phoneNumber": phoneController.text.trim()},
        );

        if (response != null) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(response["message"] ?? "OTP Sent!"),
                backgroundColor: Colors.green,
              ),
            );

            goTo(
              page: OtpView(
                phone:phoneController.text.trim() ,
                isFromCreateAccount: false,
              ),
              canPop: true,
            );
          }
        }
      } on DioException catch (e) {
        String msg = e.response?.data["message"] ?? "Phone number not found!";
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
                SizedBox(height: 48.h),
                Center(
                  child: AppImage(image: "logo.png", height: 64.h, width: 64.w),
                ),
                SizedBox(height: 24.h),
                Center(
                  child: Text(
                    "Forget Password",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff434C6D),
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
                      color: const Color(0xff8E8EA9),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                AppInput(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  label: "Phone Number",
                  withCountryCode: true,
                  bottomSpace: 56.h,
                ),
                SizedBox(height: 44.h),
                AppButton(
                  text: isLoading ? "Sending..." : "Next",
                  onPressed: isLoading ? null : sendCode,
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
    phoneController.dispose();
    super.dispose();
  }
}
