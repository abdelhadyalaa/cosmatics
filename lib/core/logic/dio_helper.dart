import 'package:cosmetics_app/core/logic/cache_helper.dart';
import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:dio/dio.dart';
import '../../views/auth/login/view.dart';
import 'end_points.dart';

enum DataState { initial,loading, success, failed }

class DioHelper {
  static final dio = Dio()
    ..options.baseUrl = EndPoints.baseUrl
    ..options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = CashHelper.token;
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            await CashHelper.removeUserDate();
            goToLogin();
          }
          return handler.next(error);
        },
      ),
    );

  static Future postData(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException {
      rethrow;
    }
  }

  static Future deleteData(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException {
      rethrow;
    }
  }

  void setToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  static Future getData(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (ex) {
      print("Error in getData: ${ex.response?.statusMessage}");
      rethrow;
    }
  }

  static Future putData(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException {
      rethrow;
    }
  }

  static void goToLogin() {
    goTo(page: LoginView(), canPop: false);
  }
}
