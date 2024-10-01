import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/common_page_appbar.dart';

import '../../../core/res/app_colors.dart';
import '../../../core/res/app_functions.dart';
import '../../../core/res/app_storage.dart';
import '../../../core/res/app_styles.dart';
import '../../../core/shared/widgets/app_button.dart';
import '../../../core/shared/widgets/app_textfield_with_title.dart';
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
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

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
                  borderRadius:
                      BorderRadius.circular(22), // Optional: round corners
                ),
                child: DropdownMenu<DailyLogModel>(
                  trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: Colors.black87),
                  enabled: true,
                  inputDecorationTheme: const InputDecorationTheme(
                    border: InputBorder.none, // Removes underline
                    focusedBorder:
                        InputBorder.none, // Removes focused underline
                    enabledBorder:
                        InputBorder.none, // Removes enabled underline
                  ),
                  expandedInsets: const EdgeInsets.symmetric(horizontal: 0),
                  textStyle: const TextStyle(color: Colors.black),
                  controller: vehicleController,
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
                  onSelected: (DailyLogModel? menu) {
                    // Handle selected item
                  },
                  dropdownMenuEntries:
                      vehicleList.map<DropdownMenuEntry<DailyLogModel>>((menu) {
                    return DropdownMenuEntry(
                      value: menu,
                      label: menu.lrNo,
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
                              menu.lrNo,
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
                        textFieldHeight: appSize(context) / 22,
                        hint: "Enter Start Km",
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
                        textFieldHeight: appSize(context) / 22,
                        hint: "Enter End Km",
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
                        logDateController.text = await selectDate(context) ?? '';
                        setState(() {

                        });
                        if (logDateController.text.isNotEmpty) {
                          print('Selected Date: ${logDateController.text}');
                        }
                      },
                        controller: logDateController,
                        assestImage: "assets/icons/Group 9720.png",
                        inputType: TextInputType.text,
                        textFieldHeight: appSize(context) / 22,
                        hint: "Enter Log Date",
                        readOnly: false,
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

                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(12),
                  //     border:
                  //     Border.all(color: Colors.grey.withOpacity(.3)),
                  //   ),
                  //   child: Stack(
                  //     children: [
                  //       Container(
                  //         margin: const EdgeInsets.all(6),
                  //         child: SingleChildScrollView(
                  //           reverse: true,
                  //           scrollDirection: Axis.horizontal,
                  //           padding: const EdgeInsets.only(left: 88),
                  //           child: Row(
                  //             crossAxisAlignment:
                  //             CrossAxisAlignment.center,
                  //             // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //             children: [
                  //               ...List.generate(
                  //                   imageFileList?.length ?? 0, (index) {
                  //                 return Stack(
                  //                   children: [
                  //                     GestureDetector(
                  //                       onTap: () {
                  //                         showCupertinoDialog(
                  //                             barrierDismissible: true,
                  //                             context: context,
                  //                             builder: (context) {
                  //                               return Container(
                  //                                 child: Image.file(File(
                  //                                     imageFileList?[
                  //                                     index]
                  //                                         .path ??
                  //                                         "")),
                  //                               );
                  //                             });
                  //                       },
                  //                       child: Container(
                  //                         height: 80,
                  //                         width: 80,
                  //                         margin:
                  //                         const EdgeInsets.symmetric(
                  //                             horizontal: 3),
                  //                         decoration: BoxDecoration(
                  //                             borderRadius:
                  //                             BorderRadius.circular(
                  //                                 12),
                  //                             border: Border.all(
                  //                                 color: Colors.grey),
                  //                             image: DecorationImage(
                  //                                 image: FileImage(File(
                  //                                     imageFileList?[
                  //                                     index]
                  //                                         .path ??
                  //                                         "")),
                  //                                 fit: BoxFit.cover)),
                  //                       ),
                  //                     ),
                  //                     GestureDetector(
                  //                       onTap: () {
                  //                         imageFileList?.removeAt(index);
                  //                         setState(() {});
                  //                       },
                  //                       child: CircleAvatar(
                  //                         radius: appSize(context) / 100,
                  //                         backgroundColor: Colors.red,
                  //                         child: Icon(Icons.close_rounded,
                  //                             color: Colors.white,
                  //                             size:
                  //                             appSize(context) / 80),
                  //                       ),
                  //                     )
                  //                   ],
                  //                 );
                  //               })
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: appSize(context) / 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: AppButton(
                  onPressed: () async {
                    await Future.delayed(const Duration(milliseconds: 1000));
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return Material(
                            child: Center(
                              child: Container(
                                color: Colors.white,
                                margin: EdgeInsets.symmetric(
                                    horizontal: appSize(context) / 80),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 12),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset("assets/gifs/success.gif"),
                                    SizedBox(height: 12),
                                    Text("Expense booking successfully done",
                                        style:
                                            AppStyles.titleTextStyle(context)),
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
                        }).then((value) => Navigator.pop(context));
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

    driverNameController.text = userDetails['name'];
    setState(() {});
    print('check user data ${userDetails}');

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

  Future<String?> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Current date as the initial date
      firstDate: DateTime(2000), // Earliest date the user can pick
      lastDate: DateTime(2100), // Latest date the user can pick
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
          ),
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
