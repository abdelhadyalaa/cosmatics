import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../core/ui/app_button.dart';
import '../../../core/ui/app_image.dart';
import '../../../core/ui/app_input.dart';
import '../../../core/ui/app_login_or_register.dart';
import '../forget_password/view.dart';
import 'cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => LoginCubit(),
  child: Builder(
    builder: (context) {
      final cubit =BlocProvider.of<LoginCubit>(context);

      return Scaffold(
            body: SafeArea(
              child: Form(
                key:cubit.formKey,
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
                        controller: cubit.phoneController,
                        label: "Phone Number",
                        withCountryCode: true,
                        onCountryCodeChanged:cubit.onCountryCodeChanged,
                        keyboardType: TextInputType.number,
                      ),
                      AppInput(
                        controller: cubit.passwordController,
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
                      cubit.state == DataState.loading
                          ? Center(child: CircularProgressIndicator())
                          : BlocBuilder<LoginCubit,DataState>(
                            builder: (context,state) {
                              return AppButton(
                                  text: "Login",
                                  onPressed: cubit.state == DataState.loading ? null : cubit.login,
                                );
                            }
                          ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: const AppLoginOrRegister(),
          );
    }
  ),
);
  }
}

