class UserModel {
  late final int id;
  late final String username;
  late final String email;
  late final String role;
  late final String phoneNumber;
  late final String countryCode;
  late final String profilePhotoUrl;

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int? ?? 0,
        username = json['username'] as String? ?? '',
        email = json['email'] as String? ?? '',
        role = json['role'] as String? ?? '',
        phoneNumber = json['phoneNumber'] as String? ?? '',
        countryCode = json['countryCode'] as String? ?? '',
        profilePhotoUrl = json['profilePhotoUrl'] as String? ?? '';
}
