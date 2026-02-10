import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/logic/dio_helper.dart';
import '../../core/logic/end_points.dart';
import '../../core/logic/helper_methods.dart';
import '../../core/ui/app_back.dart';
import '../../core/ui/app_button.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_verify_code.dart';
import '../../core/ui/app_resend_otp.dart';
import '../auth/success_dialog.dart';
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
  void resendOtp() async {
    otpController.clear();
    try {
      final response = await DioHelper(dio: Dio()).postData(
        EndPoints.resendOtp,
        data: {"phoneNumber": widget.phone.trim(), "countryCode": "+20"},
      );

      if (response != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("A new code has been sent to your phone"),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on DioException catch (ex) {
      if (!mounted) return;
      String msg = ex.response?.data["message"] ?? "Failed to resend code";
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
    }
  }

  void verifyOtp() async {
    if (formKey.currentState?.validate() ?? false) {
      setState(() => isLoading = true);
      try {
        final response = await DioHelper(dio: Dio()).postData(
          EndPoints.verifyOtp,
          data: {
            "otpCode": otpController.text,
            "phoneNumber": widget.phone.trim(),
            "countryCode": "+20",
          },
        );

        if (response != null && response["message"] != null) {
          if (!mounted) return;
          if (widget.isFromCreateAccount) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
              const SuccessDialog(isFromCreateAccount: true),
            );
          } else {
            goTo(page: CreatePasswordView(phone: widget.phone), canPop: false);
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
                          "+20 ${widget.phone}\t",
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
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
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Edit the number"),
                  ),
                ),
                SizedBox(height: 20.h),
                AppVerifyCode(controller: otpController),
                SizedBox(height: 42.h),

                AppResendOtp(onResend: resendOtp),

                SizedBox(height: 20.h),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : AppButton(
                        text: "Done",
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
