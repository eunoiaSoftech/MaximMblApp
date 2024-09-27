import 'package:get_storage/get_storage.dart';

class AppStorage {
  final _box = GetStorage();

  final _userID = "user_id";
  final _branchID = "branch_id";
  final _phone = "phone";
  final _userDetails = "user_details";
  final _onBoardingKey = "on_boarding"; // Change the key to a string

  /// read
  int get getUserId => _box.read(_userID);
  int get getBranchId => _box.read(_branchID);
  String get getPhone => _box.read(_phone); // Updated to String
  bool get onBoarding =>
      _box.read(_onBoardingKey) ?? false; // Updated to use string key
  dynamic get getUserDetails => _box.read(_userDetails);

  /// write
  saveUserId(int userId) => _box.write(_userID, userId);
  saveBranchId(int branchId) => _box.write(_branchID, branchId);
  savePhone(String phone) => _box.write(_phone, phone);
  saveOnBoarding(bool onBoarding) =>
      _box.write(_onBoardingKey, onBoarding); // Updated to use string key
  saveUserDetails(Map<String, dynamic> userDetails) =>
      _box.write(_userDetails, userDetails);

  /// clear
  void clear() async {
    await _box.erase();
  }
}
