import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistics_app/features/things_to_review/screen/fm_rate_approval_screen.dart';
import 'package:logistics_app/features/things_to_review/screen/po_screen.dart';
import '../../../core/res/app_colors.dart';
import '../../../core/res/app_styles.dart';
import '../../home/presentation/ui/widgets/common_page_appbar.dart';

class ThingsToReviewScreen extends StatefulWidget {
  const ThingsToReviewScreen({super.key});

  @override
  State<ThingsToReviewScreen> createState() => _ThingsToReviewScreenState();
}

class _ThingsToReviewScreenState extends State<ThingsToReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonPageAppBar(
        title: "Things To Review",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(const FmRateApprovalScreen());
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.newBlue.withOpacity(0.2),
                            border: Border.all(
                              color: AppColors.newBlue.withOpacity(0.2),
                            )),
                        child: const SizedBox(
                          height: 100,
                          width: 100,
                          child: Image(
                              // height: 50,
                              image: AssetImage(
                            'assets/images/new/Group 9926.png',
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("FM Rate",
                          style: AppStyles.titleTextStyle(
                            context,
                          ).copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15))
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(const POScreen());
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.newBlue.withOpacity(0.2),
                            border: Border.all(
                              color: AppColors.newBlue.withOpacity(0.2),
                            )),
                        child: const SizedBox(
                          height: 100,
                          width: 100,
                          child: Image(
                              // height: 50,
                              image: AssetImage(
                            'assets/images/new/Group 9941.png',
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("PO",
                          style: AppStyles.titleTextStyle(
                            context,
                          ).copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15))
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Get.to(const FmRateApprovalScreen());
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.newBlue.withOpacity(0.2),
                            border: Border.all(
                              color: AppColors.newBlue.withOpacity(0.2),
                            )),
                        child: const SizedBox(
                          height: 100,
                          width: 100,
                          child: Image(
                              // height: 50,
                              image: AssetImage(
                            'assets/images/new/Group 9957.png',
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("Drv Exp",
                          textAlign: TextAlign.center,
                          style: AppStyles.titleTextStyle(
                            context,
                          ).copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
