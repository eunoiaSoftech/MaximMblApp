class ApprovalsListResp {
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

  ApprovalsListResp(
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

  ApprovalsListResp.fromJson(Map<String, dynamic> json) {
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
  String? poNo;
  String? poDate;
  String? supplierName;
  Null? itemList;

  Data1({this.poNo, this.poDate, this.supplierName, this.itemList});

  Data1.fromJson(Map<String, dynamic> json) {
    poNo = json['poNo'];
    poDate = json['poDate'];
    supplierName = json['supplierName'];
    itemList = json['itemList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['poNo'] = this.poNo;
    data['poDate'] = this.poDate;
    data['supplierName'] = this.supplierName;
    data['itemList'] = this.itemList;
    return data;
  }
}
