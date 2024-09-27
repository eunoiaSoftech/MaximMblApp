import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_styles.dart';

class ApprovalStatsWidget extends StatelessWidget {
  const ApprovalStatsWidget(
      {super.key,
      required this.count,
      required this.title,
      required this.color,
      required this.icon,
      required this.onTap});

  final String count;
  final String title;
  final Color color;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(22),
            child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          blurRadius: 9,
                          spreadRadius: 1,
                          offset: const Offset(0, 9))
                    ]),
                child: Row(
                  children: [
                    const SizedBox(width: 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(count,
                            style: AppStyles.titleTextStyle(context).copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: appSize(context) / 90)),
                        Text(title,
                            style:
                                AppStyles.bottomSheetSUBTitleTextStyle(context)
                                    .copyWith(
                                        color: AppColors.textColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: appSize(context) / 80)),
                        // Icon(CupertinoIcons.arrow_right,size: appSize(context) / 100)
                      ],
                    ),
                    const Spacer(),
                    Icon(
                      icon,
                      size: appSize(context) / 17,
                      color: color,
                    ),
                    // const SizedBox(width: 12),
                  ],
                )),
          ),
          Positioned(
            right: 27,
            top: 0,
            child: Container(
              height: 5,
              width: appSize(context) / 30,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                        color: color.withOpacity(.6),
                        blurRadius: 9,
                        spreadRadius: 1,
                        offset: const Offset(2, 2))
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
