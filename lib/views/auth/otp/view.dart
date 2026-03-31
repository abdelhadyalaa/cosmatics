import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/ui/app_back.dart';
import '../../../core/ui/app_button.dart';
import '../../../core/ui/app_image.dart';
import '../../../core/ui/app_verify_code.dart';
import '../../../core/ui/app_resend_otp.dart';
import '../success_dialog.dart';
import '../new_password/view.dart';
import 'cubit.dart';

class OtpView extends StatelessWidget {
  final String phone;
  final bool isFromCreateAccount;

  const OtpView({
    super.key,
    this.isFromCreateAccount = false,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OTPCubit(),
      child: BlocListener<OTPCubit, OTPState>(
        listener: (context, state) {
          if (state is OTPError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }

          if (state is OTPResendSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          }

          if (state is OTPSuccess) {
            if (state.isFromCreateAccount) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const SuccessDialog(isFromCreateAccount: true),
              );
            } else {
              goTo(page: CreatePasswordView(phone: state.phone));
            }
          }
        },
        child: _OtpBody(phone: phone, isFromCreateAccount: isFromCreateAccount),
      ),
    );
  }
}

class _OtpBody extends StatefulWidget {
  final String phone;
  final bool isFromCreateAccount;

  const _OtpBody({required this.phone, required this.isFromCreateAccount});

  @override
  State<_OtpBody> createState() => _OtpBodyState();
}

class _OtpBodyState extends State<_OtpBody> {
  late final OTPCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<OTPCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: cubit.formKey,
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
                AppVerifyCode(controller: cubit.otpController),
                SizedBox(height: 42.h),

                AppResendOtp(onResend: () => cubit.resendOtp(widget.phone)),

                SizedBox(height: 20.h),
                BlocBuilder<OTPCubit, OTPState>(
                  builder: (context, state) {
                    final isLoading = state is OTPLoading;
                    return isLoading
                        ? Center(child: CircularProgressIndicator())
                        : AppButton(
                            text: "Done",
                            onPressed: () => cubit.verifyOtp(
                              phone: widget.phone,
                              isFromCreateAccount: widget.isFromCreateAccount,
                            ),
                          );
                  },
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
    cubit.otpController.dispose();
    super.dispose();
  }
}
