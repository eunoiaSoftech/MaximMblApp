class User {
  String? name;
  String? phone;
  String? email;
  int? userId;
  int? branchId;
  int? userType;

  User(
      {this.phone,
      this.userId,
      this.branchId,
      this.name,
      this.email,
      this.userType});

  User.fromJson(Map<String, dynamic> map) {
    name = map["name"];
    phone = map["phone"];
    email = map["email"];
    userId = map["userId"];
    branchId = map["branchId"];
    userType = map["userType"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['userId'] = userId;
    data['branchId'] = branchId;
    data['userType'] = userType;
    return data;
  }
}
