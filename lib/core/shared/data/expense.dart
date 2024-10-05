class ExpenseMenuModel {
  int srNo;
  String name;
  String image;
  bool selected;

  ExpenseMenuModel(
      {required this.srNo,
      required this.name,
      required this.image,
      required this.selected});
}

List<ExpenseMenuModel> expenseMenuList = [
  ExpenseMenuModel(
      srNo: 1,
      name: 'Operation',
      image: "assets/images/new/truck_yellow.png",
      selected: false),
  ExpenseMenuModel(
      srNo: 2,
      name: 'Maintenance',
      image: "assets/images/new/garage.png",
      selected: false),
  ExpenseMenuModel(
      srNo: 3, name: 'Tyre', image: "assets/images/new/tyre.png", selected: false),
];

class ExpenseTypeModel {
  int srNo;
  String name;
  String image;
  bool selected;

  ExpenseTypeModel(
      {required this.srNo,
      required this.name,
      required this.image,
      required this.selected});
}

List<ExpenseMenuModel> expenseTypeList = [
  ExpenseMenuModel(
      srNo: 1, name: 'Meal', image: "assets/images/new/food_hot.png", selected: false),
  ExpenseMenuModel(
      srNo: 2, name: 'Toll', image: "assets/images/new/toll_pass.png", selected: false),
  ExpenseMenuModel(
      srNo: 3,
      name: 'Others',
      image: "assets/images/new/wallet_open.png",
      selected: false),
];

class TripsModel {
  int srNo;
  String lrNo;

  TripsModel({required this.srNo, required this.lrNo});
}

List<TripsModel> tripsList = [
  TripsModel(
      srNo: 1, lrNo: "TRIP/2425/89848-31-07-2024-0081684788-RAS-KGU-CLINKER"),
  TripsModel(
      srNo: 2, lrNo: "TRIP/2425/88482-28-07-2024-0081684267-RAS-KGU-CLINKER"),
  TripsModel(
      srNo: 3,
      lrNo: "TRIP/2425/86580-26-07-2024-TRIP/2425/86580-PTPS-KGU-PONDASH"),
  TripsModel(
      srNo: 4, lrNo: "TRIP/2425/85977-24-07-2024-0081684788-UPGU-KGU-CLINKER"),
  TripsModel(
      srNo: 5, lrNo: "TRIP/2425/85564-22-07-2024-0081684788-RAS-KGU-CLINKER"),
];
