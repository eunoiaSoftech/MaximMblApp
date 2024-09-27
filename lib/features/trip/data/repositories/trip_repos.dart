import '../datasources/trip_remote_datasource.dart';
import '../models/trip_model.dart';

class TripsRepository {
  final TripsRemoteDataSource tripsRemoteDataSource;

  TripsRepository(this.tripsRemoteDataSource);

  Future<List<Trip>> fetchTrips() async {
    final response = await tripsRemoteDataSource.getTrips();
    if (response.statusCode == 200) {
      final List<dynamic> tripsJson = response.data['data1'];
      return tripsJson.map((trip) => Trip.fromJson(trip)).toList();
    } else {
      throw Exception("Failed to load trips");
    }
  }
}
