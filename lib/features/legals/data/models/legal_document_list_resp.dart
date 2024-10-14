class LegalDocumentListResp {
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
  String? rights;

  LegalDocumentListResp(
      {this.statusCode,
      this.responseCode,
      this.message,
      this.data,
      this.data1,
      this.userCode,
      this.status,
      this.mobileOTP,
      this.emailOTP,
      this.userID,
      this.rights});

  LegalDocumentListResp.fromJson(Map<String, dynamic> json) {
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
    rights = json['rights'];
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
    data['rights'] = rights;
    return data;
  }
}

class Data1 {
  String? sName;
  int? noOfDays;
  String? sExpiryDate;
  int? iFkDocTypeId;

  Data1({this.sName, this.noOfDays, this.sExpiryDate, this.iFkDocTypeId});

  Data1.fromJson(Map<String, dynamic> json) {
    sName = json['sName'];
    noOfDays = json['noOfDays'];
    sExpiryDate = json['sExpiryDate'];
    iFkDocTypeId = json['iFk_DocTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sName'] = sName;
    data['noOfDays'] = noOfDays;
    data['sExpiryDate'] = sExpiryDate;
    data['iFk_DocTypeId'] = iFkDocTypeId;
    return data;
  }
}
