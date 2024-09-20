class LoginWithOTPResp {
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

  LoginWithOTPResp(
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

  LoginWithOTPResp.fromJson(Map<String, dynamic> json) {
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
    userCode = json['userCode'].toString();
    status = json['status'];
    mobileOTP = json['mobileOTP'];
    emailOTP = json['emailOTP'];
    userID = json['userID'].toString();
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
  int? iBranchFlag;
  String? otp;
  String? sUSRCode;
  String? name;
  String? sEmail;
  String? sPhone;
  int? iPKUSRID;
  String? message;

  Data1(
      {this.otp,
      this.iBranchFlag,
      this.sUSRCode,
      this.name,
      this.sEmail,
      this.sPhone,
      this.iPKUSRID,
      this.message});

  Data1.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    sUSRCode = json['sUSRCode'];
    name = json['name'];
    sEmail = json['sEmail'];
    sPhone = json['sPhone'];
    iPKUSRID = json['iPK_USRID'];
    message = json['message'];
    iBranchFlag = json['iBranchFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['sUSRCode'] = this.sUSRCode;
    data['name'] = this.name;
    data['sEmail'] = this.sEmail;
    data['sPhone'] = this.sPhone;
    data['iPK_USRID'] = this.iPKUSRID;
    data['message'] = this.message;
    data['iBranchFlag'] = this.iBranchFlag;
    return data;
  }
}
