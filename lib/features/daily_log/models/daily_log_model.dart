class DailyLogModel {
  int srNo;
  String lrNo;

  DailyLogModel({required this.srNo, required this.lrNo});
}

List<DailyLogModel> vehicleList = [
  DailyLogModel(srNo: 1, lrNo: "GJ-01-HM-0012"),
  DailyLogModel(srNo: 2, lrNo: "GJ-01-HM-3326"),
  DailyLogModel(srNo: 3, lrNo: "GJ-01-HM-9802"),
  DailyLogModel(srNo: 4, lrNo: "GJ-01-HM-1243"),
  DailyLogModel(srNo: 5, lrNo: "GJ-01-HM-0012"),
];
