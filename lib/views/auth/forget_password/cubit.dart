import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/end_points.dart';

part 'states.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  Future<void> sendCode() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    emit(ForgetPasswordLoading());

    try {
      final response = await DioHelper.postData(
        EndPoints.forgetPassword,
        data: {
          "countryCode": "+20",
          "phoneNumber": phoneController.text.trim(),
        },
      );

      final message = response?["message"] ?? "OTP Sent";

      emit(ForgetPasswordSuccess(message));

    } on DioException catch (e) {
      final msg =
          e.response?.data["message"] ?? "Phone number not found";

      emit(ForgetPasswordError(msg));
    }
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    return super.close();
  }
}