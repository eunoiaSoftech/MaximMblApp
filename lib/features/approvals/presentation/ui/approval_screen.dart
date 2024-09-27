import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_styles.dart';
import 'package:logistics_app/features/approvals/presentation/ui/approved.dart';
import 'package:logistics_app/features/approvals/presentation/ui/pending.dart';
import 'package:logistics_app/features/approvals/presentation/ui/rejected.dart';
import 'package:logistics_app/features/approvals/presentation/ui/widgets/active_widget.dart';
import 'package:logistics_app/features/approvals/presentation/ui/widgets/approval_stats_widget.dart';
import 'package:logistics_app/features/approvals/presentation/ui/widgets/inactive_widget.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/menu_appbar.dart';

class ApprovalScreen extends StatefulWidget {
  const ApprovalScreen({super.key});

  @override
  State<ApprovalScreen> createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(.95),
        appBar: const MenuAppbar(title: "Approvals"),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // SizedBox(width: 12),
                ApprovalStatsWidget(
                    onTap: () {
                      Navigator.of(context)
                          .push(goToRoute(const PendingScreen()));
                    },
                    count: "10",
                    title: "Pending",
                    color: AppColors.goldenOrangeLight,
                    icon: CupertinoIcons.clock),
                const SizedBox(width: 12),
                ApprovalStatsWidget(
                    onTap: () {
                      Navigator.of(context)
                          .push(goToRoute(const ApprovedListScreen()));
                    },
                    count: "20",
                    title: "Approved",
                    color: AppColors.green,
                    icon: CupertinoIcons.check_mark_circled_solid),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // SizedBox(width: 12),
                ApprovalStatsWidget(
                    onTap: () {
                      Navigator.of(context)
                          .push(goToRoute(const RejectedListScreen()));
                    },
                    count: "8",
                    title: "Rejected",
                    color: Colors.redAccent,
                    icon: Icons.cancel_rounded),
                const SizedBox(width: 12),
                const Spacer()
              ],
            ),
          ],
        )

        // DefaultTabController(
        //   initialIndex: 0,
        //   length: 2,
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Container(
        //         margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
        //         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10),
        //             border: Border.all(color: AppColors.lightViolet)),
        //         child: TabBar(
        //           dividerColor: Colors.transparent,
        //           indicatorSize: TabBarIndicatorSize.tab,
        //           padding:
        //               const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        //           indicatorPadding: const EdgeInsets.symmetric(vertical: -10),
        //           indicator: BoxDecoration(
        //             borderRadius: BorderRadius.circular(9),
        //             // border: Border.all(color: AppColors.darkViolet),
        //             color: AppColors.lightViolet.withOpacity(.2),
        //           ),
        //           automaticIndicatorColorAdjustment: true,
        //           tabs: <Widget>[
        //             // _tab("Fingerprint"),
        //             _tab("Active"),
        //             _tab("Closed"),
        //           ],
        //         ),
        //       ),
        //       Expanded(
        //         child: TabBarView(
        //           physics: const NeverScrollableScrollPhysics(),
        //           children: <Widget>[
        //             // Center(child: _fingerprint()),
        //             Center(child: ActiveWidget()),
        //             Center(child: InActiveWidget()),
        //           ],
        //         ),
        //       ),
        //       const SizedBox(height: 8)
        //       // const Divider(color: AppColors.borderColor),
        //     ],
        //   ),
        // ),
        );
  }

  _tab(text) => Text(text,
      style: TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.textColor,
          fontSize: appSize(context) / 90));
}
