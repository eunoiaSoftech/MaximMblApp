import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_app/core/res/app_bottomsheet.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_icons.dart';
import 'package:logistics_app/core/res/app_storage.dart';
import 'package:logistics_app/core/res/app_styles.dart';
import 'package:logistics_app/core/shared/widgets/app_alert_widget.dart';
import 'package:logistics_app/features/approvals/data/models/approvals_req_params.dart';
import 'package:logistics_app/features/approvals/presentation/blocs/approvals_bloc.dart';
import 'package:logistics_app/features/approvals/presentation/blocs/approvals_events/approvals_list_event.dart';
import 'package:logistics_app/features/approvals/presentation/blocs/approvals_states/approvals.dart';
import 'package:logistics_app/features/approvals/presentation/blocs/approvals_states/approvals_list_state.dart';
import 'package:logistics_app/features/approvals/presentation/ui/widgets/approvals_loader.dart';
import 'package:logistics_app/features/approvals/presentation/ui/widgets/request_details_widget.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/menu_appbar.dart';
import 'package:shimmer/shimmer.dart';

class ApprovedListScreen extends StatefulWidget {
  const ApprovedListScreen({super.key});

  @override
  State<ApprovedListScreen> createState() => _ApprovedListScreenState();
}

class _ApprovedListScreenState extends State<ApprovedListScreen> {
  void _callApi() {
    context.read<ApprovalsBloc>().add(ApprovalsListEvent(ApprovalsRequestModel(
        userId: AppStorage().getUserId,
        branchId: AppStorage().getBranchId,
        status: 1)));
  }

  @override
  void initState() {
    super.initState();

    _callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // Scaffold(
        //   backgroundColor: Colors.white.withOpacity(.95),
        //   appBar: const MenuAppbar(title: "Approved Requests"),
        //   body:
        child: BlocConsumer<ApprovalsBloc, ApprovalsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ApprovalsListLoaded) {
          return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 22,horizontal: 12),
              shrinkWrap: true,
              itemCount: state.resp.data1?.length ?? 0,
              separatorBuilder: (context, int i) {
                return const SizedBox(height: 22);
              },
              itemBuilder: (context, int i) {
                return _buildItem(
                    context,
                    state.resp.data1?[i].poNo,
                    state.resp.data1?[i].poDate,
                    state.resp.data1?[i].supplierName,
                    "Approved");
                // return InkWell(
                //   onTap: () {
                //     AppBottomSheet.show(
                //         context: context,
                //         child: const RequestDetailsWidget(),
                //         then: (v) {});
                //   },
                //   child: Stack(
                //     children: [
                //       Container(
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 22, vertical: 22),
                //         margin: const EdgeInsets.symmetric(
                //             horizontal: 12, vertical: 0),
                //         decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.circular(25),
                //             boxShadow: [
                //               BoxShadow(
                //                   color: Colors.grey.withOpacity(.3),
                //                   blurRadius: 9,
                //                   spreadRadius: 1,
                //                   offset: const Offset(0, 9))
                //             ]),
                //         child: Column(
                //           mainAxisSize: MainAxisSize.min,
                //           children: [
                //             _headerRow(state.resp.data1?[i].poDate),
                //             SizedBox(height: appSize(context) / 100),
                //             // _userNameRow(state.resp.data1?[i].supplierName),
                //             // SizedBox(height: appSize(context) / 100),
                //             _nameRow(state.resp.data1?[i].supplierName,
                //                 state.resp.data1?[i].poNo),
                //             SizedBox(height: appSize(context) / 100),
                //             // _iconNContentRow(),
                //           ],
                //         ),
                //       ),
                //       Positioned(
                //         left: 40,
                //         top: 0,
                //         child: Container(
                //           height: 5,
                //           width: appSize(context) / 30,
                //           decoration: BoxDecoration(
                //               color: AppColors.green,
                //               borderRadius: BorderRadius.circular(22),
                //               boxShadow: [
                //                 BoxShadow(
                //                     color: AppColors.green.withOpacity(.6),
                //                     blurRadius: 9,
                //                     spreadRadius: 1,
                //                     offset: const Offset(2, 2))
                //               ]),
                //         ),
                //       ),
                //       // Positioned(
                //       //   right: 40,
                //       //   bottom: 20,
                //       //   child: Container(
                //       //     padding: const EdgeInsets.symmetric(
                //       //         horizontal: 12, vertical: 2),
                //       //     decoration: BoxDecoration(
                //       //         color: Colors.black38,
                //       //         borderRadius: BorderRadius.circular(6),
                //       //         boxShadow: const [
                //       //           // BoxShadow(
                //       //           //     color: Colors.greenAccent.withOpacity(.6),
                //       //           //     blurRadius: 9,
                //       //           //     spreadRadius: 1,
                //       //           //     offset: const Offset(2, 2))
                //       //         ]),
                //       //     child: Text("₹ 99840",
                //       //         style: AppStyles.titleTextStyle(context)
                //       //             .copyWith(
                //       //                 color: Colors.white70,
                //       //                 fontWeight: FontWeight.w500)),
                //       //   ),
                //       // ),
                //     ],
                //   ),
                // );
              });
        }
        if (state is ApprovalsListError) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppAlertWidget(isError: false),
            ],
          );
        }
        return const ApprovalsLoaderWidget();
      },
    ));
  }

  _headerRow(date) => Container(
        child: Row(
          children: [
            Text("Approved",
                style: AppStyles.titleTextStyle(context).copyWith(
                    fontSize: appSize(context) / 85,
                    color: AppColors.green,
                    fontWeight: FontWeight.w500)),
            const Spacer(),
            Text(date,
                style: AppStyles.titleTextStyle(context).copyWith(
                    fontSize: appSize(context) / 120,
                    color: Colors.grey.withOpacity(.6),
                    fontWeight: FontWeight.w500)),
          ],
        ),
      );

  _userNameRow(name) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(name,
                  style: AppStyles.titleTextStyle(context).copyWith(
                      height: 1,
                      fontSize: appSize(context) / 77,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500))
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
                Text("$supplierName",
                    style: AppStyles.titleTextStyle(context).copyWith(
                        height: 1,
                        fontSize: appSize(context) / 85,
                        color: AppColors.textColor.withOpacity(.6),
                        fontWeight: FontWeight.w500))
              ],
            ),
            Text("$poNumber",
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
                    width: appSize(context) / 40)),
            SizedBox(width: 12),
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

  Widget _buildItem(
      BuildContext context, poNumber, poDate, supplierName, status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
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
              Expanded(
                flex: 4,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                  // decoration: BoxDecoration(
                  //     color: AppColors.newLightBlue,
                  //     borderRadius: BorderRadius.circular(22)),
                  child: Text(
                    supplierName,overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: AppStyles.titleTextStyle(context).copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
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
                        VerticalStepProgressDialog(
                            supplierName: supplierName,
                            poNo: poNumber,
                            poDate: poDate),
                  );
                },
                child: Container(
                  // decoration: BoxDecoration(
                  //     color: AppColors.newLightBlue,
                  //     borderRadius: BorderRadius.circular(22)),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Text(
                      'View More', // Replace with actual user name
                      style: AppStyles.titleTextStyle(context).copyWith(
                        color: AppColors.newLightBlue,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
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
              _statusContainer("Forward", AppColors.newBlue),
              const SizedBox(width: 6),
              // _statusContainer("Approved", AppColors.green),
              // const SizedBox(width: 6),
              _statusContainer("Reject", Colors.grey)
            ],
          )
        ],
      ),
    );
  }

  _statusContainer(text, color) => Expanded(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(22)),
          child: Text(
            text, // Replace with actual user name
            style: AppStyles.titleTextStyle(context).copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
      );
}

