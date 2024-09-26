import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_styles.dart';
import 'package:logistics_app/core/shared/widgets/app_button.dart';

class InActiveWidget extends StatelessWidget {
  InActiveWidget({super.key});

  final List<Map<String, dynamic>> list = [
    {
      "name": "Deepak Swami",
      "date": "06 Aug, 2024",
      "expense_amount": "1200",
      "details": "Food, Diesel, Chalan",
      "profile_photo":
          "https://www.pngall.com/wp-content/uploads/5/Profile-Transparent.png"
    },
    {
      "name": "k. Shoeb",
      "date": "22 Aug, 2024",
      "expense_amount": "600",
      "details": "Food",
      "profile_photo":
          "https://png.pngitem.com/pimgs/s/230-2306412_team-member-gentleman-hd-png-download.png"
    },
    {
      "name": "Arun B Mehta",
      "date": "25 Aug, 2024",
      "expense_amount": "2000",
      "details": "Food, Diesel, Chalan",
      "profile_photo":
          "https://png.pngitem.com/pimgs/s/477-4774424_headshots-jesus-gentleman-hd-png-download.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, int i) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
                color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(55),
                        child: Image.network(
                          list[i]["profile_photo"],
                          width: appSize(context) / 30,
                        )),
                    const SizedBox(width: 12),
                    // CachedNetworkImage(
                    //   imageUrl: list[i]["profile_photo"],
                    //   imageBuilder: (context, imageProvider) => Container(
                    //     decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           image: imageProvider,
                    //           fit: BoxFit.cover,
                    //           colorFilter: ColorFilter.mode(
                    //               Colors.red, BlendMode.colorBurn)),
                    //     ),
                    //   ),
                    //   placeholder: (context, url) =>
                    //       const CupertinoActivityIndicator(),
                    //   errorWidget: (context, url, error) =>
                    //       const Icon(Icons.error),
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Abhijeet Shankar",
                            style: AppStyles.bottomSheetTitleTextStyle(context)
                                .copyWith(fontSize: appSize(context) / 90)),
                        Text("MH432012000003132",
                            style: AppStyles.titleTextStyle(context)
                                .copyWith(fontSize: appSize(context) / 100)),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Text("Date: ",
                        style: AppStyles.titleTextStyle(context)
                            .copyWith(fontSize: appSize(context) / 90)),
                    Text("29 Aug, 2024",
                        style: AppStyles.titleTextStyle(context)
                            .copyWith(fontSize: appSize(context) / 100)),
                  ],
                ),
                Text("Expense Amount: Rs.1200",
                    style: AppStyles.titleTextStyle(context)
                        .copyWith(fontSize: appSize(context) / 100)),
                Text("Expense Details:",
                    style: AppStyles.titleTextStyle(context)
                        .copyWith(fontSize: appSize(context) / 100)),
                Text("Food, And extra Activities",
                    style: AppStyles.titleTextStyle(context)
                        .copyWith(fontSize: appSize(context) / 100)),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                        child: AppButton(
                            textColor: Colors.white,
                            btnColor: AppColors.borderColor,
                            // isBorder: true,
                            onPressed: () {},
                            text: "Approved",
                            circular: 33)),
                    // SizedBox(width: 12),
                    // Expanded(
                    //     child: AppButton(
                    //         textColor: AppColors.lightViolet,
                    //         isBorder: true,
                    //         onPressed: () {},
                    //         text: "Reject",
                    //         circular: 33)),
                  ],
                )
              ],
            ),
          );
        });
  }
}
