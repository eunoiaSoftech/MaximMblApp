import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/common_page_appbar.dart';

import '../../../core/res/app_colors.dart';
import '../../../core/res/app_functions.dart';
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
              child: DropdownMenu<DailyLogModel>(
                trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: Colors.black87),
                enabled: true,
                inputDecorationTheme: const InputDecorationTheme(
                  // border: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(
                      // borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.black38)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38)),
                  // outlineBorder: BorderSide(color: Colors.black)
                ),
                expandedInsets: const EdgeInsets.symmetric(horizontal: 0),
                textStyle: const TextStyle(color: Colors.black),
                //initialSelection: menuItems.first,
                controller: vehicleController,
                // width: width,
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
                  // setState(() {
                  //   selectedMenu = menu;
                  //   menuController.text = menu?.label ?? "";
                  // });
                },
                dropdownMenuEntries:
                    vehicleList.map<DropdownMenuEntry<DailyLogModel>>((menu) {
                  return DropdownMenuEntry(
                      value: menu,
                      label: menu.lrNo,
                      labelWidget: Row(
                        children: [
                          Container(
                            // color: Colors.pink,
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
                      ));
                }).toList(),
              ),
            ),
            SizedBox(height: appSize(context) / 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              child: AppTextFieldWithTitle(
                  inputType: TextInputType.text,
                  textFieldHeight: appSize(context) / 22,
                  hint: "Driver Name",
                  readOnly: false,
                  textFieldName: "Enter Driver Name",
                  maxLines: 1),
            ),
            SizedBox(height: appSize(context) / 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              child: Row(
                children: [
                  Expanded(
                    child: AppTextFieldWithTitle(
                        inputType: TextInputType.text,
                        textFieldHeight: appSize(context) / 22,
                        hint: "Log Date",
                        readOnly: false,
                        textFieldName: "Enter Log Date",
                        maxLines: 1),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: AppTextFieldWithTitle(
                        inputType: TextInputType.text,
                        textFieldHeight: appSize(context) / 22,
                        hint: "Opening Km",
                        readOnly: false,
                        textFieldName: "Enter Opening Km",
                        maxLines: 1),
                  )
                ],
              ),
            ),
            SizedBox(height: appSize(context) / 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              child: AppTextFieldWithTitle(
                  inputType: TextInputType.text,
                  textFieldHeight: appSize(context) / 22,
                  hint: "From Location",
                  readOnly: false,
                  textFieldName: "Enter From Location",
                  maxLines: 1),
            ),
            SizedBox(height: appSize(context) / 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              child: AppTextFieldWithTitle(
                  inputType: TextInputType.text,
                  textFieldHeight: appSize(context) / 22,
                  hint: "To Location",
                  readOnly: false,
                  textFieldName: "Enter To Location",
                  maxLines: 1),
            ),
            SizedBox(height: appSize(context) / 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              child: Row(
                children: [
                  Expanded(
                    child: AppTextFieldWithTitle(
                        inputType: TextInputType.text,
                        textFieldHeight: appSize(context) / 22,
                        hint: "Start Km",
                        readOnly: false,
                        textFieldName: "Enter Start Km",
                        maxLines: 1),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: AppTextFieldWithTitle(
                        inputType: TextInputType.text,
                        textFieldHeight: appSize(context) / 22,
                        hint: "End Km",
                        readOnly: false,
                        textFieldName: "Enter End Km",
                        maxLines: 1),
                  )
                ],
              ),
            ),
            SizedBox(height: appSize(context) / 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              child: AppTextFieldWithTitle(
                  inputType: TextInputType.text,
                  textFieldHeight: appSize(context) / 22,
                  hint: "Total km",
                  readOnly: false,
                  textFieldName: "Total Km",
                  maxLines: 1),
            ),
            SizedBox(height: appSize(context) / 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Upload",
                      style: AppStyles.hintTextStyle(context).copyWith()),
                  SizedBox(height: appSize(context) / 100),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Colors.grey.withOpacity(.3)),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(6),
                                child: SingleChildScrollView(
                                  reverse: true,
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(left: 88),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ...List.generate(
                                          imageFileList?.length ?? 0, (index) {
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
                                                            imageFileList?[
                                                                        index]
                                                                    .path ??
                                                                "")),
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                height: 80,
                                                width: 80,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 3),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    image: DecorationImage(
                                                        image: FileImage(File(
                                                            imageFileList?[
                                                                        index]
                                                                    .path ??
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
                                                    size:
                                                        appSize(context) / 80),
                                              ),
                                            )
                                          ],
                                        );
                                      })
                                    ],
                                  ),
                                ),
                              ),
                              _pickImage()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
    final List<XFile> selectedImages = await imagePicker
        .pickMultiImage()
        .whenComplete(() => Navigator.pop(context));
    if (selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    log("Image List Length: ${imageFileList!.length}");
    setState(() {});
  }

  void openCamera() async {
    final XFile? img = await imagePicker
        .pickImage(source: ImageSource.camera)
        .whenComplete(() => Navigator.pop(context));
    if (img != null) {
      imageFileList!.add(img);
    }
    log("Image List Length: ${imageFileList!.length}");
    setState(() {});
  }
}