class VerticalStepProgressDialog extends StatefulWidget {
  final String poDate;
  final String poNo;
  final String supplierName;

  const VerticalStepProgressDialog(
      {super.key,
      required this.supplierName,
      required this.poNo,
      required this.poDate});

  @override
  VerticalStepProgressDialogState createState() =>
      VerticalStepProgressDialogState();
}

class VerticalStepProgressDialogState
    extends State<VerticalStepProgressDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  // Container(
                  //   decoration: const BoxDecoration(
                  //     shape: BoxShape.circle,
                  //   ),
                  //   child: ClipOval(
                  //     child: CachedNetworkImage(
                  //       imageUrl:
                  //           "https://randomuser.me/api/portraits/men/32.jpg",
                  //       placeholder: (context, url) => Shimmer.fromColors(
                  //         baseColor: Colors.grey[300]!,
                  //         highlightColor: Colors.grey[100]!,
                  //         child: Container(
                  //           width: 30,
                  //           height: 30,
                  //           color: Colors
                  //               .grey[300], // Shimmer color while loading
                  //         ),
                  //       ),
                  //       errorWidget: (context, url, error) =>
                  //           const Icon(Icons.error),
                  //       imageBuilder: (context, imageProvider) =>
                  //           CircleAvatar(
                  //         radius: 25,
                  //         backgroundImage: imageProvider,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.poNo, // Replace with actual user name
                        style: AppStyles.titleTextStyle(context).copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        widget.poDate, // Replace with actual user name
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
              // Row(
              //   children: [
              //     Container(
              //       decoration: const BoxDecoration(
              //         shape: BoxShape.circle,
              //         color: AppColors.newLightBlue,
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: Text(
              //           '600/-', // Replace with actual user name
              //           style: AppStyles.titleTextStyle(context).copyWith(
              //             color: Colors.white,
              //             fontWeight: FontWeight.w700,
              //             fontSize: 12,
              //           ),
              //         ),
              //       ),
              //     ),
              //     Text(
              //       'Rate', // Replace with actual user name
              //       style: AppStyles.titleTextStyle(context).copyWith(
              //         color: Colors.black.withOpacity(0.3),
              //         fontWeight: FontWeight.w700,
              //         fontSize: 15,
              //       ),
              //     ),
              //   ],
              // ),
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
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 2,
              spreadRadius: 2,
              offset: const Offset(0, 1),
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
