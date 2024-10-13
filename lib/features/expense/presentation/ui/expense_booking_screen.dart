import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_styles.dart';
import 'package:logistics_app/core/shared/data/expense.dart';
import 'package:logistics_app/core/shared/widgets/app_button.dart';
import 'package:logistics_app/core/shared/widgets/app_textfield_with_title.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/common_page_appbar.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/menu_appbar.dart';

class ExpenseBookingScreen extends StatefulWidget {
  const ExpenseBookingScreen(
      {super.key, this.initialMenuItem, this.initialMenuItemSrNo});

  final String? initialMenuItem;
  final String? initialMenuItemSrNo;

  @override
  State<ExpenseBookingScreen> createState() => _ExpenseBookingScreenState();
}

class _ExpenseBookingScreenState extends State<ExpenseBookingScreen> {
  final tripTextController = TextEditingController();

  // late String selectedMenu;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  _callApi() {
    tripTextController.text = widget.initialMenuItem ?? "";
  }

  @override
  void initState() {
    super.initState();
    _callApi();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height / 22;
    return Stack(
      children: [
        Scaffold(
          appBar: CommonPageAppBar(
            title: "Expense Booking",
            height: size,
            bottomLeftCurve: 90,
            // stackedWidget:
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: appSize(context) / 40),
                // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                //   ...List.generate(
                //       expenseMenuList.length,
                //       (index) => _menuContainer(
                //           bgColor: (expenseMenuList[index].selected)
                //               ? AppColors.newBlue.withOpacity(.3)
                //               : Colors.white,
                //           imgAsset: expenseMenuList[index].image,
                //           title: expenseMenuList[index].name,
                //           onTap: () {
                //             setState(() {
                //               // expenseMenuList[index].selected =
                //               //     !expenseMenuList[index].selected;
                //               if (index == 0) {
                //                 expenseMenuList[0].selected = true;
                //                 expenseMenuList[1].selected = false;
                //                 expenseMenuList[2].selected = false;
                //               }
                //               if (index == 1) {
                //                 expenseMenuList[0].selected = false;
                //                 expenseMenuList[1].selected = true;
                //                 expenseMenuList[2].selected = false;
                //               }
                //               if (index == 2) {
                //                 expenseMenuList[1].selected = false;
                //                 expenseMenuList[2].selected = true;
                //                 expenseMenuList[0].selected = false;
                //               }
                //             });
                //           }))
                // ]),
                SizedBox(height: appSize(context) / 70),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 22),
                  padding: const EdgeInsets.only(left: 22),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(33),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(.3),
                            offset: const Offset(2, 2),
                            spreadRadius: 1,
                            blurRadius: 2)
                      ]),
                  child: DropdownMenu<TripsModel>(
                    trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                        color: Colors.black87),
                    enabled: true,
                    width: appSize(context) / 3.9,
                    inputDecorationTheme: const InputDecorationTheme(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        outlineBorder: BorderSide(color: Colors.transparent)),
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

                    // label: const Text(
                    //   'Select TRIP',
                    //   style: TextStyle(color: Colors.black87),
                    // ),
                    onSelected: (TripsModel? menu) {
                      log("message   >> ${menu?.lrNo}");
                      log("message   >> ${menu?.srNo}");
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
                          labelWidget: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 4),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.white, width: 0.8))),
                            width: appSize(context) / 3,
                            child: Text(
                              menu.lrNo,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.titleTextStyle(context),
                            ),
                          ));
                    }).toList(),
                  ),
                ),
                // SizedBox(height: appSize(context) / 70),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(.3),
                            offset: const Offset(1, 1),
                            spreadRadius: 1,
                            blurRadius: 2)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Type of Expense:",
                          style: AppStyles.hintTextStyle(context).copyWith()),
                      SizedBox(height: appSize(context) / 100),
                      Row(
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
                      SizedBox(height: appSize(context) / 50),
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          AppTextFieldWithTitle(
                              borderCircular: 33,
                              inputType: TextInputType.number,
                              textFieldHeight: appSize(context) / 22,
                              hint: "Enter Total Amount",
                              readOnly: false,
                              textFieldName: "        Enter Amount",
                              maxLines: 1),
                          Image.asset("assets/images/new/dollar_circle.png",
                              width: appSize(context) / 55)
                        ],
                      ),
                      SizedBox(height: appSize(context) / 50),
                      // AppTextFieldWithTitle(
                      //     textFieldHeight: appSize(context) / 10,
                      //     hint: "Enter Expenses in detail",
                      //     readOnly: false,
                      //     textFieldName: "Expenses Details",
                      //     maxLines: 5),
                      // SizedBox(height: appSize(context) / 70),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/images/new/file_up.png",
                                  width: appSize(context) / 65),
                              const SizedBox(width: 10),
                              Text("Add Expenses:",
                                  style: AppStyles.hintTextStyle(context)
                                      .copyWith()),
                            ],
                          ),
                          SizedBox(height: appSize(context) / 100),
                          _addExpensesWidget()
                        ],
                      ),
                      SizedBox(height: appSize(context) / 30),
                      AppButton(
                          verticalPadding: 10,
                          onPressed: () async {
                            await Future.delayed(
                                const Duration(milliseconds: 1000));
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
                                            Image.asset(
                                                "assets/gifs/success.gif"),
                                            SizedBox(height: 12),
                                            Text(
                                                "Expense booking successfully done",
                                                style: AppStyles.titleTextStyle(
                                                    context)),
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
                      SizedBox(height: appSize(context) / 70),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            top: size + 60,
            child: Material(
                color: Colors.transparent, child: _expenseCategoryWidget())),
      ],
    );
  }

  Widget _addExpensesWidget() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(44),
                  // border: Border.all(color: Colors.grey.withOpacity(.3)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.3),
                        offset: const Offset(1, 1),
                        spreadRadius: 1,
                        blurRadius: 2)
                  ]),
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.all(6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(44),
                      child: SingleChildScrollView(
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: appSize(context) / 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ...List.generate(imageFileList?.length ?? 0,
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
                                      height: 70,
                                      width: 70,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          // borderRadius: BorderRadius.circular(12),
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
                                      radius: appSize(context) / 120,
                                      backgroundColor: Colors.red,
                                      child: Icon(Icons.close_rounded,
                                          color: Colors.white,
                                          size: appSize(context) / 80),
                                    ),
                                  )
                                ],
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                  _pickImage()
                ],
              ),
            ),
          ),
        ],
      );

  _pickImage() => Container(
        height: 70,
        width: 70,
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          // borderRadius: BorderRadius.circular(12),
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
                                    child: Image.asset(
                                        "assets/images/new/image.png",
                                        height: appSize(context) / 50),
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
                                    child: Image.asset(
                                        "assets/images/new/camera.png",
                                        height: appSize(context) / 50),
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

  _expenseTypeWidget(asset, title, selected, onTap) => Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                // width: appSize(context)/15,
                padding: const EdgeInsets.symmetric(vertical: 22),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          offset: const Offset(1, 1),
                          spreadRadius: 1,
                          blurRadius: 2)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset(asset, height: appSize(context) / 60),
                        const SizedBox(height: 10),
                        Text(title,
                            style: AppStyles.titleTextStyle(context).copyWith(
                                color: Colors.black54,
                                fontSize: appSize(context) / 95)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // if (selected)
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.circular(6)),
                child: Icon(
                  Icons.check_circle,
                  color: selected ? AppColors.green : Colors.transparent,
                  size: appSize(context) / 80,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _expenseCategoryWidget() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          ...List.generate(
              expenseMenuList.length,
              (index) => _menuContainer(
                  bgColor: (expenseMenuList[index].selected)
                      ? AppColors.newBlue
                      : Colors.white,
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
      );

  _menuContainer(
          {required String imgAsset,
          required String title,
          required Color bgColor,
          required Function()? onTap}) =>
      Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.3),
                        offset: const Offset(2, 2),
                        spreadRadius: 0.5,
                        blurRadius: 1)
                  ]
                  // border: Border.all(color: Colors.grey.withOpacity(.3)),
                  ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(imgAsset, height: appSize(context) / 90),
                  const SizedBox(width: 4),
                  Text(title,
                      style: AppStyles.titleTextStyle(context).copyWith(
                          fontSize: appSize(context) / 100,
                          color: Colors.black))
                ],
              )),
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
