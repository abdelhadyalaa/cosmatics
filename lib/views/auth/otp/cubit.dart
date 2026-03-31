import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/end_points.dart';

part 'states.dart';

class OTPCubit extends Cubit<OTPState> {
  OTPCubit() : super(OTPInitial());

  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();

  /// إعادة إرسال الكود
  Future<void> resendOtp(String phone) async {
    emit(OTPResendLoading());
    try {
      final response = await DioHelper.postData(
        EndPoints.resendOtp,
        data: {"phoneNumber": phone.trim(), "countryCode": "+20"},
      );

      final message = response?["message"] ?? "A new code has been sent";

      emit(OTPResendSuccess(message));
    } on DioException catch (e) {
      final msg = e.response?.data["message"] ?? "Failed to resend code";
      emit(OTPError(msg));
    }
  }

  /// تحقق من الكود
  Future<void> verifyOtp({
    required String phone,
    required bool isFromCreateAccount,
  }) async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    emit(OTPLoading());
    try {
      final response = await DioHelper.postData(
        EndPoints.verifyOtp,
        data: {
          "otpCode": otpController.text.trim(),
          "phoneNumber": phone.trim(),
          "countryCode": "+20",
        },
      );

      final message = response?["message"] ?? "OTP Verified";

      emit(OTPSuccess(
        message: message,
        isFromCreateAccount: isFromCreateAccount,
        phone: phone,
      ));
    } on DioException catch (e) {
      final msg = e.response?.data["message"] ?? "Invalid code, try again";
      emit(OTPError(msg));
    }
  }

  @override
  Future<void> close() {
    otpController.dispose();
    return super.close();
  }
}