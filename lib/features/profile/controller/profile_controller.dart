import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:logistics_app/core/res/app_storage.dart';
import 'package:logistics_app/features/profile/model/get_profile_model.dart';
import '../../../core/services/api_services.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;

  final ApiService _apiService = ApiService();
  var getProfileData = GetProfileModel().obs;
  var isDriver = false.obs;
  bool hasLoadedOnce = false;

  @override
  void onInit() {
    getProfile();
  }

  var response = Rx<Response?>(null);

  Future<void> getProfile() async {
    try {
      var userDetails = AppStorage().getUserDetails;

      log("_checkForUserSession() >> $userDetails");

      if (!hasLoadedOnce) {
        isLoading(true);
      }

      isDriver.value = userDetails['userType'] == "2" ? true : false;

      response.value = await _apiService.post(
          "/api/api/ProfileDetM?fk_UserId=${userDetails['userId']}&fk_UserTypeId=${userDetails['userType'] ?? ''}",
          {});

      if (response.value?.statusCode == 200) {
        hasLoadedOnce = true;
        print('Response Data: ${response.value?.data}');

        getProfileData.value =
            GetProfileModel.fromJson(jsonDecode(response.value?.data));

        if (getProfileData.value.data1 != null &&
            getProfileData.value.data1!.isNotEmpty) {
          print('check data ${getProfileData.value.data1}');
        } else {
          print('data1 is empty or null');
        }
        print('check data ${getProfileData.value.data1}');
        isLoading(false);
      } else {
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      return;
    }
  }
}
