import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../core/res/app_colors.dart';
import '../../../../../core/res/app_functions.dart';
import '../../../../../core/res/app_styles.dart';
import '../../../../expense/presentation/ui/expense_booking_screen.dart';
import '../../../data/current_trip_bloc.dart';
import '../../../data/current_trip_event.dart';
import '../../../data/current_trip_states.dart';

class StatsWidget extends StatelessWidget {
  const StatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger fetching current trip data
    context.read<CurrentTripBloc>().add(FetchCurrentTrip());

    return BlocBuilder<CurrentTripBloc, CurrentTripState>(
      builder: (context, state) {
        if (state is CurrentTripLoading) {
          return const ShimmerLoading();
        } else if (state is CurrentTripError) {
          return Text('Error: ${state.message}');
        } else if (state is CurrentTripLoaded) {
          final currentTrip = state.currentTrip;
          List<ChartData> chartData = [
            ChartData('David', 100, Colors.blue),
            ChartData('Steve', 38, Colors.amber),
          ];
          print('check currentTrip ${currentTrip.lrDate}');

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            color: Colors.white,
            elevation: 3,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 3),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.blue))),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Current Trip",
                                      style: AppStyles.hintTextStyle(context)
                                          .copyWith(
                                              height: 1.2, color: Colors.blue)),
                                  const Icon(Icons.keyboard_arrow_down,
                                      color: Colors.blue)
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              child: Text(currentTrip.lrNo.toString(),
                                  style: AppStyles.titleTextStyle(context)
                                      .copyWith(
                                          fontSize: appSize(context) / 80,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w800)),
                            ),
                            Text(currentTrip.lrDate.toString(),
                                style: AppStyles.titleTextStyle(context)
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500)),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Transit Time: ",
                                    style: AppStyles.titleTextStyle(context)
                                        .copyWith(
                                            color: Colors.black38,
                                            fontSize: appSize(context) / 95,
                                            fontWeight: FontWeight.w500)),
                                Text("${currentTrip.transitTime} HRS",
                                    style: AppStyles.titleTextStyle(context)
                                        .copyWith(
                                            color: Colors.black,
                                            fontSize: appSize(context) / 95,
                                            fontWeight: FontWeight.w500)),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Total: ",
                                    style: AppStyles.titleTextStyle(context)
                                        .copyWith(
                                            color: Colors.black38,
                                            fontSize: appSize(context) / 95,
                                            fontWeight: FontWeight.w500)),
                                Text("${currentTrip.totalKm} Kms",
                                    style: AppStyles.titleTextStyle(context)
                                        .copyWith(
                                            color: Colors.black,
                                            fontSize: appSize(context) / 95,
                                            fontWeight: FontWeight.w500)),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Product: ${currentTrip.product}",
                                    style: AppStyles.titleTextStyle(context)
                                        .copyWith(
                                            color: Colors.amber,
                                            fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          // color: Colors.red,
                          child: SfCircularChart(
                              margin: const EdgeInsets.all(0),
                              annotations: [
                                CircularChartAnnotation(
                                    widget: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('${currentTrip.transitTime} Hrs',
                                        style: const TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            fontSize: 22)),
                                    Text('${currentTrip.totalKm} Km',
                                        style: const TextStyle(
                                            height: 1,
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            fontSize: 14)),
                                  ],
                                ))
                              ],
                              series: <CircularSeries>[
                                DoughnutSeries<ChartData, String>(
                                    innerRadius: '70%',
                                    radius: "90%",
                                    dataSource: chartData,
                                    pointColorMapper: (ChartData data, _) =>
                                        data.color,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y)
                                //               ]),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      _statsButton(context, "START", AppColors.greenLight,
                          AppColors.textWhiteColor, () {
                        log("start");
                      }),
                      const SizedBox(width: 12),
                      _statsButton(
                          context,
                          "EXPENSE",
                          AppColors.newLightBlue.withOpacity(.3),
                          AppColors.textBlackColor, () {
                        log("message");
                        Navigator.of(context)
                            .push(goToRoute(const ExpenseBookingScreen()));
                      }),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (state is CurrentTripError) {
          return Center(child: Text(state.message));
        }

        return Center(child: Text('No current trip data found.'));
      },
    );
  }

  Widget _statsButton(BuildContext context, btnTitle, btnColor, textColor,
          Function() onTap) =>
      InkWell(
        onTap: () => onTap(),
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          decoration: BoxDecoration(
              color: btnColor,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: btnColor)),
          child: Text(btnTitle,
              style: AppStyles.titleTextStyle(context).copyWith(
                  fontSize: appSize(context) / 80,
                  color: textColor,
                  fontWeight: FontWeight.bold)),
        ),
      );
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);

  final String x;
  final double y;
  final Color? color;
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: appSize(context) / 4.2,
        margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
