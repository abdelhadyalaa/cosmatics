import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/end_points.dart';
import '../../../core/logic/helper_methods.dart';
import '../otp/view.dart';
import 'package:flutter/material.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;
  String selectedCountryCode = "+20";

  void register() async {
    if (formKey.currentState?.validate() ?? false) {
      if (passwordController.text != confirmPasswordController.text) {
        return;
      }
      emit(RegisterLoading());

      try {
        final response = await DioHelper.postData(
          EndPoints.register,
          data: {
            "username": userNameController.text,
            "countryCode": selectedCountryCode,
            "phoneNumber": phoneController.text,
            "email": emailController.text,
            "password": passwordController.text,
          },
        );

        if (response != null) {
          emit(RegisterSuccess());
          goTo(
            page: OtpView(
              phone: phoneController.text,
              isFromCreateAccount: true,
            ),
            canPop: false,
          );
        }
      } on DioException catch (e) {
        String errorMessage =
            e.response?.data["message"] ?? "حدث خطأ ما، حاول لاحقاً";
        emit(RegisterError(errorMessage));
      }
    }
  }
}
