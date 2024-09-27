import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:logistics_app/core/res/app_bottomsheet.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_icons.dart';
import 'package:logistics_app/core/res/app_images.dart';
import 'package:logistics_app/core/res/app_storage.dart';
import 'package:logistics_app/core/res/app_styles.dart';
import 'package:logistics_app/core/shared/data/user.dart';
import 'package:logistics_app/core/shared/widgets/app_textfield.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/menu_appbar.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/menu_bg_widget.dart';
import 'package:logistics_app/features/legals/data/models/vehicle_list_resp.dart';
import 'package:logistics_app/features/legals/presentation/blocs/blocs/legal_document_list_bloc.dart';
import 'package:logistics_app/features/legals/presentation/blocs/legals_bloc.dart';
import 'package:logistics_app/features/legals/presentation/blocs/legals_events/legal_document_list_events.dart';
import 'package:logistics_app/features/legals/presentation/blocs/legals_events/vehicle_list_events.dart';
import 'package:logistics_app/features/legals/presentation/blocs/legals_states/legal_document_list_states.dart';
import 'package:logistics_app/features/legals/presentation/blocs/legals_states/legals.dart';
import 'package:logistics_app/features/legals/presentation/blocs/legals_states/vehicle_list_states.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class MenuItem {
  final int id;
  final String label;
  final IconData icon;

  MenuItem(this.id, this.label, this.icon);
}

// List<MenuItem> menuItems = [
//   MenuItem(1, 'MH43AP1078', Icons.home),
//   MenuItem(2, 'MH13AP0978', Icons.person),
//   MenuItem(3, 'MH02BB8009', Icons.settings),
//   MenuItem(3, 'MH01AX9900', Icons.settings),
//   MenuItem(3, 'MH42AA1233', Icons.settings),
// ];

class LegalScreen extends StatefulWidget {
  const LegalScreen({super.key});

  @override
  State<LegalScreen> createState() => _LegalScreenState();
}

class _LegalScreenState extends State<LegalScreen> {
  final TextEditingController menuController = TextEditingController();
  Data1? selectedMenu;
  List vehicleList = [
    {
      "name": "RC Copy",
      "expiry": "27-09-2024",
      "days_left": "27",
      "file": "assets/files/pdf.pdf"
    },
    {
      "name": "Tr Permit",
      "expiry": "27-09-2024",
      "days_left": "10",
      "file": "assets/files/pdf.pdf"
    },
  ];

  List driverList = [
    {
      "name": "License",
      "expiry": "27-09-2024",
      "days_left": "27",
      "file": "assets/files/pdf.pdf"
    },
    {
      "name": "Tr Permit",
      "expiry": "27-09-2024",
      "days_left": "10",
      "file": "assets/files/pdf.pdf"
    },
    {
      "name": "Light Bill",
      "expiry": "",
      "days_left": "",
      "file": "assets/files/pdf.pdf"
    },
  ];

  _processApi() {
    context.read<LegalsBloc>().add(VehicleListEvent(AppStorage().getUserId,
        User.fromJson(AppStorage().getUserDetails).userType ?? 0));
  }

