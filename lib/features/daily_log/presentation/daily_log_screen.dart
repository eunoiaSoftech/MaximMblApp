import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logistics_app/core/constants/constants.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/common_page_appbar.dart';
import '../../../core/res/app_colors.dart';
import '../../../core/res/app_functions.dart';
import '../../../core/res/app_storage.dart';
import '../../../core/res/app_styles.dart';
import '../../../core/shared/data/user.dart';
import '../../../core/shared/widgets/app_button.dart';
import '../../../core/shared/widgets/app_textfield_with_title.dart';
import '../data/daily_log_bloc.dart';
import 'package:http/http.dart' as http;
import '../data/daily_log_vehicle_list_event.dart';
import '../data/daily_log_vehicle_list_state.dart';
import '../models/daily_log_model.dart';

class DailyLogScreen extends StatefulWidget {
  const DailyLogScreen({super.key});

  @override
  State<DailyLogScreen> createState() => _DailyLogScreenState();
}

class _DailyLogScreenState extends State<DailyLogScreen> {
  TextEditingController vehicleController = TextEditingController();
  TextEditingController driverNameController = TextEditingController();
  TextEditingController logDateController = TextEditingController();
  TextEditingController startKmController = TextEditingController();
  TextEditingController endKmController = TextEditingController();
  TextEditingController totalKmController = TextEditingController();

  TextEditingController fromLocationController = TextEditingController();
  TextEditingController toLocationController = TextEditingController();
  TextEditingController openingKmController = TextEditingController();
  TextEditingController reasonForTripController = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  List<dynamic> commonList = [];

  late DailyLogVehicleResponse _vehicleListResponse;
  final Completer<void> _completer = Completer<void>();

  Future<void> _processApi() async {
    context.read<DailyLogBloc>().add(DailyLogVehicleListEvent(
          AppStorage().getUserId,
          User.fromJson(AppStorage().getUserDetails).userType ?? 0,
        ));

    context.read<DailyLogBloc>().stream.listen((state) {
      if (state is DailyLogVehicleListLoaded) {
        setState(() {
          _vehicleListResponse = state.resp;
        });

        setState(() {
          vehicleList = _vehicleListResponse.data1!;
        });

        _completer.complete();
      } else if (state is DailyLogVehicleListError) {
        // Handle the error state
        print("Error: ${state.error}");
        _completer.complete();
      }
    });

    await _completer.future;
  }

  List<Vehicle> vehicleList = [];

