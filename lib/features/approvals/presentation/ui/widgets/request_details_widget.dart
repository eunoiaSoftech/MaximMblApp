import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_icons.dart';
import 'package:logistics_app/core/res/app_styles.dart';
import 'package:logistics_app/core/shared/widgets/app_button.dart';

class RequestDetailsWidget extends StatefulWidget {
  const RequestDetailsWidget({super.key});

  @override
  State<RequestDetailsWidget> createState() => _RequestDetailsWidgetState();
}

class _RequestDetailsWidgetState extends State<RequestDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // SizedBox(height: appSize(context) / 40),
          _userNameRow(),
          SizedBox(height: appSize(context) / 100),
          _nameRow(),
          SizedBox(height: appSize(context) / 100),
          Row(
            children: [
              _iconNContentRow(),
              Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: const [
                      // BoxShadow(
                      //     color: Colors.greenAccent.withOpacity(.6),
                      //     blurRadius: 9,
                      //     spreadRadius: 1,
                      //     offset: const Offset(2, 2))
                    ]),
                child: Text("₹ 99840",
                    style: AppStyles.titleTextStyle(context).copyWith(
                        color: Colors.white70, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          SizedBox(height: appSize(context) / 40),
          Row(
            children: [
              Expanded(child: AppButton(onPressed: (){}, text: "Approve")),
              const SizedBox(width: 12),
              Expanded(child: AppButton(onPressed: (){}, text: "Reject")),
            ],
          ),
          SizedBox(height: appSize(context) / 40),
        ],
      ),
    );
  }

  _userNameRow() => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Ramesh Patel",
                    style: AppStyles.titleTextStyle(context).copyWith(
                        height: 1,
                        fontSize: appSize(context) / 77,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w500)),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Pending..",
                        style: AppStyles.titleTextStyle(context).copyWith(
                            fontSize: appSize(context) / 85,
                            color: Colors.amberAccent,
                            fontWeight: FontWeight.w500)),
                    Text("27 / 08 / 2024",
                        style: AppStyles.titleTextStyle(context).copyWith(
                            fontSize: appSize(context) / 120,
                            color: Colors.grey.withOpacity(.6),
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ],
        ),
      );

  _nameRow() => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Self Assy. /StarterAssy",
                    style: AppStyles.titleTextStyle(context).copyWith(
                        height: 1,
                        fontSize: appSize(context) / 85,
                        color: AppColors.textColor.withOpacity(.6),
                        fontWeight: FontWeight.w500))
              ],
            ),
            Text("(FH000500/FZT03900)",
                style: AppStyles.titleTextStyle(context).copyWith(
                    fontSize: appSize(context) / 120,
                    color: AppColors.textColor.withOpacity(.6),
                    fontWeight: FontWeight.w500)),
          ],
        ),
      );

  _iconNContentRow() => Container(
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      // BoxShadow(
                      //     color: Colors.grey.withOpacity(.3),
                      //     blurRadius: 9,
                      //     spreadRadius: 1,
                      //     offset: const Offset(0, 9))
                    ]),
                child: Image.asset(AppIcons.kIconRepair,
                    width: appSize(context) / 30)),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _contentContainer("Brand: ", "Remould"),
                _contentContainer("Qty: ", "10.00"),
                _contentContainer("Rate: ", "7600"),
              ],
            )
          ],
        ),
      );

  _contentContainer(String title, String value) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(title,
              style: AppStyles.titleTextStyle(context).copyWith(
                  fontSize: appSize(context) / 110,
                  color: AppColors.textColor.withOpacity(.3),
                  fontWeight: FontWeight.w500)),
          Text(value,
              style: AppStyles.titleTextStyle(context).copyWith(
                  fontSize: appSize(context) / 110,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w500)),
        ],
      );
}
