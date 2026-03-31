import 'package:cosmetics_app/views/auth/login/model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/cache_helper.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/end_points.dart';
import '../../../core/logic/helper_methods.dart';
import '../../home/view.dart';

class LoginCubit extends Cubit<DataState> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController(text: "01016225354");
  final passwordController = TextEditingController(text: "123123123");

  String selectedCountryCode = "+20";
  DataState state2=DataState.initial;

  LoginCubit():super(DataState.initial);

  void login() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        emit(DataState.loading);
        final response = await DioHelper.postData(
          EndPoints.login,
          data: {
            "phoneNumber": phoneController.text,
            "password": passwordController.text,
            "countryCode": selectedCountryCode,
          },
        );

        if (response != null && response["token"] != null) {

          emit(DataState.success);

          final model = LoginModel.fromJson(response);
          String token = response["token"];
          print("Success! Token is: $token");
          await CashHelper.saveUserData(model);
          DioHelper().setToken(token);

          goTo(page: const HomeView(), canPop: false);
        }
      } on DioException catch (e) {
        emit(DataState.failed);


        String errorMessage =
            e.response?.data["message"] ?? "حدث خطأ ما، حاول لاحقاً";
        showMsg(errorMessage);
      }
    }
  }
  void onCountryCodeChanged (value) {
    selectedCountryCode = value;
  }
}


