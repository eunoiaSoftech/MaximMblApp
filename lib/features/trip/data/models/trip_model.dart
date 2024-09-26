class Trip {
  final String fromCity;
  final String fromState;
  final String toCity;
  final String toState;
  final String cargo; // You may want to rename this based on the API response
  final String vehicleType;
  final String weight;
  final String lrDate;
  final String lrNumber;

  Trip({
    required this.fromCity,
    required this.fromState,
    required this.toCity,
    required this.toState,
    required this.cargo,
    required this.vehicleType,
    required this.weight,
    required this.lrDate,
    required this.lrNumber,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      fromCity: json['fromStation'], // Adjusted to match API response
      fromState: json['fromStateName'], // Adjusted to match API response
      toCity: json['toStation'], // Adjusted to match API response
      toState: json['toStateName'], // Adjusted to match API response
      cargo: json['productName'], // Adjusted to match API response
      vehicleType: json['vehicleType'],
      weight: json['weight'].toString(), // Convert to string if needed
      lrDate: json['lrDate'],
      lrNumber: json['lrNo'], // Adjusted to match API response
    );
  }
}
