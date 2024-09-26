import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/common_page_appbar.dart';
import '../../../../../core/shared/data/base_api.dart';
import '../../../data/datasources/trip_remote_datasource.dart';
import '../../../data/models/trip_model.dart';
import '../../../data/repositories/trip_repos.dart';
import '../../bloc/bloc.dart';
import '../../bloc/event.dart';
import '../../bloc/state.dart';
import '../widget/build_my_trip_card.dart';

class MyTripScreen extends StatelessWidget {
  const MyTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonPageAppBar(
        title: "My Trips",
      ),
      body: BlocProvider(
        create: (context) =>
            TripsBloc(TripsRepository(TripsRemoteDataSource(BaseApi(Dio()))))
              ..add(LoadTrips()),
        child: BlocBuilder<TripsBloc, TripsState>(
          builder: (context, state) {
            if (state is TripsLoading) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColors.newBlue,
              ));
            } else if (state is TripsLoaded) {
              return _getBodyView(state.trips);
            } else if (state is TripsError) {
              return Center(child: Text(state.message));
            }
            return Container(); // For TripsInitial
          },
        ),
      ),
    );
  }

  Widget _getBodyView(List<Trip> trips) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];
        return BuildMyTripCard(trip: trip);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
    );
  }
}
