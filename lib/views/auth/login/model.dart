
class LoginModel {
  late final String token;
  late final UserModel user;

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = UserModel.fromJson(json['user']);
  }
}

class UserModel {
  late final int id;
  late final String username;
  late final String email;
  late final String phoneNumber;
  late final String countryCode;
  late final String role;
  late final String profilePhotoUrl;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    username = json['username'] ?? "";
    email = json['email'] ?? "";
    phoneNumber = json['phoneNumber'] ?? "";
    countryCode = json['countryCode'] ?? "";
    role = json['role'] ?? "";
    profilePhotoUrl = json['profilePhotoUrl'] ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYO-RnslVwrpn-JSpQJ_MjYOzZrAa5WBIaoA&s";
  }
}