  bool _validateControllers() {
    List<TextEditingController> controllers = [
      vehicleController,
      driverNameController,
      logDateController,
      startKmController,
      endKmController,
      totalKmController,
      fromLocationController,
      toLocationController,
      openingKmController,
      reasonForTripController,
    ];

    // Check for empty fields
    bool hasEmptyFields = false;
    for (var controller in controllers) {
      if (controller.text.isEmpty) {
        hasEmptyFields = true;
        break; // Exit the loop if any field is empty
      }
    }

    // Show a warning if any controller is empty
    if (hasEmptyFields) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.white,
        ),
      );
      return false;
    }

    return true; // All fields are filled
  }

  void _clearControllers() {
    vehicleController.clear();
    driverNameController.clear();
    logDateController.clear();
    startKmController.clear();
    endKmController.clear();
    totalKmController.clear();
    fromLocationController.clear();
    toLocationController.clear();
    openingKmController.clear();
    reasonForTripController.clear();
    imageFileList?.clear();
    setState(() {});
  }

  void _calculateTotalKm() {
    double? startKm = double.tryParse(startKmController.text);
    double? endKm = double.tryParse(endKmController.text);

    if (startKm != null && endKm != null) {
      setState(() {
        totalKmController.text = (endKm - startKm).toString();
      });
    } else {
      setState(() {
        totalKmController.text = '0';
      });
    }
  }

  Future<void> saveDailyLog() async {
    EasyLoading.show(status: 'loading...');
    const String url = Urls.postDailyLog;

    final String vehicleId = vehicleController.text;
    final String driverName = driverNameController.text;
    final String fromLocation = fromLocationController.text;
    final String toLocation = toLocationController.text;
    final String logDate = logDateController.text;
    final String startKm = startKmController.text;
    final String endKm = endKmController.text;
    final String openingKm = openingKmController.text;
    final String totalKm = totalKmController.text;
    final String reason = reasonForTripController.text;

    final Uri uri = Uri.parse(url).replace(queryParameters: {
      'iFk_VehicleId': vehicleId,
      'sDriverName': driverName,
      'sFromLocation': fromLocation,
      'sToLocation': toLocation,
      'dStartKm': startKm,
      'dEndKm': endKm,
      'sLogDate': logDate,
      'dOpeningKm': openingKm,
      'dTotalKm': totalKm,
      'sReason': reason,
    });

    try {
      var request = http.MultipartRequest('POST', uri);

      // Add images to the request if there are any
      if (imageFileList != null && imageFileList!.isNotEmpty) {
        for (var image in imageFileList!) {
          var multipartFile = await http.MultipartFile.fromPath(
            'File',
            image.path,
            filename: image.path.split('/').last,
          );
          request.files.add(multipartFile); // Add file to the request
        }
      }

      // Send the multipart request
      var response = await request.send();

      // Get the response body
      var responseBody = await http.Response.fromStream(response);

      if (responseBody.statusCode == 200) {
        _clearControllers();
        EasyLoading.dismiss();
        showCupertinoDialog(
            context: context,
            builder: (context) {
              return Material(
                child: Center(
                  child: Container(
                    color: Colors.white,
                    margin:
                        EdgeInsets.symmetric(horizontal: appSize(context) / 80),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/gifs/success.gif"),
                        SizedBox(height: 12),
                        Text("Daily log added successfully",
                            style: AppStyles.titleTextStyle(context)),
                        SizedBox(height: 12),
                        AppButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: "Okay")
                      ],
                    ),
                  ),
                ),
              );
            });
      } else {
        EasyLoading.dismiss();
        // Handle the error response
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      EasyLoading.dismiss(); // Handle any exceptions
      print('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonPageAppBar(
        title: "Daily Log",
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: appSize(context) / 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.5),
                      offset: const Offset(2, 2),
                      spreadRadius: 1,
                      blurRadius: 2,
                    )
                  ],
                  borderRadius: BorderRadius.circular(22),
                ),
                child: DropdownMenu<Vehicle>(
                  trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: Colors.black87),
                  enabled: true,
                  inputDecorationTheme: const InputDecorationTheme(
                    border: InputBorder.none, // Removes underline
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  expandedInsets: const EdgeInsets.symmetric(horizontal: 0),
                  textStyle: const TextStyle(color: Colors.black),
                  // controller: vehicleController,
                  hintText: "Search Vehicle",
                  requestFocusOnTap: true,
                  enableFilter: true,
                  menuStyle: MenuStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.textColor),
                  ),
                  label: const Text(
                    'Select Vehicle',
                    style: TextStyle(color: Colors.black87),
                  ),
                  onSelected: (Vehicle? menu) {
                    setState(() {
                      vehicleController.text = menu!.pkVehicleId.toString();
                    });
                  },
                  dropdownMenuEntries:
                      vehicleList.map<DropdownMenuEntry<Vehicle>>((menu) {
                    return DropdownMenuEntry(
                      value: menu,
                      label: menu.vehicleNo,
                      labelWidget: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 4),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.white, width: 0.8))),
                            width: appSize(context) / 4,
                            child: Text(
                              menu.vehicleNo,
                              maxLines: 2,
                              style: AppStyles.titleTextStyle(context),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: appSize(context) / 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              child: AppTextFieldWithTitle(
                  assestImage: "assets/icons/user.png",
                  inputType: TextInputType.text,
                  textFieldHeight: appSize(context) / 22,
                  hint: "Enter Driver Name",
                  readOnly: false,
                  controller: driverNameController,
                  textFieldName: "Driver Name",
                  maxLines: 1),
            ),
            SizedBox(height: appSize(context) / 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              child: AppTextFieldWithTitle(
                  assestImage: "assets/icons/Icon Group.png",
                  inputType: TextInputType.text,
                  textFieldHeight: appSize(context) / 22,
                  hint: "Enter From Location",
                  readOnly: false,
                  controller: fromLocationController,
                  textFieldName: "From Location",
                  maxLines: 1),
            ),
            SizedBox(height: appSize(context) / 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              child: AppTextFieldWithTitle(
                  assestImage: "assets/icons/Icon Group.png",
                  inputType: TextInputType.text,
                  textFieldHeight: appSize(context) / 22,
                  hint: "Enter To Location",
                  readOnly: false,
                  controller: toLocationController,
                  textFieldName: "To Location",
                  maxLines: 1),
            ),
            SizedBox(height: appSize(context) / 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              child: Row(
                children: [
                  Expanded(
                    child: AppTextFieldWithTitle(
                        assestImage: "assets/icons/Group 10013.png",
                        inputType: TextInputType.number,
                        controller: startKmController,
                        textFieldHeight: appSize(context) / 22,
                        hint: "Enter Start Km",
                        onChanged: (val) {
                          _calculateTotalKm();
                        },
                        readOnly: false,
                        textFieldName: "Start Km",
                        maxLines: 1),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: AppTextFieldWithTitle(
                        assestImage: "assets/icons/Group 10014.png",
                        inputType: TextInputType.number,
                        controller: endKmController,
                        textFieldHeight: appSize(context) / 22,
                        hint: "Enter End Km",
                        onChanged: (val) {
                          _calculateTotalKm();
                        },
                        readOnly: false,
                        textFieldName: "End Km",
                        maxLines: 1),
                  )
                ],
              ),
            ),
            SizedBox(height: appSize(context) / 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              child: Row(
                children: [
                  Expanded(
                    child: AppTextFieldWithTitle(
                        onTap: () async {
                          logDateController.text =
                              await selectDate(context) ?? '';
                          setState(() {});
                          if (logDateController.text.isNotEmpty) {
                            print('Selected Date: ${logDateController.text}');
                          }
                        },
                        controller: logDateController,
                        assestImage: "assets/icons/Group 9720.png",
                        inputType: TextInputType.text,
                        textFieldHeight: appSize(context) / 22,
                        hint: "Enter Log Date",
                        readOnly: true,
                        textFieldName: "Log Date",
                        maxLines: 1),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: AppTextFieldWithTitle(
                        assestImage: "assets/icons/Group 10015.png",
                        inputType: TextInputType.number,
                        textFieldHeight: appSize(context) / 22,
                        hint: "Enter Opening Km",
                        readOnly: false,
                        controller: openingKmController,
                        textFieldName: "Opening Km",
                        maxLines: 1),
                  )
                ],
              ),
            ),
            SizedBox(height: appSize(context) / 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              child: AppTextFieldWithTitle(
                  assestImage: "assets/icons/Group 10015.png",
                  inputType: TextInputType.number,
                  textFieldHeight: appSize(context) / 22,
                  hint: "Total km",
                  readOnly: false,
                  controller: totalKmController,
                  textFieldName: "Total Km",
                  maxLines: 1),
            ),
            SizedBox(height: appSize(context) / 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              child: AppTextFieldWithTitle(
                  assestImage: "assets/icons/Group 10017.png",
                  inputType: TextInputType.text,
                  textFieldHeight: appSize(context) / 22,
                  controller: reasonForTripController,
                  hint: "Enter Reason for trip",
                  readOnly: false,
                  textFieldName: "Reason for trip",
                  maxLines: 1),
            ),
            SizedBox(height: appSize(context) / 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 10, left: 20),
                        child: Image(
                          image: AssetImage(
                            "assets/icons/Group 10020.png",
                          ),
                          height: 18,
                        ),
                      ),
                      Text("Upload",
                          style: AppStyles.hintTextStyle(context).copyWith()),
                    ],
                  ),
                  SizedBox(height: appSize(context) / 100),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.5),
                          offset: const Offset(2, 2),
                          spreadRadius: 1,
                          blurRadius: 2,
                        )
                      ],
                      borderRadius:
                          BorderRadius.circular(22), // Optional: round corners
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Upload File",
                            style: AppStyles.hintTextStyle(context).copyWith()),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            openCamera();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.5),
                                  offset: const Offset(2, 2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                )
                              ],
                              borderRadius: BorderRadius.circular(
                                  22), // Optional: round corners
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Row(
                                children: [
                                  const Image(
                                    image: AssetImage(
                                      "assets/icons/Group 10021.png",
                                    ),
                                    height: 15,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("Camera",
                                      style: AppStyles.hintTextStyle(context)
                                          .copyWith(fontSize: 13)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            selectImages();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.5),
                                  offset: const Offset(2, 2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                )
                              ],
                              borderRadius: BorderRadius.circular(
                                  22), // Optional: round corners
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Row(
                                children: [
                                  const Image(
                                    image: AssetImage(
                                      "assets/icons/Group 10022.png",
                                    ),
                                    height: 15,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("Photo",
                                      style: AppStyles.hintTextStyle(context)
                                          .copyWith(fontSize: 13)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (imageFileList!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Row(
                            children: List.generate(imageFileList?.length ?? 0,
                                (index) {
                              return Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showCupertinoDialog(
                                          barrierDismissible: true,
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              child: Image.file(File(
                                                  imageFileList?[index].path ??
                                                      "")),
                                            );
                                          });
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border:
                                              Border.all(color: Colors.grey),
                                          image: DecorationImage(
                                              image: FileImage(File(
                                                  imageFileList?[index].path ??
                                                      "")),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      imageFileList?.removeAt(index);
                                      setState(() {});
                                    },
                                    child: CircleAvatar(
                                      radius: appSize(context) / 100,
                                      backgroundColor: Colors.red,
                                      child: Icon(Icons.close_rounded,
                                          color: Colors.white,
                                          size: appSize(context) / 80),
                                    ),
                                  )
                                ],
                              );
                            }),
                          ),
                        )
                      ],
                    )
                ],
              ),
            ),
            SizedBox(height: appSize(context) / 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: AppButton(
                  onPressed: () async {
                    if (_validateControllers()) {
                      saveDailyLog();
                    }
                  },
                  text: "Submit"),
            ),
            SizedBox(height: appSize(context) / 70),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    var userDetails = AppStorage().getUserDetails;
    _processApi();

    driverNameController.text = userDetails['name'];
    setState(() {});
  }

  _pickImage() => Container(
        height: 80,
        width: 80,
        padding: const EdgeInsets.all(22),
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: IconButton(
          onPressed: () {
            showModalBottomSheet(
                showDragHandle: true,
                backgroundColor: Colors.white,
                context: context,
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Select photo",
                            style: AppStyles.titleTextStyle(context)
                                .copyWith(color: Colors.grey)),
                        Divider(color: Colors.black54),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(44),
                                  onTap: () => selectImages(),
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      // borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(.6)),
                                    ),
                                    child: Icon(CupertinoIcons
                                        .photo_fill_on_rectangle_fill),
                                  ),
                                ),
                                Text("Gallery",
                                    style: AppStyles.inputTextStyle(context)
                                        .copyWith(color: Colors.grey)),
                              ],
                            ),
                            const SizedBox(width: 22),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(44),
                                  onTap: () => openCamera(),
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      // borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(.6)),
                                    ),
                                    child: Icon(Icons.camera),
                                  ),
                                ),
                                Text("Camera",
                                    style: AppStyles.inputTextStyle(context)
                                        .copyWith(color: Colors.grey)),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                });
          },
          icon: const Icon(CupertinoIcons.add),
          color: Colors.black54,
        ),
      );

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    log("Image List Length: ${imageFileList!.length}");
    setState(() {});
  }

  void openCamera() async {
    final XFile? img = await imagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      imageFileList!.add(img);
    }
    log("Image List Length: ${imageFileList!.length}");
    setState(() {});
  }
}

Future<String?> selectDate(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(), // Current date as the initial date
    firstDate: DateTime(2000), // Earliest date the user can pick
    lastDate: DateTime(2100), // Latest date the user can pick
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(),
        child: Container(
          color: Colors.white, // Set the background color to white
          child: child!,
        ),
      );
    },
  );

  if (pickedDate != null) {
    // Format the picked date in the format dd-MM-yyyy
    String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
    return formattedDate;
  }

  return null; // Return null if no date was selected
}

