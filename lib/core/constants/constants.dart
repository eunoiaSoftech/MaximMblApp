class Urls {
  static const String _baseUrl = "http://47.247.181.6:8089/api";
  static const String login = "$_baseUrl/User/userLogin";
  static const String loginWithOTP = "$_baseUrl/Api/WAOTP";
  static const String branchList = "$_baseUrl/Branch/GetBranchMasterUserwise";
  static const String locationList = "$_baseUrl/api/GetLocListM";
  static const String vehicleList = "$_baseUrl/Api/GetVehicleDetailsM";
  static const String dailyLogVehicleList = "$_baseUrl/Api/GetOtherVehicleDetailsM";
  static const String approvalsListList = "$_baseUrl/Api/PoApprovalM";
  static const String getLegalDocumentList = "$_baseUrl/api/GetLegalDocument";
  static const String getLocationList = "$_baseUrl/api/GetLocListM";
  static const String trips = "$_baseUrl/api/GetMyTrips?Fk_DriverId=2806";
  static const String postDailyLog = "$_baseUrl/api/SaveDailyLog";

// static const String apiKey = "58a8591c9aa4421ca6d73805240105";
}
