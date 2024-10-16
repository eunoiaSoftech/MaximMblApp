import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logistics_app/core/constants/constants.dart';
import 'package:logistics_app/features/legals/data/datasources/getlegal_document_remote_datasource.dart';
import 'package:logistics_app/features/legals/presentation/widgets/pdf_view.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
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
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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
  Dio dio = Dio();
  final TextEditingController menuController = TextEditingController();
  Data1? selectedMenu;
  String? _fileUrl;
  bool _isLoading = true;

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
                          selectedMenu = state.resp.data1?[0];

                          context.read<LegalDocumentListBloc>().add(
                              LegalDocumentListEvent(
                                  selectedMenu?.pkVehicleId ?? 0));

                          setState(() {});
                        }
                      }
                      setState(() {});
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
                                ? () {
                                    EasyLoading.show(status: 'Loading...');

                                    _renderVehicleList(state.resp.data1 ?? []);
                                  }
                                : () {
                                    EasyLoading.show(status: 'Loading...');

                                    _renderVehicleList(state.resp.data1 ?? []);
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
                                  return SingleChildScrollView(
                                    child: Column(children: [
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
                                          (index) {
                                        if (state.resp.data1?[index].iType ==
                                            1) {
                                          return _vehicleDocListTile(
                                              state.resp.data1?[index].sName,
                                              state.resp.data1?[index]
                                                  .sExpiryDate,
                                              state.resp.data1?[index].noOfDays
                                                  .toString(),
                                              selectedMenu?.pkVehicleId,
                                              state.resp.data1?[index]
                                                  .iFkDocTypeId);
                                        } else {
                                          return Container();
                                        }
                                      })
                                    ]),
                                  );
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
                            BlocConsumer<LegalDocumentListBloc, LegalsState>(
                                builder: (context, state) {
                                  if (state is LegalDocumentListLoaded) {
                                    return SingleChildScrollView(
                                      child: Column(children: [
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
                                            (index) {
                                          if (state.resp.data1?[index].iType ==
                                              2) {
                                            return _vehicleDocListTile(
                                                state.resp.data1?[index].sName,
                                                state.resp.data1?[index]
                                                    .sExpiryDate,
                                                state
                                                    .resp.data1?[index].noOfDays
                                                    .toString(),
                                                selectedMenu?.pkVehicleId,
                                                state.resp.data1?[index]
                                                    .iFkDocTypeId);
                                          } else {
                                            return Container();
                                          }
                                        })
                                      ]),
                                    );
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

  void _renderVehicleList(List<Data1> data) {
    EasyLoading.dismiss();

    AppBottomSheet.show(
        context: context,
        showDragHandle: true,
        color: AppColors.textColor,
        title: "Select Vehicle Number",
        titleColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: data
                    .map((e) => ListTile(
                          onTap: () {
                            log("message ${e.pkVehicleId}");
                            setState(() {
                              selectedMenu = e;
                            });
                            context.read<LegalDocumentListBloc>().add(
                                LegalDocumentListEvent(e.pkVehicleId ?? 0));

                            Navigator.of(context).pop();
                          },
                          title: Text(e.vehicleNo ?? ""),
                        ))
                    .toList() ??
                [],
          ),
        ),
        then: (v) {});
  }

  _vehicleDocListTile(title, expiry, days, pkVehicleId, docTypeId) => Container(
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
            _trailingWidget(pkVehicleId, docTypeId),
          ],
        ),
      ));

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

  _trailingWidget(pkVehicleId, docTypeId) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // width: appSize(context) / 30,
            // color: AppColors.brownishPinkLight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: const Icon(CupertinoIcons.arrow_down_circle),
                    onPressed: () {
                      log("message_driver");
                      log("selectedMenu?.pkVehicleId ${selectedMenu?.pkVehicleId}");
                      log("docTypeId ${docTypeId}");
                      _fetchDocument(selectedMenu?.pkVehicleId, docTypeId);
                    },
                    color: AppColors.newLightBlue),
              ],
            ),
          ),
          // Container(
          //   // width: appSize(context) / 30,
          //   decoration: const BoxDecoration(
          //       // color: AppColors.green,
          //       borderRadius: BorderRadius.only(
          //           topRight: Radius.circular(12),
          //           bottomRight: Radius.circular(12))),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       IconButton(
          //         padding: EdgeInsets.zero,
          //         onPressed: () {
          //           share();
          //         },
          //         icon: const Icon(Icons.share_outlined),
          //         color: AppColors.newLightBlue,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      );

  Future<void> _fetchDocument(vehicleId, docTypeId) async {
    final url =
        'http://47.247.181.6:8089/api/api/GetLegalDocument?iFK_VehicleId=${vehicleId}&iFk_DocTypeId=${docTypeId}';

    print('check driver document url ${url}');

    try {
      EasyLoading.show(status: 'downloading...');

      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          _fileUrl = url;
          _isLoading = false;
        });

        print('check _fileUrl ${_fileUrl}');
        _downloadFile(vehicleId, docTypeId);
      } else {
        EasyLoading.dismiss();
        setState(() {
          _isLoading = false;
        });
        throw Exception('Failed to load document: ${response.reasonPhrase}');
      }
    } catch (error) {
      EasyLoading.dismiss();

      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _downloadFile(vehicleId, docTypeId) async {
    if (_fileUrl == null) return;

    // Request storage permission
    var status = await Permission.manageExternalStorage.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission denied')),
      );
      EasyLoading.dismiss();
      return;
    } else if (status.isPermanentlyDenied) {
      EasyLoading.dismiss();
      await openAppSettings();
      return;
    }

    try {
      EasyLoading.show(status: 'Downloading...');

      // Make the POST request to download the file
      final response = await Dio().post(
        _fileUrl!,
        data: {
          'iFK_VehicleId': vehicleId,
          'iFk_DocTypeId': docTypeId,
        },
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      // Check for a successful response
      if (response.statusCode == 200) {
        final now = DateTime.now();
        final formattedDate =
            '${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}-${now.second}';

        // Determine the file extension based on the content type
        String fileExtension = '';
        String contentType = response.headers.value('Content-Type') ?? '';

        if (contentType.contains('application/pdf')) {
          fileExtension = 'pdf';
        } else if (contentType.contains('image/jpeg')) {
          fileExtension = 'jpg';
        } else if (contentType.contains('image/png')) {
          fileExtension = 'png';
        } else {
          fileExtension = 'bin'; // For unknown file types
        }

        // Construct the file path in the Downloads directory
        final filePath =
            '${(await getDownloadsDirectory())?.path}/downloaded_document_$formattedDate.$fileExtension';

        // Save the downloaded file
        final file = File(filePath);
        await file.writeAsBytes(response.data);

        // Show success message
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File downloaded successfully!')),
        );

        // Open the downloaded file
        OpenFile.open(filePath).then((result) {
          print('File opened: ${result.message}');
        });

        // Print the file location
        print('File location: $filePath');
      } else {
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to download file')),
        );
      }
    } catch (error) {
      EasyLoading.dismiss();
      print('Download error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download file')),
      );
    }
  }

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

  _tab(text) => Text(text,
      style: TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.textColor,
          fontSize: appSize(context) / 90));
}
