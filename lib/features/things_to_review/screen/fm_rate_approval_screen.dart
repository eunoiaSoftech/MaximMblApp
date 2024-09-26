import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:logistics_app/core/shared/widgets/app_textfield.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/res/app_colors.dart';
import '../../../core/res/app_functions.dart';
import '../../../core/res/app_styles.dart';
import '../../home/presentation/ui/widgets/common_page_appbar.dart';

class FmRateApprovalScreen extends StatefulWidget {
  const FmRateApprovalScreen({super.key});

  @override
  State<FmRateApprovalScreen> createState() => _FmRateApprovalScreenState();
}

class _FmRateApprovalScreenState extends State<FmRateApprovalScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonPageAppBar(
        title: "Fm Rate Approval",
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
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
                            'Active', // Replace with actual user name
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
                            'Close', // Replace with actual user name
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
              const SizedBox(
                height: 20,
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _buildItem(context);
                },
                itemCount: 10,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context) {
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
              // Container(
              //   decoration: const BoxDecoration(
              //     shape: BoxShape.circle,
              //   ),
              //   child: ClipOval(
              //     child: CachedNetworkImage(
              //       imageUrl: "https://randomuser.me/api/portraits/men/32.jpg",
              //       placeholder: (context, url) => Shimmer.fromColors(
              //         baseColor: Colors.grey[300]!,
              //         highlightColor: Colors.grey[100]!,
              //         child: Container(
              //           width: 30,
              //           height: 30,
              //           color: Colors.grey[300], // Shimmer color while loading
              //         ),
              //       ),
              //       errorWidget: (context, url, error) =>
              //           const Icon(Icons.error),
              //       imageBuilder: (context, imageProvider) => CircleAvatar(
              //         radius: 25,
              //         backgroundImage: imageProvider,
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'A00060', // Replace with actual user name
                    style: AppStyles.titleTextStyle(context).copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '6 Sep, 2024', // Replace with actual user name
                    style: AppStyles.titleTextStyle(context).copyWith(
                      color: Colors.black.withOpacity(0.3),
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ],
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
                      'View More',
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
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              // Container(
              //   decoration: const BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: AppColors.newLightBlue,
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(10.0),
              //     child: Text(
              //       '600/-', // Replace with actual user name
              //       style: AppStyles.titleTextStyle(context).copyWith(
              //         color: Colors.white,
              //         fontWeight: FontWeight.w700,
              //         fontSize: 12,
              //       ),
              //     ),
              //   ),
              // ),
              // Text(
              //   'Rate', // Replace with actual user name
              //   style: AppStyles.titleTextStyle(context).copyWith(
              //     color: Colors.black.withOpacity(0.3),
              //     fontWeight: FontWeight.w700,
              //     fontSize: 15,
              //   ),
              // ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
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
          //         // Text(
          //         //   'session 1',
          //         //   textAlign: TextAlign.center,
          //         //   style: AppStyles.titleTextStyle(context).copyWith(
          //         //     color: Colors.black.withOpacity(0.3),
          //         //     fontWeight: FontWeight.w700,
          //         //     fontSize: 13,
          //         //   ),
          //         // ),
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
          //         // Text(
          //         //   'session 2',
          //         //   textAlign: TextAlign.center,
          //         //   style: AppStyles.titleTextStyle(context).copyWith(
          //         //     color: Colors.black.withOpacity(0.3),
          //         //     fontWeight: FontWeight.w700,
          //         //     fontSize: 13,
          //         //   ),
          //         // ),
          //       ],
          //     )
          //   ],
          // ),
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
  int _currentStep = 1; // Change this to set current completed step

  // List of step names
  final List<String> _stepNames = [
    "Submitted by Harpal",
    "Pending with admin",
    "In review application",
    "Final decision",
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Status of Application Timeline",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _stepNames.length,
              itemBuilder: (context, index) {
                return StepWidget(
                  stepNumber: index + 1,
                  title: _stepNames[index],
                  isCompleted: index <= _currentStep, // Completed condition
                  isLastStep: index == _stepNames.length - 1,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StepWidget extends StatelessWidget {
  final int stepNumber;
  final String title;
  final bool isCompleted;
  final bool isLastStep;

  const StepWidget({
    required this.stepNumber,
    required this.title,
    required this.isCompleted,
    required this.isLastStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            // Circle representing the step number or checkmark
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: isCompleted
                    ? Colors.green
                    : Colors.grey, // Green if completed, grey otherwise
                shape: BoxShape.circle,
              ),
              child: Center(
                child: isCompleted
                    ? Icon(Icons.check, color: Colors.white, size: 20)
                    : Text(
                        '$stepNumber',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ),
            // Vertical line for the next step
            if (!isLastStep)
              Container(
                width: 3,
                height: 50,
                color: isCompleted
                    ? Colors.green
                    : Colors.grey, // Green for completed, grey otherwise
              ),
          ],
        ),
        const SizedBox(width: 10), // Spacing between the circle and the text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        isCompleted ? FontWeight.bold : FontWeight.normal,
                    color: isCompleted ? Colors.green : Colors.grey,
                  ),
                ),
              ),
              if (stepNumber == 2)
                AppTextField(
                  hintText: "Write here",
                  contentPadding: EdgeInsets.fromLTRB(22, 2, 12, 10),
                )
            ],
          ),
        ),
      ],
    );
  }
}
