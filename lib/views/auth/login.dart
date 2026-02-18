import 'package:cosmetics_app/core/logic/cache_helper.dart';
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

  String selectedCountryCode = "+20";
  DataState? state;

  void login() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        state = DataState.loading;
        final response = await DioHelper().postData(
          EndPoints.login,
          data: {
            "phoneNumber": phoneController.text,
            "password": passwordController.text,
            "countryCode": selectedCountryCode,
          },
        );

        if (response != null && response["token"] != null) {
          state = DataState.success;
          final model = UserData.fromJson(response);
          String token = response["token"];
          print("Success! Token is: $token");
          await CashHelper.saveUserData(model);

          goTo(page: const HomeView(), canPop: false);
        }
      } on DioException catch (e) {
        state = DataState.failed;

        String errorMessage =
            e.response?.data["message"] ?? "حدث خطأ ما، حاول لاحقاً";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
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
                  child: Text(
                    "Login Now",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
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
                state == DataState.loading
                    ? Center(child: CircularProgressIndicator())
                    : AppButton(
                        text: "Login",
                        onPressed: state == DataState.loading ? null : login,
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

class UserData {
  late final String token;
  late final UserModel user;

  UserData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = UserModel.fromJson(json['user']);
  }
}

class UserModel {
  late final int id;
  late final String username;
  late final String email;
  late final String phoneNumber;
  late final String countryCode;
  late final String role;
  late final String profilePhotoUrl;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    username = json['username'] ?? "";
    email = json['email'] ?? "";
    phoneNumber = json['phoneNumber'] ?? "";
    countryCode = json['countryCode'] ?? "";
    role = json['role'] ?? "";
    profilePhotoUrl = json['profilePhotoUrl'] ?? "";
  }
}
