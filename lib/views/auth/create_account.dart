import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:cosmetics_app/views/auth/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';

import '../../core/logic/dio_helper.dart';
import '../../core/logic/end_points.dart';
import '../../core/ui/app_button.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_input.dart';
import '../../core/ui/app_login_or_register.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;
  String selectedCountryCode = "+20";

  void register() async {
    if (formKey.currentState?.validate() ?? false) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("كلمة المرور غير متطابقة"),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      setState(() => isLoading = true);

      try {
        final response = await DioHelper().postData(
          EndPoints.register,
          data: {
            "username": userNameController.text,
            "countryCode": selectedCountryCode,
            "phoneNumber": phoneController.text,
            "email": emailController.text,
            "password": passwordController.text,
          },
        );

        if (response != null) {
          goTo(
            page: OtpView(
              phone: phoneController.text,
              isFromCreateAccount: true,
            ),
            canPop: false,
          );
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
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: AppImage(
                      image: "splash.png",
                      height: 70.h,
                      width: 70.w,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff434C6D),
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                AppInput(controller: userNameController, label: "Your Name"),
                AppInput(
                  controller: phoneController,
                  withCountryCode: true,
                  label: "Phone Number",
                  onCountryCodeChanged: (value) {
                    selectedCountryCode = value;
                  },
                  keyboardType: TextInputType.number,
                ),
                AppInput(
                  controller: emailController,
                  label: "Email Address",
                  keyboardType: TextInputType.emailAddress,
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
                SizedBox(height: 40.h),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : AppButton(
                        text: "Next",
                        onPressed: isLoading ? null : register,
                      ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AppLoginOrRegister(isLogin: false),
    );
  }

  @override
  void dispose() {
    userNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
