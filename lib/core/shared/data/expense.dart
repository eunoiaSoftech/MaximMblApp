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
      image: "assets/icons/repair-service.png",
      selected: false),
  ExpenseMenuModel(
      srNo: 2,
      name: 'Maintenance',
      image: "assets/icons/maintenance.png",
      selected: false),
  ExpenseMenuModel(
      srNo: 3, name: 'Tyre', image: "assets/icons/shop.png", selected: false),
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
      srNo: 1, name: 'Meal', image: "assets/icons/meal.png", selected: false),
  ExpenseMenuModel(
      srNo: 2, name: 'Toll', image: "assets/icons/toll.png", selected: false),
  ExpenseMenuModel(
      srNo: 3,
      name: 'Others',
      image: "assets/icons/other.png",
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
