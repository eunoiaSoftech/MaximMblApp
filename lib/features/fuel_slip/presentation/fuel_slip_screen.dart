import 'package:flutter/material.dart';

import '../../../core/res/app_colors.dart';
import '../../../core/res/app_functions.dart';
import '../../../core/res/app_styles.dart';
import '../../../core/shared/widgets/app_button.dart';
import '../../../core/shared/widgets/app_textfield_with_title.dart';
import '../../daily_log/presentation/daily_log_screen.dart';
import '../../home/presentation/ui/widgets/common_page_appbar.dart';

class FuelSlipScreen extends StatefulWidget {
  const FuelSlipScreen({super.key});

  @override
  State<FuelSlipScreen> createState() => _FuelSlipScreenState();
}

class _FuelSlipScreenState extends State<FuelSlipScreen> {
  var fuelUnit = ['ltr', 'kgs'];

  var selectedFuelUnitController = TextEditingController();
  var fuelQtyController = TextEditingController();
  var logDateController = TextEditingController();

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
              child: AppButton(onPressed: () async {}, text: "Submit"),
            ),
            SizedBox(height: appSize(context) / 70),
          ],
        ),
      ),
    );
  }
}
