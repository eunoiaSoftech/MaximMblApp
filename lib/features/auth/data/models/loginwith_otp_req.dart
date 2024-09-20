class LoginWithOTPRequestModel {
  String? username;
  String? phone;

  LoginWithOTPRequestModel({
    required this.username,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'sUsername': username,
      'PhNo': phone,
    };
  }
}
