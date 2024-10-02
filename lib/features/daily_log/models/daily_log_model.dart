class DailyLogVehicleResponse {
  final int statusCode;
  final int responseCode;
  final String message;
  final List<Vehicle>? data1;

  DailyLogVehicleResponse({
    required this.statusCode,
    required this.responseCode,
    required this.message,
    this.data1,
  });

  factory DailyLogVehicleResponse.fromJson(Map<String, dynamic> json) {
    return DailyLogVehicleResponse(
      statusCode: json['statusCode'],
      responseCode: json['responseCode'],
      message: json['message'],
      data1: json['data1'] != null
          ? List<Vehicle>.from(json['data1'].map((x) => Vehicle.fromJson(x)))
          : null,
    );
  }
}

class Vehicle {
  final int pkVehicleId;
  final String vehicleNo;

  Vehicle({
    required this.pkVehicleId,
    required this.vehicleNo,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      pkVehicleId: json['pk_VehicleId'],
      vehicleNo: json['vehicleNo'],
    );
  }
}