  @override
  void initState() {
    super.initState();
    _processApi();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 16.0;
    return Scaffold(
      // backgroundColor: const Color(0xffE3F2FD),
      appBar: MenuAppbar(
          title: "Legals",
          titleWidget: Row(
            children: [
              Expanded(
                // color: Colors.black,
                child: Container(
                  // color: Colors.amber,
                  child: BlocConsumer<LegalsBloc, LegalsState>(
                    bloc: context.read<LegalsBloc>(),
                    listener: (context, state) {
                      if (state is VehicleListLoaded) {
                        if (state.resp.data1?.length == 1) {
                          selectedMenu = state.resp.data1?.first;
                          setState(() {});
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is VehicleListLoaded) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            selectedColor: Colors.white,
                            selected: true,
                            trailing: const Icon(Icons.arrow_drop_down),
                            onTap: state.resp.data1?.length == 1
                                ? () {}
                                : () {
                                    AppBottomSheet.show(
                                        context: context,
                                        showDragHandle: true,
                                        color: AppColors.textColor,
                                        title: "Select Vehicle Number",
                                        titleColor: Colors.white,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: state.resp.data1
                                                    ?.map((e) => ListTile(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedMenu = e;
                                                            });
                                                            context
                                                                .read<
                                                                    LegalDocumentListBloc>()
                                                                .add(LegalDocumentListEvent(
                                                                    e.pkVehicleId ??
                                                                        0));

                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          title: Text(
                                                              e.vehicleNo ??
                                                                  ""),
                                                        ))
                                                    .toList() ??
                                                [],
                                          ),
                                        ),
                                        then: (v) {});
                                  },
                            title: Text(selectedMenu != null
                                ? selectedMenu?.vehicleNo ?? ""
                                : "Select Vehicle"),
                            // trailing: Icon(Icons.arrow_drop_down),
                          ),
                        );
                      }
                      return Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.white12,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            selectedColor: Colors.white,
                            selected: true,
                            onTap: () {},
                            title: const Text("Loading..."),
                            // trailing: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          )),
      body: (selectedMenu != null)
          ? MenuBgWidget(
              child: DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: appSize(context) / 40),
                  const SizedBox(height: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 22, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(33),
                        border: Border.all(color: AppColors.newBlue)),
                    child: TabBar(
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 12),
                      indicatorPadding:
                          const EdgeInsets.symmetric(vertical: -8),
                      indicator: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(.3),
                              spreadRadius: 4,
                              offset: const Offset(0, 1),
                              blurRadius: 9)
                        ],
                        borderRadius: BorderRadius.circular(33),
                        border: Border.all(color: AppColors.newBlue),
                        color: AppColors.newBlue.withOpacity(.6),
                      ),
                      automaticIndicatorColorAdjustment: true,
                      tabs: <Widget>[
                        _tab("Vehicle Documents"),
                        _tab("Driver Documents"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // color: Colors.redAccent,
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          BlocConsumer<LegalDocumentListBloc, LegalsState>(
                              builder: (context, state) {
                                if (state is LegalDocumentListLoaded) {
                                  return Column(children: [
                                    const SizedBox(height: 22),
                                    if (state.resp.data1?.isEmpty ?? true)
                                      const Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.hourglass_empty),
                                          Text("No Data")
                                        ],
                                      ),
                                    ...List.generate(
                                        state.resp.data1?.length ?? 0,
                                        (index) => _vehicleDocListTile(
                                            state.resp.data1?[index].sName,
                                            "--/--/--",
                                            "12"))
                                  ]);
                                }
                                if (state is LegalDocumentListError) {
                                  return Center(
                                      child: Icon(Icons.error,
                                          color: Colors.redAccent,
                                          size: appSize(context) / 20));
                                }
                                return const Center(
                                  child: CircularProgressIndicator(
                                      color: AppColors.newBlue),
                                );
                              },
                              listener: (context, state) {}),
                          // Column(children: [
                          //   const SizedBox(height: 22),
                          //   ...List.generate(
                          //       vehicleList.length,
                          //       (index) => _vehicleDocListTile(
                          //           vehicleList[index]["name"],
                          //           vehicleList[index]["expiry"],
                          //           vehicleList[index]["days_left"]))
                          // ]),
                          Column(children: [
                            const SizedBox(height: 22),
                            ...List.generate(
                                driverList.length,
                                (index) => _vehicleDocListTile(
                                    driverList[index]["name"],
                                    driverList[index]["expiry"],
                                    driverList[index]["days_left"]))
                          ]),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 8)
                  // const Divider(color: AppColors.borderColor),
                ],
              ),
            ))
          : Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: Image.asset(AppIcons.kIconTruckNav,
                              width: appSize(context) / 4),
                        ),
                        // Positioned(
                        //     top: 15,
                        //     left: 20,
                        //     child: Icon(CupertinoIcons.question_circle_fill,
                        //         size: appSize(context) / 22,
                        //         color: Colors.grey))
                      ],
                    ),
                    const SizedBox(height: 22),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 44),
                      child: Text(
                        "Dear user kindly select vehicle number for which you want to see documents",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  _vehicleDocListTile(title, expiry, days) => Container(
      alignment: Alignment.center,
      height: appSize(context) / 14,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(.3)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.2),
                blurRadius: 9,
                offset: const Offset(0, 1),
                spreadRadius: 6)
          ]),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      // color: Colors.grey.withOpacity(.2),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _leadingWidget(days),
            _body(title, expiry),
            _trailingWidget(),
          ],
        ),
      )
      // ListTile(
      //   leading: Container(
      //     child: Stack(
      //       alignment: Alignment.center,
      //       children: [
      //         Icon(CupertinoIcons.doc_text,
      //             color: Colors.black12.withOpacity(.03),
      //             size: appSize(context) / 20),
      //         Column(
      //           children: [
      //             CircleAvatar(
      //               backgroundColor: AppColors.borderColor,
      //               child: Text(days,
      //                   style: AppStyles.titleTextStyle(context).copyWith(
      //                       color: Colors.white,
      //                       fontWeight: FontWeight.w500,
      //                       fontSize: appSize(context) / 60)),
      //             ),
      //             const SizedBox(height: 6),
      //             Text("DAYS LEFT",
      //                 textAlign: TextAlign.center,
      //                 style: AppStyles.titleTextStyle(context).copyWith(
      //                     height: 1,
      //                     color: AppColors.darkViolet,
      //                     fontWeight: FontWeight.w500,
      //                     fontSize: appSize(context) / 120)),
      //           ],
      //         )
      //       ],
      //     ),
      //   ),
      //   // isThreeLine: true,
      //   // tileColor: Colors.redAccent,
      //   onTap: () {},
      //   title: Text(title,
      //       style: AppStyles.titleTextStyle(context).copyWith(
      //           fontWeight: FontWeight.bold, color: Colors.black87)),
      //   subtitle: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Row(
      //         children: [
      //           Row(
      //             mainAxisSize: MainAxisSize.min,
      //             children: [
      //               Text("Expiry By:",
      //                   style: TextStyle(color: AppColors.borderColor)),
      //               SizedBox(width: 6),
      //               Text(expiry,
      //                   style: TextStyle(
      //                       color: AppColors.borderColor,
      //                       fontWeight: FontWeight.w700)),
      //             ],
      //           ),
      //         ],
      //       ),
      //       const SizedBox(height: 8),
      //       Row(
      //         children: [
      //           GestureDetector(
      //             onTap: () async {
      //               share();
      //               // const url =
      //               //     "https://morth.nic.in/sites/default/files/dd12-13_0.pdf"; // Replace with your file URL
      //               // final response = await http.get(Uri.parse(url));
      //               // // Example: Creating a temporary file to share
      //               // // final Directory tempDir = await getTemporaryDirectory();
      //               // // final File file = File('${tempDir.path}/example.txt');
      //               // // await file.writeAsString('This is an example file to share.');
      //               //
      //               // // Share the file
      //               // if (response.statusCode == 200) {
      //               //   // Get the temporary directory
      //               //   final Directory tempDir = await getTemporaryDirectory();
      //               //   final File file = File('${tempDir.path}/file.pdf');
      //               //
      //               //   // Write the file to the temporary directory
      //               //   await file.writeAsBytes(response.bodyBytes);
      //               //
      //               //   // Share the file
      //               //   // Share.shareXFiles([XFile(file.path)],
      //               //   //     text: 'Check out this file!');
      //               // } else {
      //               //   // Handle error
      //               //   print('Failed to download file.');
      //               // }
      //             },
      //             child: Container(
      //               padding: const EdgeInsets.symmetric(
      //                   horizontal: 6, vertical: 2),
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(22),
      //                   color: AppColors.darkViolet),
      //               child: Row(
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: [
      //                   const Icon(Icons.share_outlined, color: Colors.white),
      //                   const SizedBox(width: 6),
      //                   Text("Share",
      //                       style: AppStyles.titleTextStyle(context).copyWith(
      //                           color: Colors.white,
      //                           fontSize: appSize(context) / 90))
      //                 ],
      //               ),
      //             ),
      //           ),
      //           const SizedBox(width: 8),
      //           // Container(
      //           //   padding:
      //           //       const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      //           //   decoration: BoxDecoration(
      //           //       borderRadius: BorderRadius.circular(22),
      //           //       color: AppColors.darkViolet),
      //           //   child: Row(
      //           //     mainAxisSize: MainAxisSize.min,
      //           //     children: [
      //           //       const Icon(CupertinoIcons.download_circle_fill,
      //           //           color: Colors.white),
      //           //       const SizedBox(width: 6),
      //           //       GestureDetector(
      //           //         onTap: () {
      //                     _launchURL(
      //                         "https://morth.nic.in/sites/default/files/dd12-13_0.pdf");
      //           //           // OpenFilex.open("assets/files/pdf.pdf");
      //           //         },
      //           //         child: Text("Download",
      //           //             style: AppStyles.titleTextStyle(context).copyWith(
      //           //                 color: Colors.white,
      //           //                 fontSize: appSize(context) / 90)),
      //           //       )
      //           //     ],
      //           //   ),
      //           // ),
      //         ],
      //       ),
      //     ],
      //   ),
      //   trailing: Row(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       IconButton(
      //         // splashRadius: 2,
      //         padding: EdgeInsets.zero,
      //         onPressed: () {},
      //         icon: const Icon(CupertinoIcons.download_circle_fill),
      //         color: Colors.amber,
      //       ),
      //       IconButton(
      //         padding: EdgeInsets.zero,
      //
      //         onPressed: () {},
      //         icon: const Icon(CupertinoIcons.share_solid),
      //         color: Colors.amber,
      //       ),
      //     ],
      //   ),
      // ),
      );

  _body(title, expiry) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: AppStyles.titleTextStyle(context).copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.textColor)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Expiry By:",
                    style:
                        TextStyle(color: AppColors.textColor.withOpacity(.8))),
                const SizedBox(width: 6),
                Text(expiry,
                    style: TextStyle(
                        color: AppColors.textColor.withOpacity(.8),
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ],
        ),
      );

  _trailingWidget() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // width: appSize(context) / 30,
            // color: AppColors.brownishPinkLight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  // splashRadius: 2,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    _launchURL(
                        "https://morth.nic.in/sites/default/files/dd12-13_0.pdf");
                  },
                  icon: const Icon(CupertinoIcons.arrow_down_circle,
                      color: AppColors.newLightBlue),
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Container(
            // width: appSize(context) / 30,
            decoration: const BoxDecoration(
                // color: AppColors.green,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    share();
                  },
                  icon: const Icon(Icons.share_outlined),
                  color: AppColors.newLightBlue,
                ),
              ],
            ),
          ),
        ],
      );

  _leadingWidget(String? days) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(CupertinoIcons.doc_text,
                color: Colors.black12.withOpacity(.03),
                size: appSize(context) / 20),
            if (days != null && days.isNotEmpty)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    child: Text(days,
                        style: AppStyles.titleTextStyle(context).copyWith(
                            color: AppColors.newLightBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: appSize(context) / 80)),
                  ),
                  const SizedBox(height: 6),
                  Text("DAYS LEFT",
                      textAlign: TextAlign.center,
                      style: AppStyles.titleTextStyle(context).copyWith(
                          height: 1,
                          color: AppColors.newBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: appSize(context) / 170)),
                ],
              )
          ],
        ),
      );

  _driverDocList(title, String expiry, String days) => Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        color: Colors.grey.withOpacity(.2),
        child: ListTile(
          shape:
              const Border(bottom: BorderSide(color: Colors.black54, width: 2)),
          dense: true,
          // isThreeLine: true,
          // tileColor: Colors.redAccent,
          onTap: () {},
          title: Text(title,
              style: AppStyles.titleTextStyle(context).copyWith(
                  fontWeight: FontWeight.bold, color: Colors.black87)),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (expiry.isNotEmpty)
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 1),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.6),
                          borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Date of expiry:"),
                          SizedBox(width: 6),
                          Text(expiry),
                        ],
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: AppColors.darkViolet),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.share_outlined, color: Colors.white),
                        const SizedBox(width: 6),
                        Text("Share",
                            style: AppStyles.titleTextStyle(context).copyWith(
                                color: Colors.white,
                                fontSize: appSize(context) / 90))
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: AppColors.darkViolet),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(CupertinoIcons.download_circle_fill,
                            color: Colors.white),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: () {
                            _launchURL(
                                "https://morth.nic.in/sites/default/files/dd12-13_0.pdf");
                            // OpenFilex.open("assets/files/pdf.pdf");
                          },
                          child: Text("Download",
                              style: AppStyles.titleTextStyle(context).copyWith(
                                  color: Colors.white,
                                  fontSize: appSize(context) / 90)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: (days.isNotEmpty)
              ? Container(
                  // decoration: BoxDecoration(
                  //     color: Colors.grey.withOpacity(.6),
                  //     borderRadius: BorderRadius.circular(6)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(days,
                          style: AppStyles.titleTextStyle(context).copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: appSize(context) / 50)),
                      Text("days left",
                          textAlign: TextAlign.center,
                          style: AppStyles.titleTextStyle(context).copyWith(
                              height: 1,
                              color: Colors.black87,
                              fontSize: appSize(context) / 120)),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          // trailing: Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     IconButton(
          //         onPressed: () {},
          //         icon: Icon(CupertinoIcons.download_circle_fill)),
          //     IconButton(
          //         onPressed: () {}, icon: Icon(CupertinoIcons.share_solid)),
          //   ],
          // ),
        ),
      );

  _tab(text) => Text(text,
      style: TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.textColor,
          fontSize: appSize(context) / 90));

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://morth.nic.in/sites/default/files/dd12-13_0.pdf',
        chooserTitle: 'Example Chooser Title');
  }

  _launchURL(String url) async {
    // const url = 'https://flutter.dev/exapmle.pdf';
    // if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}
