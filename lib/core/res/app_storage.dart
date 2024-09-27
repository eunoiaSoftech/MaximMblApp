import 'package:get_storage/get_storage.dart';
import 'package:logistics_app/core/shared/data/user.dart';

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
  int get getPhone => _box.read(_phone);
  dynamic get getUserDetails => _box.read(_userDetails);
  bool get onBoarding =>
      _box.read(_onBoardingKey) ?? false; // Updated to use string key

  /// write
  saveUserId(int userid) => _box.write(_userID, userid);
  saveBranchId(int branchid) => _box.write(_branchID, branchid);
  savePhone(String phone) => _box.write(_phone, phone);
  saveUserDetails(Map<String, dynamic> userDetails) => _box.write(_userDetails, userDetails);
  saveOnBoarding(bool onBoarding) =>
      _box.write(_onBoardingKey, onBoarding); // Updated to use string key


  void clear()async {
    await _box.erase();
  }
}
