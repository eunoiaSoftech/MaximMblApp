import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_styles.dart';
import 'package:logistics_app/core/shared/widgets/app_button.dart';
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
          height: appSize(context) / 3.8,
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
                            Text("Current Trip",
                                style: AppStyles.hintTextStyle(context)
                                    .copyWith(height: 1.2, color: Colors.blue)),
                            const Icon(Icons.keyboard_arrow_down,
                                color: Colors.blue)
                          ],
                        ),
                      ),
                      const Spacer(flex: 2),
                      Text("LR/009",
                          style: AppStyles.titleTextStyle(context).copyWith(
                              fontSize: appSize(context) / 50,
                              color: Colors.blue,
                              fontWeight: FontWeight.w800)),
                      Text("12/03/2024",
                          style: AppStyles.titleTextStyle(context).copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      // const Spacer(flex: 2),
                      Row(mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Transit Time: ",
                              style: AppStyles.titleTextStyle(context).copyWith(
                                  color: Colors.black38,
                                  fontSize: appSize(context)/95,
                                  fontWeight: FontWeight.w500)),
                          Text("32 HRS",
                              style: AppStyles.titleTextStyle(context).copyWith(
                                  color: Colors.black,
                                  fontSize: appSize(context)/95,
                                  fontWeight: FontWeight.w500)),

                        ],
                      ),
                      // const Spacer(flex: 2),
                      Row(mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Total: ",
                              style: AppStyles.titleTextStyle(context).copyWith(
                                  color: Colors.black38,
                                  fontSize: appSize(context)/95,
                                  fontWeight: FontWeight.w500)),
                          Text("80 Kms",
                              style: AppStyles.titleTextStyle(context).copyWith(
                                  color: Colors.black,
                                  fontSize: appSize(context)/95,
                                  fontWeight: FontWeight.w500)),

                        ],
                      ),
                      // Text("Total 85 Kms",
                      //     style: AppStyles.titleTextStyle(context).copyWith(
                      //         color: Colors.black,
                      //         fontWeight: FontWeight.w500)),

                      const Spacer(),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Customer:",
                                  style: AppStyles.titleTextStyle(context)
                                      .copyWith(
                                          color: Colors.amber,
                                          fontWeight: FontWeight.w500)),
                              Text("Route:",
                                  style: AppStyles.titleTextStyle(context)
                                      .copyWith(
                                          color: Colors.amber,
                                          fontWeight: FontWeight.w500)),

                              Text("Product:",
                                  style: AppStyles.titleTextStyle(context)
                                      .copyWith(
                                          color: Colors.amber,
                                          fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          _statsButton(
                              context,
                              "START",
                              AppColors.greenLight,
                              AppColors.textWhiteColor,
                              () {}),
                          const SizedBox(width: 12),
                          _statsButton(
                              context,
                              "EXPENSE",
                              AppColors.newLightBlue.withOpacity(.3),
                              AppColors.textBlackColor,
                              () {}),
                        ],
                      ),

                      // AppButton(onPressed: (){}, text: "BOOK EXPENSE"),

                      // const Spacer(),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: AppButton(
                      //           btnColor: Colors.black,
                      //           textColor: Colors.black,
                      //           onPressed: (){}, text: "START TRIP"),
                      //     ),
                      //   ],
                      // ),
                      // AppButton(onPressed: (){}, text: "BOOK EXPENSE"),
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
                    Text('32 Hrs',
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 22)),
                    Text('11 Hrs Left',
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

  _statsButton(BuildContext context, btnTitle, btnColor, textColor, onTap) =>
      InkWell(
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
