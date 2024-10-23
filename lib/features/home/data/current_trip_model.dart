class CurrentTrip {
  String? lrNo;
  String? lrDate;
  String? transitTime;
  String? totalKm;
  String? routeName;
  String? product;
  int? pkLrId;

  CurrentTrip(
      {this.lrNo,
        this.lrDate,
        this.transitTime,
        this.totalKm,
        this.routeName,
        this.product,
        this.pkLrId});

  CurrentTrip.fromJson(Map<String, dynamic> json) {
    lrNo = json['lrNo'];
    lrDate = json['lrDate'];
    transitTime = json['transitTime'];
    totalKm = json['totalKm'];
    routeName = json['routeName'];
    product = json['product'];
    pkLrId = json['pk_LrId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lrNo'] = this.lrNo;
    data['lrDate'] = this.lrDate;
    data['transitTime'] = this.transitTime;
    data['totalKm'] = this.totalKm;
    data['routeName'] = this.routeName;
    data['product'] = this.product;
    data['pk_LrId'] = this.pkLrId;
    return data;
  }
}
