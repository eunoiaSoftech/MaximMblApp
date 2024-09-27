import 'dart:convert';
import 'dart:developer';
import 'package:logistics_app/core/constants/constants.dart';
import 'package:logistics_app/core/shared/data/network/api_service/base_api_service.dart';
import 'package:logistics_app/features/branches_n_locations/data/models/location_list_resp.dart';

class LocationListApiService extends BaseApiService {
  LocationListApiService({httpClient}) : super(httpClient);

  Future<LocationListResp> generateLocationList(
      int branchId, int userId) async {
    // Building query
    final uri = "${Urls.getLocationList}?Fk_BranchId=$branchId&UserId=$userId";
    // Request body
    // final body = jsonEncode({});
    final headers = {
      // HttpHeaders.authorizationHeader: "Bearer ${getAuthToken()}",
      // "mobile_type":
      //     defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
      // "user": SharedPrefs.getString(keyUserData),
      // "client": 1,
      // "user_login_branch": SharedPrefs.getInt(keyBranch) ?? 0,
    };
    log("""
    
    URI ::: $uri
    BODY ::: 
    HEADERS ::: $headers
    
    """);
    try {
    // Building request
    final request = httpClient.get(
      uri.toString(),
      // options: getOptions(headers: headers),
      // data: body,
    );

    // Sending request
    final response = await send(request);
    log("""
    
    RESPONSE ::: ${response.data}
    
    """);
    return LocationListResp.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
