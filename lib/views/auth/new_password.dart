import 'package:cosmetics_app/views/auth/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';

import '../../core/logic/helper_methods.dart';
import '../../core/ui/app_button.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_input.dart';

class CreatePasswordView extends StatefulWidget {
  final String phone;

  const CreatePasswordView({super.key, required this.phone});

  @override
  State<CreatePasswordView> createState() => _CreatePasswordViewState();
}

class _CreatePasswordViewState extends State<CreatePasswordView> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;

  void resetPassword() async {
    if (formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Passwords do not match"),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      setState(() => isLoading = true);

      try {

        final response = await Dio().post(
          "http://www.cosmatics.growfet.com/api/Auth/reset-password",
          data: {
            "countryCode": "+20",
            "phoneNumber": widget.phone,
            "password": passwordController.text,
            "confirmPassword": confirmPasswordController.text,
          },
        );

        if (response.statusCode == 200) {
          if (mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
                  const SuccessDialog(isFromCreateAccount: false),
            );
          }
        }
      } on DioException catch (e) {
        String msg = e.response?.data["message"] ?? "حدث خطأ في السيرفر";
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
            padding: EdgeInsets.all(14.r).copyWith(top: 48.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: AppImage(image: "logo.png", height: 64.h, width: 64.w),
                ),
                SizedBox(height: 24.h),
                Center(
                  child: Text(
                    "Create Password",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff434C6D),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                const Text(
                  "The password should have at least \n6 characters.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Color(0xff8E8EA9)),
                ),
                SizedBox(height: 24.h),
                AppInput(
                  controller: passwordController,
                  label: "New password",
                  isPassword: true,

                ),
                AppInput(
                  controller: confirmPasswordController,
                  label: "Confirm password",
                  isPassword: true,
                  bottomSpace: 70.h,
                ),
                AppButton(
                  text: isLoading ? "Updating..." : "Confirm",
                  onPressed: isLoading
                      ? null
                      : resetPassword,
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
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
