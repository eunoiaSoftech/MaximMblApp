class LoginRequestModel {
  final String username;
  final String password;
  final String email;
  final int branchId;

  LoginRequestModel({
    required this.username,
    required this.password,
    required this.email,
    required this.branchId,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'branchId': branchId,
    };
  }
}
