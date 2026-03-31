import 'package:cosmetics_app/views/auth/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/ui/app_button.dart';
import '../../../core/ui/app_image.dart';
import '../../../core/ui/app_input.dart';
import 'cubit.dart';

class CreatePasswordView extends StatelessWidget {
  final String phone;

  const CreatePasswordView({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewPasswordCubit(phone),
      child: const CreatePasswordBody(),
    );
  }
}

class CreatePasswordBody extends StatelessWidget {
  const CreatePasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NewPasswordCubit>();

    return Scaffold(
      body: SafeArea(
        child: BlocListener<NewPasswordCubit, NewPasswordStates>(
          listener: (context, state) {


            if (state is NewPasswordSuccess) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const SuccessDialog(
                  isFromCreateAccount: false,
                ),
              );
            }


            if (state is NewPasswordError) {
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
              padding: EdgeInsets.all(14.r).copyWith(top: 48.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: AppImage(
                      image: "splash.png",
                      height: 64.h,
                      width: 64.w,
                    ),
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
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff8E8EA9),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  AppInput(
                    controller: cubit.passwordController,
                    label: "New password",
                    isPassword: true,
                  ),

                  AppInput(
                    controller: cubit.confirmPasswordController,
                    label: "Confirm password",
                    isPassword: true,
                    bottomSpace: 70.h,
                  ),


                  BlocBuilder<NewPasswordCubit, NewPasswordStates>(
                    builder: (context, state) {
                      final isLoading =
                      state is NewPasswordLoading;

                      return isLoading
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : AppButton(
                        text: "Confirm",
                        onPressed: () => context
                            .read<NewPasswordCubit>()
                            .resetPassword(),
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