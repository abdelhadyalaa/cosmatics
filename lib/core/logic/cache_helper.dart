import 'package:shared_preferences/shared_preferences.dart';

import '../../views/auth/login/model.dart';

class CashHelper {
  static late final SharedPreferences _pref;

  static Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static Future<void> setData(String key, dynamic value) async {
    await _pref.setString(key, value);
  }

  static Future<void> setIsNotFirstTime() async {
    await _pref.setBool("isFirstTime", false);
  }

  static bool get isFirstTime {
    return _pref.getBool("isFirstTime") ?? true;
  }

  static bool get isAuth {
    return token.isNotEmpty;
  }

  static String get token {
    return (_pref.getString("token") ?? "");
  }



  static Future<void> removeUserDate() async {
    await _pref.remove("token");
    await _pref.remove("id");
    await _pref.remove("username");
    await _pref.remove("email");
    await _pref.remove("phoneNumber");
    await _pref.remove("countryCode");
    await _pref.remove("role");
    await _pref.remove("profilePhotoUrl");
  }

  static Future<void> saveUserData(LoginModel model) async {
    await _pref.setString("token", model.token);
    await _pref.setInt("id", model.user.id);
    await _pref.setString("username", model.user.username);
    await _pref.setString("email", model.user.email);
    await _pref.setString("phoneNumber", model.user.phoneNumber);
    await _pref.setString("countryCode", model.user.countryCode);
    await _pref.setString("role", model.user.role);
    await _pref.setString("profilePhotoUrl", model.user.profilePhotoUrl);
  }
}
