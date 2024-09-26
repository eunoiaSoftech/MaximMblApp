class ApprovalsRequestModel {
  final int userId;
  final int branchId;
  final int status;


  ApprovalsRequestModel({
    required this.userId,
    required this.branchId,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'fk_UserId': userId,
      'fk_BranchId': branchId,
      'iFk_AprroveId': status,
    };
  }
}
