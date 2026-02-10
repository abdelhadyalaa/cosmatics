import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/logic/dio_helper.dart';
import '../../core/logic/end_points.dart';
import '../../core/ui/app_button.dart';
import '../../core/ui/app_image.dart';
import 'package:dio/dio.dart';
import '../../core/ui/app_input.dart';
import '../../core/ui/app_login_or_register.dart';
import '../home/view.dart';
import 'forget_password.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  String selectedCountryCode = "+20";
  void login() async {
    if (formKey.currentState?.validate() ?? false) {
      setState(() => isLoading = true);

      try {
        final response = await DioHelper(dio: Dio()).postData(
          EndPoints.login,
          data: {
            "phoneNumber": phoneController.text,
            "password": passwordController.text,
            "countryCode": selectedCountryCode,
          },
        );

        if (response != null && response["token"] != null) {

          String token = response["token"];
          print("Success! Token is: $token");

          goTo(page: const HomeView(), canPop: false);
        }
      } on DioException catch (e) {
        String errorMessage = e.response?.data["message"] ?? "حدث خطأ ما، حاول لاحقاً";
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
            padding: EdgeInsets.all(14.r).copyWith(top: 48.h, bottom: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppImage(image: "login_img.png", height: 277.h, width: 284.w),
                SizedBox(height: 24.h),
                const Center(
                  child: Text("Login Now", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 24.h),
                AppInput(
                  controller: phoneController,
                  label: "Phone Number",
                  withCountryCode: true,
                  onCountryCodeChanged: (code) {
                    selectedCountryCode = code;
                  },
                  keyboardType: TextInputType.number,
                ),
                AppInput(
                  controller: passwordController,
                  label: "Your Password",
                  isPassword: true,
                  bottomSpace: 0,
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: () => goTo(page: const ForgetPasswordView()),
                    child: const Text("Forget Password?"),
                  ),
                ),
                SizedBox(height: 44.h),
                isLoading ? Center(child: CircularProgressIndicator()) : AppButton(
                  text:"Login",
                  onPressed: isLoading ? null : login,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AppLoginOrRegister(),
    );
  }
}