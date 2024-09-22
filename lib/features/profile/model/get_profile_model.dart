class GetProfileModel {
  int? statusCode;
  int? responseCode;
  String? message;
  Null? data;
  List<Data1>? data1;
  Null? userCode;
  int? status;
  int? mobileOTP;
  int? emailOTP;
  Null? userID;

  GetProfileModel(
      {this.statusCode,
      this.responseCode,
      this.message,
      this.data,
      this.data1,
      this.userCode,
      this.status,
      this.mobileOTP,
      this.emailOTP,
      this.userID});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    responseCode = json['responseCode'];
    message = json['message'];
    data = json['data'];
    if (json['data1'] != null) {
      data1 = <Data1>[];
      json['data1'].forEach((v) {
        data1!.add(new Data1.fromJson(v));
      });
    }
    userCode = json['userCode'];
    status = json['status'];
    mobileOTP = json['mobileOTP'];
    emailOTP = json['emailOTP'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['responseCode'] = this.responseCode;
    data['message'] = this.message;
    data['data'] = this.data;
    if (this.data1 != null) {
      data['data1'] = this.data1!.map((v) => v.toJson()).toList();
    }
    data['userCode'] = this.userCode;
    data['status'] = this.status;
    data['mobileOTP'] = this.mobileOTP;
    data['emailOTP'] = this.emailOTP;
    data['userID'] = this.userID;
    return data;
  }
}

class Data1 {
  String? sUserCode;
  String? sUserMobileNo;
  String? sUserName;
  String? sDriverLicense;
  String? sDriverLicenseExpDate;

  Data1(
      {this.sUserCode,
      this.sUserMobileNo,
      this.sUserName,
      this.sDriverLicense,
      this.sDriverLicenseExpDate});

  Data1.fromJson(Map<String, dynamic> json) {
    sUserCode = json['sUserCode'];
    sUserMobileNo = json['sUserMobileNo'];
    sUserName = json['sUserName'];
    sDriverLicense = json['sDriverLicense'];
    sDriverLicenseExpDate = json['sDriverLicenseExpDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sUserCode'] = this.sUserCode;
    data['sUserMobileNo'] = this.sUserMobileNo;
    data['sUserName'] = this.sUserName;
    data['sDriverLicense'] = this.sDriverLicense;
    data['sDriverLicenseExpDate'] = this.sDriverLicenseExpDate;
    return data;
  }
}
