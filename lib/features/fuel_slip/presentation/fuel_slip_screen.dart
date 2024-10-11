import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../core/constants/constants.dart';
import '../../../core/res/app_colors.dart';
import '../../../core/res/app_functions.dart';
import '../../../core/res/app_storage.dart';
import '../../../core/res/app_styles.dart';
import '../../../core/shared/data/user.dart';
import '../../../core/shared/widgets/app_button.dart';
import '../../../core/shared/widgets/app_textfield_with_title.dart';
import '../../daily_log/data/daily_log_bloc.dart';
import '../../daily_log/data/daily_log_vehicle_list_event.dart';
import '../../daily_log/data/daily_log_vehicle_list_state.dart';
import '../../daily_log/models/daily_log_model.dart';
import '../../daily_log/presentation/daily_log_screen.dart';
import '../../home/presentation/ui/widgets/common_page_appbar.dart';

class FuelSlipScreen extends StatefulWidget {
  const FuelSlipScreen({super.key});

  @override
  State<FuelSlipScreen> createState() => _FuelSlipScreenState();
}

class _FuelSlipScreenState extends State<FuelSlipScreen> {
  var fuelUnit = ['ltr', 'kgs'];

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
  var selectedFuelUnitController = TextEditingController();
  var fuelQtyController = TextEditingController();
  var logDateController = TextEditingController();
  TextEditingController driverNameController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var userDetails = AppStorage().getUserDetails;
    _processApi();

    driverNameController.text = userDetails['name'];
    setState(() {});
  }

  bool _validateControllers() {
    List<TextEditingController> controllers = [
      selectedFuelUnitController,
      vehicleController,
      driverNameController,
      logDateController,
      fuelQtyController,
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
    selectedFuelUnitController.clear();
    vehicleController.clear();
    logDateController.clear();
    fuelQtyController.clear();
    setState(() {});
  }

  Future<void> saveFuelSlip() async {
    EasyLoading.show(status: 'loading...');
    const String url = Urls.saveFuelSlip;

    final Uri uri = Uri.parse(url).replace(queryParameters: {
      'iVehicleNo': vehicleController.text,
      'sDriverName': driverNameController.text,
      'sEntryDate': logDateController.text,
      'dQty': fuelQtyController.text,
      'iUOM': selectedFuelUnitController.text == 'ltr' ? '1' : '2',
    });

    try {
      var request = http.MultipartRequest('POST', uri);

      // Send the multipart request
      var response = await request.send();

      // Get the response body
      var responseBody = await http.Response.fromStream(response);

      print('check response ${response.statusCode}');
      print('check response ${responseBody.body}');

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
                        Text("Fuel Slip added successfully",
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
      appBar: const CommonPageAppBar(
        title: "Fuel Slip",
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
                child: DropdownMenu<String>(
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
                  hintText: "Fuel unit",
                  requestFocusOnTap: true,
                  enableFilter: true,
                  menuStyle: MenuStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.textColor),
                  ),
                  label: const Text(
                    'Uom',
                    style: TextStyle(color: Colors.black87),
                  ),
                  onSelected: (String? menu) {
                    setState(() {
                      selectedFuelUnitController.text = menu!.toString();
                    });
                  },
                  dropdownMenuEntries:
                      fuelUnit.map<DropdownMenuEntry<String>>((menu) {
                    return DropdownMenuEntry(
                      value: menu,
                      label: menu,
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
                              menu,
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
                  // assestImage: "assets/icons/Icon Group.png",
                  inputType: TextInputType.text,
                  textFieldHeight: appSize(context) / 22,
                  hint: "Enter fuel qty",
                  readOnly: false,
                  controller: fuelQtyController,
                  textFieldName: "Fuel qty",
                  maxLines: 1),
            ),
            SizedBox(height: appSize(context) / 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              child: AppTextFieldWithTitle(
                  onTap: () async {
                    logDateController.text = await selectDate(context) ?? '';
                    setState(() {});
                    if (logDateController.text.isNotEmpty) {
                      print('Selected Date: ${logDateController.text}');
                    }
                  },
                  controller: logDateController,
                  // assestImage: "assets/icons/Group 9720.png",
                  inputType: TextInputType.text,
                  textFieldHeight: appSize(context) / 22,
                  hint: "Entry Date",
                  readOnly: true,
                  textFieldName: "Entry Date",
                  maxLines: 1),
            ),
            SizedBox(height: appSize(context) / 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: AppButton(
                  onPressed: () async {
                    if (_validateControllers()) {
                      saveFuelSlip();
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
}
