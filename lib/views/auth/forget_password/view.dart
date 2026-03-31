import 'package:cosmetics_app/core/ui/app_back.dart';
import 'package:cosmetics_app/views/auth/forget_password/cubit.dart';
import 'package:cosmetics_app/views/auth/otp/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/ui/app_button.dart';
import '../../../core/ui/app_image.dart';
import '../../../core/ui/app_input.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgetPasswordCubit(),
      child: const ForgetPasswordBody(),
    );
  }
}

class ForgetPasswordBody extends StatelessWidget {
  const ForgetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();

    return Scaffold(
      body: SafeArea(
        child: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
          listener: (context, state) {


            if (state is ForgetPasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OtpView(
                    phone: cubit.phoneController.text,
                    isFromCreateAccount: false,
                  ),
                ),
              );
            }


            if (state is ForgetPasswordError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },

          child: Form(
            key: cubit.formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(14.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AppBack(),
                  SizedBox(height: 48.h),

                  Center(
                    child: AppImage(
                      image: "logo.png",
                      height: 64.h,
                      width: 64.w,
                    ),
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
                        color: const Color(0xff8E8EA9),
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  AppInput(
                    controller: cubit.phoneController,
                    keyboardType: TextInputType.number,
                    label: "Phone Number",
                    withCountryCode: true,
                    bottomSpace: 56.h,
                  ),

                  SizedBox(height: 44.h),

                  BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                    builder: (context, state) {
                      final isLoading =
                      state is ForgetPasswordLoading;

                      return AppButton(
                        text: isLoading ? "Sending..." : "Next",
                        onPressed: isLoading
                            ? null
                            : () => context
                            .read<ForgetPasswordCubit>()
                            .sendCode(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}