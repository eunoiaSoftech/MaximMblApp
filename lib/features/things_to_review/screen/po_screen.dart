import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_app/core/res/app_storage.dart';
import 'package:logistics_app/features/approvals/data/models/approvals_req_params.dart';
import 'package:logistics_app/features/approvals/presentation/blocs/approvals_bloc.dart';
import 'package:logistics_app/features/approvals/presentation/blocs/approvals_events/approvals_list_event.dart';
import 'package:logistics_app/features/approvals/presentation/ui/approved.dart';
import 'package:logistics_app/features/approvals/presentation/ui/pending.dart';
import 'package:logistics_app/features/approvals/presentation/ui/rejected.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/res/app_colors.dart';
import '../../../core/res/app_functions.dart';
import '../../../core/res/app_styles.dart';
import '../../home/presentation/ui/widgets/common_page_appbar.dart';

class POScreen extends StatefulWidget {
  const POScreen({super.key});

  @override
  State<POScreen> createState() => _POScreenState();
}

class _POScreenState extends State<POScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonPageAppBar(title: "PO"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                    context.read<ApprovalsBloc>().add(ApprovalsListEvent(
                        ApprovalsRequestModel(
                            userId: AppStorage().getUserId,
                            branchId: AppStorage().getBranchId,
                            status: 2)));
                  },
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        color: selectedIndex == 0
                            ? AppColors.newLightBlue
                            : AppColors.borderColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Center(
                        child: Text(
                          'Pending', // Replace with actual user name
                          style: AppStyles.titleTextStyle(context).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                    // context.read<ApprovalsBloc>().add(ApprovalsListEvent(
                    //     ApprovalsRequestModel(
                    //         userId: AppStorage().getUserId,
                    //         branchId: AppStorage().getBranchId,
                    //         status: 0)));
                  },
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        color: selectedIndex == 1
                            ? AppColors.newLightBlue
                            : AppColors.borderColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Center(
                        child: Text(
                          'Approved', // Replace with actual user name
                          style: AppStyles.titleTextStyle(context).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                    context.read<ApprovalsBloc>().add(ApprovalsListEvent(
                        ApprovalsRequestModel(
                            userId: AppStorage().getUserId,
                            branchId: AppStorage().getBranchId,
                            status: 2)));
                  },
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        color: selectedIndex == 2
                            ? AppColors.newLightBlue
                            : AppColors.borderColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Center(
                        child: Text(
                          'Rejected', // Replace with actual user name
                          style: AppStyles.titleTextStyle(context).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(),
              ],
            ),
          ),
          Expanded(
            child: selectedIndex == 0
                ? const PendingScreen()
                : selectedIndex == 1
                    ? const ApprovedListScreen()
                    : const RejectedListScreen(),
          )
          // ListView.separated(
          //   physics: const NeverScrollableScrollPhysics(),
          //   shrinkWrap: true,
          //   itemBuilder: (context, index) {
          //     return _buildItem(context);
          //   },
          //   itemCount: 10,
          //   separatorBuilder: (context, index) {
          //     return const SizedBox(
          //       height: 20,
          //     );
          //   },
          // )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, poNumber, poDate, status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
              color: Colors.black12.withOpacity(0.08),
              offset: const Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 2)
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    poNumber,
                    style: AppStyles.titleTextStyle(context).copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    poDate, // Replace with actual user name
                    style: AppStyles.titleTextStyle(context).copyWith(
                      color: Colors.black.withOpacity(0.3),
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.newLightBlue,
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Text(
                    status,
                    style: AppStyles.titleTextStyle(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        VerticalStepProgressDialog(),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.newLightBlue,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Text(
                      'View More', // Replace with actual user name
                      style: AppStyles.titleTextStyle(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          // const SizedBox(
          //   height: 15,
          // ),
          // Row(
          //   children: [
          //     Column(
          //       children: [
          //         Text(
          //           '6 sept 2024',
          //           textAlign: TextAlign.center,
          //           style: AppStyles.titleTextStyle(context).copyWith(
          //             color: Colors.black.withOpacity(0.3),
          //             fontWeight: FontWeight.w700,
          //             fontSize: 15,
          //           ),
          //         ),
          //         Text(
          //           'session 1',
          //           textAlign: TextAlign.center,
          //           style: AppStyles.titleTextStyle(context).copyWith(
          //             color: Colors.black.withOpacity(0.3),
          //             fontWeight: FontWeight.w700,
          //             fontSize: 13,
          //           ),
          //         ),
          //       ],
          //     ),
          //     Expanded(
          //         child: Container(
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Container(
          //             width: 20,
          //             height: 1,
          //             color: AppColors.newLightBlue,
          //           ),
          //           Container(
          //             decoration: BoxDecoration(
          //                 border: Border.all(
          //                   color: AppColors.newLightBlue,
          //                 ),
          //                 borderRadius: BorderRadius.circular(30)),
          //             child: Padding(
          //               padding: const EdgeInsets.symmetric(
          //                   horizontal: 10, vertical: 8),
          //               child: Text(
          //                 '9 Days', // Replace with actual user name
          //                 style: AppStyles.titleTextStyle(context).copyWith(
          //                   color: Colors.black.withOpacity(0.3),
          //                   fontWeight: FontWeight.w700,
          //                   fontSize: 14,
          //                 ),
          //               ),
          //             ),
          //           ),
          //           Container(
          //             width: 20,
          //             height: 1,
          //             color: AppColors.newLightBlue,
          //           ),
          //         ],
          //       ),
          //     )),
          //     Column(
          //       children: [
          //         Text(
          //           '10 sept 2024',
          //           textAlign: TextAlign.center,
          //           style: AppStyles.titleTextStyle(context).copyWith(
          //             color: Colors.black.withOpacity(0.3),
          //             fontWeight: FontWeight.w700,
          //             fontSize: 15,
          //           ),
          //         ),
          //         Text(
          //           'session 2',
          //           textAlign: TextAlign.center,
          //           style: AppStyles.titleTextStyle(context).copyWith(
          //             color: Colors.black.withOpacity(0.3),
          //             fontWeight: FontWeight.w700,
          //             fontSize: 13,
          //           ),
          //         ),
          //       ],
          //     )
          //   ],
          // ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.lightPink,
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.share,
                        size: 15,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Forward', // Replace with actual user name
                        style: AppStyles.titleTextStyle(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        size: 18,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Approved', // Replace with actual user name
                        style: AppStyles.titleTextStyle(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.borderColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.cancel_outlined,
                        size: 18,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Reject', // Replace with actual user name
                        style: AppStyles.titleTextStyle(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class VerticalStepProgressDialog extends StatefulWidget {
  @override
  _VerticalStepProgressDialogState createState() =>
      _VerticalStepProgressDialogState();
}

class _VerticalStepProgressDialogState
    extends State<VerticalStepProgressDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://randomuser.me/api/portraits/men/32.jpg",
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 30,
                              height: 30,
                              color: Colors
                                  .grey[300], // Shimmer color while loading
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            radius: 25,
                            backgroundImage: imageProvider,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Harpal Matholiya', // Replace with actual user name
                          style: AppStyles.titleTextStyle(context).copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'A00060', // Replace with actual user name
                          style: AppStyles.titleTextStyle(context).copyWith(
                            color: Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.newLightBlue,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '600/-', // Replace with actual user name
                          style: AppStyles.titleTextStyle(context).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Rate', // Replace with actual user name
                      style: AppStyles.titleTextStyle(context).copyWith(
                        color: Colors.black.withOpacity(0.3),
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                _buildDrawerItem("Transaction No. : 023476874", () {}, context),
                SizedBox(
                  height: 15,
                ),
                _buildDrawerItem(
                    "Transaction Date. : 09-08-2024", () {}, context),
                SizedBox(
                  height: 15,
                ),
                _buildDrawerItem("Fm in Name Of : Owner", () {}, context),
                SizedBox(
                  height: 15,
                ),
                _buildDrawerItem(
                    "Owner/Broker : Harpal Matholiya", () {}, context),
                SizedBox(
                  height: 15,
                ),
                _buildDrawerItem("Booking Rate : 600", () {}, context),
                SizedBox(
                  height: 15,
                ),
                _buildDrawerItem("Charged Rate. : 680", () {}, context),
                SizedBox(
                  height: 15,
                ),
                _buildDrawerItem("Rate Confirm By : Armin", () {}, context),
                SizedBox(
                  height: 15,
                ),
                _buildDrawerItem("Create By : Shweta", () {}, context),
                SizedBox(
                  height: 15,
                ),
                _buildDrawerItem("Created On : 06-05-2024", () {}, context),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightPink,
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 6),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.share,
                              size: 15,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Forward', // Replace with actual user name
                              style: AppStyles.titleTextStyle(context).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 6),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              size: 18,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Approve', // Replace with actual user name
                              style: AppStyles.titleTextStyle(context).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.borderColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 6),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.cancel_outlined,
                              size: 18,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Reject', // Replace with actual user name
                              style: AppStyles.titleTextStyle(context).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String itemName, VoidCallback onTap, context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                itemName,
                style: AppStyles.titleTextStyle(context).copyWith(
                  color: AppColors.textBlackColor.withOpacity(0.4),
                  fontWeight: FontWeight.bold,
                  fontSize: appSize(context) / 80,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
