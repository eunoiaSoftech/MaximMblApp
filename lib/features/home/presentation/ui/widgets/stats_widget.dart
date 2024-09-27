import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_styles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y, [this.color]);

  final String x;
  final double y;
  final Color? color;
}

class StatsWidget extends StatelessWidget {
  const StatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('David', 100, Colors.blue),
      ChartData('Steve', 38, Colors.amber),
    ];
    return Stack(
      children: [
        SizedBox(
          height: appSize(context) / 4.2,
          // width: appSize(context)/10,
          child: Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 3),
                        decoration: const BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.blue))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("My Trip",
                                style: AppStyles.hintTextStyle(context)
                                    .copyWith(height: 1.2, color: Colors.blue)),
                            const Icon(Icons.keyboard_arrow_down,
                                color: Colors.blue)
                          ],
                        ),
                      ),
                      const Spacer(flex: 2),
                      Text("06",
                          style: AppStyles.titleTextStyle(context).copyWith(
                              fontSize: appSize(context) / 40,
                              color: Colors.blue,
                              fontWeight: FontWeight.w800)),
                      Text("Today's Trip",
                          style: AppStyles.titleTextStyle(context).copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      const Spacer(flex: 2),
                      Text("Total 85 Kms",
                          style: AppStyles.titleTextStyle(context).copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      const Spacer(),
                      Text("You have to do 2 more trips for a day",
                          style: AppStyles.titleTextStyle(context).copyWith(
                              color: Colors.amber,
                              fontWeight: FontWeight.w500)),
                      // const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -20,
          right: -30,
          child: SfCircularChart(
              margin: const EdgeInsets.all(0),
              annotations: const [
                CircularChartAnnotation(
                    widget: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('62%',
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 25)),
                    Text('in 13 days',
                        style: TextStyle(
                            height: 1,
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            fontSize: 14)),
                  ],
                ))
              ],
              series: <CircularSeries>[
                // Renders doughnut chart
                DoughnutSeries<ChartData, String>(
                    innerRadius: '70%',
                    radius: "50%",
                    dataSource: chartData,
                    pointColorMapper: (ChartData data, _) => data.color,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y)
              ]),
        )
      ],
    );
  }
}
