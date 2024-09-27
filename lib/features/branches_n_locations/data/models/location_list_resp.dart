class LocationListResp {
  int? statusCode;
  int? responseCode;
  String? message;
  String? data;
  List<Data1>? data1;
  String? userCode;
  int? status;
  int? mobileOTP;
  int? emailOTP;
  String? userID;

  LocationListResp(
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

  LocationListResp.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    responseCode = json['responseCode'];
    message = json['message'];
    data = json['data'];
    if (json['data1'] != null) {
      data1 = <Data1>[];
      json['data1'].forEach((v) {
        data1!.add(Data1.fromJson(v));
      });
    }
    userCode = json['userCode'];
    status = json['status'];
    mobileOTP = json['mobileOTP'];
    emailOTP = json['emailOTP'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['responseCode'] = responseCode;
    data['message'] = message;
    data['data'] = this.data;
    if (data1 != null) {
      data['data1'] = data1!.map((v) => v.toJson()).toList();
    }
    data['userCode'] = userCode;
    data['status'] = status;
    data['mobileOTP'] = mobileOTP;
    data['emailOTP'] = emailOTP;
    data['userID'] = userID;
    return data;
  }
}

class Data1 {
  int? iPKCustEnum;
  String? sName;

  Data1({this.iPKCustEnum, this.sName});

  Data1.fromJson(Map<String, dynamic> json) {
    iPKCustEnum = json['iPK_CustEnum'];
    sName = json['sName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iPK_CustEnum'] = iPKCustEnum;
    data['sName'] = sName;
    return data;
  }
}
