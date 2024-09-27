import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:shimmer/shimmer.dart';

class ApprovalsLoaderWidget extends StatelessWidget {
  const ApprovalsLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.grey.withOpacity(.5),
      baseColor: Colors.grey.withOpacity(.3),
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 22),
          shrinkWrap: true,
          itemCount: 4,
          separatorBuilder: (context, int i) {
            return const SizedBox(height: 22);
          },
          itemBuilder: (context, int i) {
            return Stack(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        // BoxShadow(
                        //     color: Colors.grey.withOpacity(.3),
                        //     blurRadius: 9,
                        //     spreadRadius: 1,
                        //     offset: const Offset(0, 9))
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _headerRow(""),
                      SizedBox(height: appSize(context) / 100),
                      // _userNameRow(state.resp.data1?[i].supplierName),
                      // SizedBox(height: appSize(context) / 100),
                      _nameRow("", ""),
                      SizedBox(height: appSize(context) / 100),
                      // _iconNContentRow(),
                    ],
                  ),
                ),
                Positioned(
                  left: 40,
                  top: 0,
                  child: Container(
                    height: 5,
                    width: appSize(context) / 30,
                    decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.amberAccent.withOpacity(.6),
                              blurRadius: 9,
                              spreadRadius: 1,
                              offset: const Offset(2, 2))
                        ]),
                  ),
                ),
                // Positioned(
                //   right: 40,
                //   bottom: 20,
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 12, vertical: 2),
                //     decoration: BoxDecoration(
                //         color: Colors.black38,
                //         borderRadius: BorderRadius.circular(6),
                //         boxShadow: const [
                //           // BoxShadow(
                //           //     color: Colors.greenAccent.withOpacity(.6),
                //           //     blurRadius: 9,
                //           //     spreadRadius: 1,
                //           //     offset: const Offset(2, 2))
                //         ]),
                //     child: Text("₹ 99840",
                //         style: AppStyles.titleTextStyle(context)
                //             .copyWith(
                //                 color: Colors.white70,
                //                 fontWeight: FontWeight.w500)),
                //   ),
                // ),
              ],
            );
          }),
    );
  }

  _headerRow(date) => Container(
        child: Row(
          children: [
            Text(
              "Pending..",
              // style: AppStyles.titleTextStyle(context).copyWith(
              //     fontSize: appSize(context) / 85,
              //     color: Colors.amberAccent,
              //     fontWeight: FontWeight.w500)
            ),
            const Spacer(),
            Text(
              date,
              // style: AppStyles.titleTextStyle(context).copyWith(
              //     fontSize: appSize(context) / 120,
              //     color: Colors.grey.withOpacity(.6),
              //     fontWeight: FontWeight.w500)
            ),
          ],
        ),
      );

  _userNameRow(name) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                // style: AppStyles.titleTextStyle(context).copyWith(
                //     height: 1,
                //     fontSize: appSize(context) / 77,
                //     color: AppColors.textColor,
                //     fontWeight: FontWeight.w500)
              )
            ],
          ),
        ],
      );

  _nameRow(supplierName, poNumber) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "$supplierName",
                  // style: AppStyles.titleTextStyle(context).copyWith(
                  //     height: 1,
                  //     fontSize: appSize(context) / 85,
                  //     color: AppColors.textColor.withOpacity(.6),
                  //     fontWeight: FontWeight.w500)
                )
              ],
            ),
            Text(
              "$poNumber",
              // style: AppStyles.titleTextStyle(context).copyWith(
              //     fontSize: appSize(context) / 120,
              //     color: AppColors.textColor.withOpacity(.6),
              //     fontWeight: FontWeight.w500)
            ),
          ],
        ),
      );

  _contentContainer(String title, String value) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            // style: AppStyles.titleTextStyle(context).copyWith(
            //     // fontSize: appSize(context) / 110,
            //     color: AppColors.textColor.withOpacity(.3),
            //     fontWeight: FontWeight.w500)
          ),
          Text(
            value,
            // style: AppStyles.titleTextStyle(context).copyWith(
            // fontSize: appSize(context) / 110,
            // color: AppColors.textColor,
            // fontWeight: FontWeight.w500)
          ),
        ],
      );
}
