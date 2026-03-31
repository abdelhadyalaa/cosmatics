import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/end_points.dart';

part 'states.dart';

class NewPasswordCubit extends Cubit<NewPasswordStates> {
  NewPasswordCubit(this.phone) : super(NewPasswordInitial());

  final String phone;

  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) return;

    if (passwordController.text != confirmPasswordController.text) {
      emit(NewPasswordError("Passwords do not match"));
      return;
    }

    emit(NewPasswordLoading());

    try {
      final response = await DioHelper.postData(
        EndPoints.resetPassword,
        data: {
          "countryCode": "+20",
          "phoneNumber": phone,
          "newPassword": passwordController.text,
          "confirmPassword": confirmPasswordController.text,
        },
      );

      if (response != null) {
        emit(NewPasswordSuccess());
      }
    } on DioException catch (e) {
      final msg =
          e.response?.data["message"] ?? "Failed to reset password";

      emit(NewPasswordError(msg));
    }
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}