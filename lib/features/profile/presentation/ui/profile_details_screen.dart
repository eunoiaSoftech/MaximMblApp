import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logistics_app/core/services/func_sertives.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/common_page_appbar.dart';
import 'package:logistics_app/features/profile/presentation/ui/widgets/expandable_tiles_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/res/app_storage.dart';

class ProfileDetailsScreen extends StatefulWidget {
  ProfileDetailsScreen({super.key, required this.response});
  Map<String, dynamic> response;

  @override
  State createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  Uint8List? _imageBytes;
  bool _isLoading = true;
  bool _hasError = false;
  var userType;
  var userId;

  @override
  void initState() {
    super.initState();

    var userDetails = AppStorage().getUserDetails;
    userType = userDetails['userType'];
    userId = userDetails['userId'];

    _fetchProfileImage();
  }

  Future<void> _fetchProfileImage() async {
    String apiUrl =
        "http://47.247.181.6:8089/api/api/GetProfileImage?iFk_UserId=$userId";

    try {
      final response = await http.post(Uri.parse(apiUrl));

      print('Status Code: ${response.statusCode}');
      print('Response Length: ${response.contentLength}');

      if (response.statusCode == 200) {
        setState(() {
          _imageBytes = response.bodyBytes;
          _isLoading = false;
          _hasError = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.response['data1'][0];

    return Scaffold(
      appBar: CommonPageAppBar(
        title: "Profile Details",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            // Profile Circular Widget with Edit Icon
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: <Widget>[
                          _isLoading
                              ? Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[
                                            300], // Shimmer color while loading
                                        shape: BoxShape.circle),
                                    width: 70,
                                    height: 70,
                                  ),
                                )
                              : _hasError
                                  ? const Icon(Icons.error)
                                  : CircleAvatar(
                                      radius: 40,
                                      backgroundImage:
                                          MemoryImage(_imageBytes!),
                                    ),
                          // Positioned(
                          //   bottom: -0,
                          //   right: 3,
                          //   child: Container(
                          //     decoration: const BoxDecoration(
                          //         color: AppColors.newLightBlue,
                          //         shape: BoxShape.circle),
                          //     child: const Padding(
                          //       padding: EdgeInsets.all(3.0),
                          //       child: Icon(
                          //         Icons.camera_alt,
                          //         color: Colors.white,
                          //         size: 20,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    getValidatedString(userData['name']),
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    getValidatedString(userData['phNo']),
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            CustomExpansionTile(
              title: "Personal Details",
              children: [
                _buildKeyValueRow(
                  "Date of Birth",
                  getValidatedString(userData['dateOfBirth']),
                ),
                _buildKeyValueRow(
                  "Address",
                  getValidatedString(userData['address']),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Other Details Expansion
            CustomExpansionTile(
              title: "Other Details",
              children: [
                _buildKeyValueRow(
                    "Aadhar No", getValidatedString(userData['adharNo'])),
                _buildKeyValueRow(
                    "PAN No", getValidatedString(userData['BXMPR0648M'])),
                _buildKeyValueRow("Date of Joining",
                    getValidatedString(userData['dateOfJoining'])),
                _buildKeyValueRow(
                    "License No", getValidatedString(userData['licenseNo'])),
                _buildKeyValueRow("License Expiry",
                    getValidatedString(userData['licenseExpiryDate'])),
              ],
            ),
            const SizedBox(height: 16),
            // Bank Details Expansion
            CustomExpansionTile(
              title: "Bank Details",
              children: [
                _buildKeyValueRow(
                    "Account No.", getValidatedString(userData['acNo'])),
                _buildKeyValueRow(
                    "IFSC", getValidatedString(userData['ifscCode'])),
                _buildKeyValueRow(
                    "Bank Name", getValidatedString(userData['bankName'])),
                _buildKeyValueRow(
                    "Branch", getValidatedString(userData['branch'])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyValueRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              key,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              value,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.6)),
            ),
          ),
        ],
      ),
    );
  }
}
