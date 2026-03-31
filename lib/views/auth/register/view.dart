import 'package:cosmetics_app/views/auth/register/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/ui/app_button.dart';
import '../../../core/ui/app_image.dart';
import '../../../core/ui/app_input.dart';
import '../../../core/ui/app_login_or_register.dart';


class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Builder(

          builder: (context) {
            final cubit = BlocProvider.of<RegisterCubit>(context);

            return Scaffold(
              body: SafeArea(
                child: Form(
                  key: cubit.formKey,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                        horizontal: 14.w, vertical: 10.h),
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
                        AppInput(controller: cubit.userNameController,
                            label: "Your Name"),
                        AppInput(
                          controller: cubit.phoneController,
                          withCountryCode: true,
                          label: "Phone Number",
                          onCountryCodeChanged: (value) {
                            cubit.selectedCountryCode = value;
                          },
                          keyboardType: TextInputType.number,
                        ),
                        AppInput(
                          controller: cubit.emailController,
                          label: "Email Address",
                          keyboardType: TextInputType.emailAddress,
                        ),
                        AppInput(
                          controller: cubit.passwordController,
                          isPassword: true,
                          label: "Create your password",
                        ),
                        AppInput(
                          controller: cubit.confirmPasswordController,
                          isPassword: true,
                          label: "Confirm password",
                        ),
                        SizedBox(height: 40.h),
                        cubit.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : BlocBuilder<RegisterCubit, RegisterState>(
                          builder: (context, state) {
                            return AppButton(
                              text: "Next",
                              onPressed: state is RegisterLoading ? null : cubit
                                  .register,
                            );
                          },
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
      ),
    );
  }


}
