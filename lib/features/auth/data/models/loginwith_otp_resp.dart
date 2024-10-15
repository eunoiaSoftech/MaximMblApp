class LoginWithOTPResp {
  int? statusCode;
  int? responseCode;
  String? message;
  String? data;
  List<Data1>? data1;
  Null? userCode;
  int? status;
  int? mobileOTP;
  int? emailOTP;
  Null? userID;
  List<Rights>? rights;

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
        this.userID,
        this.rights});

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
    userCode = json['userCode'];
    status = json['status'];
    mobileOTP = json['mobileOTP'];
    emailOTP = json['emailOTP'];
    userID = json['userID'];
    if (json['rights'] != null) {
      rights = <Rights>[];
      json['rights'].forEach((v) {
        rights!.add(new Rights.fromJson(v));
      });
    }
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
    if (this.rights != null) {
      data['rights'] = this.rights!.map((v) => v.toJson()).toList();
    }
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
  int? iFkUserType;
  Null? sLicsNumber;
  Null? licExp;

  Data1(
      {this.iBranchFlag,
        this.otp,
        this.sUSRCode,
        this.name,
        this.sEmail,
        this.sPhone,
        this.iPKUSRID,
        this.message,
        this.iFkUserType,
        this.sLicsNumber,
        this.licExp});

  Data1.fromJson(Map<String, dynamic> json) {
    iBranchFlag = json['iBranchFlag'];
    otp = json['otp'];
    sUSRCode = json['sUSRCode'];
    name = json['name'];
    sEmail = json['sEmail'];
    sPhone = json['sPhone'];
    iPKUSRID = json['iPK_USRID'];
    message = json['message'];
    iFkUserType = json['iFk_UserType'];
    sLicsNumber = json['sLicsNumber'];
    licExp = json['licExp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iBranchFlag'] = this.iBranchFlag;
    data['otp'] = this.otp;
    data['sUSRCode'] = this.sUSRCode;
    data['name'] = this.name;
    data['sEmail'] = this.sEmail;
    data['sPhone'] = this.sPhone;
    data['iPK_USRID'] = this.iPKUSRID;
    data['message'] = this.message;
    data['iFk_UserType'] = this.iFkUserType;
    data['sLicsNumber'] = this.sLicsNumber;
    data['licExp'] = this.licExp;
    return data;
  }
}

class Rights {
  int? iSubMenuId;
  String? sSubmenuName;
  int? isRights;

  Rights({this.iSubMenuId, this.sSubmenuName, this.isRights});

  Rights.fromJson(Map<String, dynamic> json) {
    iSubMenuId = json['iSubMenuId'];
    sSubmenuName = json['sSubmenuName'];
    isRights = json['isRights'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iSubMenuId'] = this.iSubMenuId;
    data['sSubmenuName'] = this.sSubmenuName;
    data['isRights'] = this.isRights;
    return data;
  }
}
