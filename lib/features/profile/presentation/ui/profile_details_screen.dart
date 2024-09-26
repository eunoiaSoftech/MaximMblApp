import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/common_page_appbar.dart';

import '../../../../core/res/app_functions.dart';
import '../../../../core/res/app_icons.dart';
import '../../../../core/res/app_styles.dart';
import '../../../../core/shared/widgets/app_textfield.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
  TextEditingController panNoController = TextEditingController();
  TextEditingController joiningDateController = TextEditingController();
  TextEditingController driverCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController licenseExpiryController = TextEditingController();
  TextEditingController aadharNoController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController branchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonPageAppBar(
        title: "Profile Details",
      ),
      body: _getBodyView(),
    );
  }

  Widget _getBodyView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          // Profile Circular Widget with Edit Icon
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: appSize(context) / 25,
                backgroundImage: const AssetImage(AppIcons.kIconProfile),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    // Handle edit profile picture
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text("Personal Details",
                  style: AppStyles.titleTextStyle(context).copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: appSize(context) / 60)),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField(nameController, "Name"),
          const SizedBox(height: 16),
          _buildTextField(phoneController, "Phone No"),
          const SizedBox(height: 16),
          _buildTextField(dobController, "Date of Birth"),
          const SizedBox(height: 16),
          _buildTextField(addressController, "Address"),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField(aadharNoController, "Aadhar No"),
              ),
              const SizedBox(width: 10),
              Expanded(child: _buildTextField(panNoController, "PAN No")),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text("Other Details",
                  style: AppStyles.titleTextStyle(context).copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: appSize(context) / 60)),
            ],
          ),

          const SizedBox(height: 16),

          _buildTextField(joiningDateController, "Date of Joining"),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField(licenseController, "License No"),
              ),
              const SizedBox(width: 10),
              Expanded(
                child:
                    _buildTextField(licenseExpiryController, "License Expiry"),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Row(
            children: [
              Text("Bank Details",
                  style: AppStyles.titleTextStyle(context).copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: appSize(context) / 60)),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField(accountNoController, "Account No."),
          const SizedBox(height: 16),
          _buildTextField(ifscController, "IFSC"),
          const SizedBox(height: 16),
          _buildTextField(bankNameController, "Bank Name"),
          const SizedBox(height: 16),
          _buildTextField(branchController, "Branch"),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return AppTextField(
      controller: controller,
      hintText: hintText,
    );
  }
}
