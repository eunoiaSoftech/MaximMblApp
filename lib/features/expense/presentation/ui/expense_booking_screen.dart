import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_styles.dart';
import 'package:logistics_app/core/shared/data/expense.dart';
import 'package:logistics_app/core/shared/widgets/app_button.dart';
import 'package:logistics_app/core/shared/widgets/app_textfield_with_title.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/menu_appbar.dart';

class ExpenseBookingScreen extends StatefulWidget {
  const ExpenseBookingScreen({super.key});

  @override
  State<ExpenseBookingScreen> createState() => _ExpenseBookingScreenState();
}

class _ExpenseBookingScreenState extends State<ExpenseBookingScreen> {
  final tripTextController = TextEditingController();
  late String selectedMenu;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenuAppbar(
        title: "Expense Booking",
        // titleWidget: Row(
        //   children: [
        //     Expanded(
        //       // color: Colors.black,
        //       child: Container(
        //         // color: Colors.amber,
        //         child: DropdownMenu<MenuItem>(
        //           enabled: true,
        //           inputDecorationTheme: const InputDecorationTheme(
        //             // border: UnderlineInputBorder(),
        //             focusedBorder: UnderlineInputBorder(
        //               // borderRadius: BorderRadius.circular(12),
        //                 borderSide: BorderSide(color: Colors.white38)),
        //             enabledBorder: UnderlineInputBorder(
        //                 borderSide: BorderSide(color: Colors.white38)),
        //             // outlineBorder: BorderSide(color: Colors.black)
        //           ),
        //           expandedInsets: const EdgeInsets.symmetric(horizontal: 0),
        //           textStyle: const TextStyle(color: Colors.white),
        //           //initialSelection: menuItems.first,
        //           controller: menuController,
        //           width: width,
        //           hintText: "Search vehicle No.",
        //           requestFocusOnTap: true,
        //           enableFilter: true,
        //           menuStyle: MenuStyle(
        //             backgroundColor:
        //             MaterialStateProperty.all<Color>(AppColors.textColor),
        //           ),
        //
        //           label: const Text(
        //             'Select Vehicle',
        //             style: TextStyle(color: Colors.white70),
        //           ),
        //           onSelected: (MenuItem? menu) {
        //             setState(() {
        //               selectedMenu = menu;
        //               menuController.text = menu?.label ?? "";
        //             });
        //           },
        //           dropdownMenuEntries: menuItems
        //               .map<DropdownMenuEntry<MenuItem>>((MenuItem menu) {
        //             return DropdownMenuEntry<MenuItem>(
        //                 value: menu, label: menu.label);
        //           }).toList(),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: appSize(context) / 40),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              ...List.generate(
                  expenseMenuList.length,
                  (index) => _menuContainer(
                      bgColor: (expenseMenuList[index].selected)
                          ? AppColors.newBlue.withOpacity(.3)
                          : Colors.transparent,
                      imgAsset: expenseMenuList[index].image,
                      title: expenseMenuList[index].name,
                      onTap: () {
                        setState(() {
                          // expenseMenuList[index].selected =
                          //     !expenseMenuList[index].selected;
                          if (index == 0) {
                            expenseMenuList[0].selected = true;
                            expenseMenuList[1].selected = false;
                            expenseMenuList[2].selected = false;
                          }
                          if (index == 1) {
                            expenseMenuList[0].selected = false;
                            expenseMenuList[1].selected = true;
                            expenseMenuList[2].selected = false;
                          }
                          if (index == 2) {
                            expenseMenuList[1].selected = false;
                            expenseMenuList[2].selected = true;
                            expenseMenuList[0].selected = false;
                          }
                        });
                      }))
            ]),
            SizedBox(height: appSize(context) / 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownMenu<TripsModel>(
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
                controller: tripTextController,
                // width: width,
                hintText: "Search TRIP",
                requestFocusOnTap: true,
                enableFilter: true,
                menuStyle: MenuStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.textColor),
                ),

                label: const Text(
                  'Select TRIP',
                  style: TextStyle(color: Colors.black87),
                ),
                onSelected: (TripsModel? menu) {
                  // setState(() {
                  //   selectedMenu = menu;
                  //   menuController.text = menu?.label ?? "";
                  // });
                },
                dropdownMenuEntries:
                    tripsList.map<DropdownMenuEntry<TripsModel>>((menu) {
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
                            width: appSize(context) / 3.5,
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
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Type of Expense:",
                      style: AppStyles.hintTextStyle(context).copyWith()),
                  SizedBox(height: appSize(context) / 100),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...List.generate(
                            expenseTypeList.length,
                            (index) => _expenseTypeWidget(
                                    expenseTypeList[index].image,
                                    expenseTypeList[index].name,
                                    expenseTypeList[index].selected, () {
                                  setState(() {
                                    expenseTypeList[index].selected =
                                        !expenseTypeList[index].selected;
                                  });
                                })),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: appSize(context) / 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              child: AppTextFieldWithTitle(
                  inputType: TextInputType.number,
                  textFieldHeight: appSize(context) / 22,
                  hint: "Enter Total Amount",
                  readOnly: false,
                  textFieldName: "Enter Amount",
                  maxLines: 1),
            ),
            SizedBox(height: appSize(context) / 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              child: AppTextFieldWithTitle(
                  textFieldHeight: appSize(context) / 10,
                  hint: "Enter Expenses in detail",
                  readOnly: false,
                  textFieldName: "Expenses Details",
                  maxLines: 5),
            ),
            SizedBox(height: appSize(context) / 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Click Photos:",
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

  _expenseTypeWidget(asset, title, selected, onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
              color: selected
                  ? AppColors.newLightBlue.withOpacity(.3)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.grey, width: 0.8)),
          child: Row(
            children: [
              if (selected)
                Icon(
                  Icons.check_circle,
                  color: AppColors.green,
                  size: appSize(context) / 80,
                ),
              if (selected) const SizedBox(width: 6),
              Image.asset(asset, width: appSize(context) / 60),
              const SizedBox(width: 6),
              Text(title,
                  style: AppStyles.titleTextStyle(context)
                      .copyWith(color: Colors.black54)),
            ],
          ),
        ),
      );

  _menuContainer(
          {required String imgAsset,
          required String title,
          required Color bgColor,
          required Function()? onTap}) =>
      Container(
          height: appSize(context) / 14,
          width: appSize(context) / 12,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.grey.withOpacity(.3))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: onTap, icon: Image.asset(imgAsset, width: 40)),
              Text(title,
                  style: AppStyles.titleTextStyle(context).copyWith(
                      fontSize: appSize(context) / 90,
                      height: 1,
                      color: Colors.black))
            ],
          ));

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
