import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:cosmetics_app/views/auth/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';

import '../../core/ui/app_button.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_input.dart';
import '../../core/ui/app_login_or_register.dart';
import '../home/view.dart';

class CreateAccountView extends StatefulWidget {
  CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  var formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;

  void register() async {
    if (formKey.currentState?.validate() ?? false) {
      setState(() => isLoading = true);

      try {
        final response = await Dio().post(
          "http://www.cosmatics.growfet.com/api/Auth/register",
          data: {
            "username": userNameController.text,
            "countryCode": "+20",
            "phoneNumber": phoneController.text,
            "email": emailController.text,
            "password": passwordController.text,
          },
        );

        if (response.statusCode == 200) {
          goTo(page: OtpView(phone: phoneController.text,isFromCreateAccount: true,), canPop: false);
        }
      } on DioException catch (e) {
        String errorMessage =
            e.response?.data["message"] ?? "حدث خطأ ما، حاول لاحقاً";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
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

                AppInput(controller: userNameController, label: "Your Name"),
                AppInput(
                  controller: phoneController,
                  withCountryCode: true,
                  label: "Phone Number",
                  keyboardType: TextInputType.number,
                ),
                AppInput(
                  controller: passwordController,
                  isPassword: true,
                  label: "Create your password",
                ),
                AppInput(
                  controller: confirmPasswordController,
                  isPassword: true,
                  label: "Confirm password",
                ),
                SizedBox(height: 90.h),
                AppButton(
                  text: isLoading ? "Loading..." : "Next",
                  onPressed: isLoading ? null : register,
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
