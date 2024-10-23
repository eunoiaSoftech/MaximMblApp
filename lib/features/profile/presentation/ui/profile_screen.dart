import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:logistics_app/features/profile/presentation/ui/profile_details_screen.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/res/app_bottomsheet.dart';
import '../../../../core/res/app_colors.dart';
import '../../../../core/res/app_functions.dart';
import '../../../../core/res/app_icons.dart';
import '../../../../core/res/app_storage.dart';
import '../../../../core/res/app_styles.dart';
import '../../../../core/shared/widgets/app_bottom_action_widget.dart';
import '../../../auth/presentation/ui/login_screen.dart';
import '../../../home/presentation/ui/widgets/drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? _imageBytes;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc()..add(FetchProfileEvent()),
      child: Scaffold(
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return Column(
              children: [
                state is ProfileLoading
                    ? shimmerLoadingWidget(context)
                    : Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(80))),
                        child: Container(
                          padding:
                              const EdgeInsets.only(top: 16, left: 0, right: 0),
                          decoration: const BoxDecoration(
                            color: AppColors.newLightBlue,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50)),
                          ),
                          child: SafeArea(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Back button

                                // User avatar and name
                                if (state is ProfileLoaded) ...[
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 2.0,
                                        ),
                                        bottom: BorderSide(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
                                                  color: Colors.white
                                                      .withOpacity(0.3),
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  _isLoading
                                                      ? Shimmer.fromColors(
                                                          baseColor:
                                                              Colors.grey[300]!,
                                                          highlightColor:
                                                              Colors.grey[100]!,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                            .grey[
                                                                        300], // Shimmer color while loading
                                                                    shape: BoxShape
                                                                        .circle),
                                                            width: 70,
                                                            height: 70,
                                                          ),
                                                        )
                                                      : _hasError
                                                          ? const Icon(
                                                              Icons.error)
                                                          : CircleAvatar(
                                                              radius: 40,
                                                              backgroundImage:
                                                                  MemoryImage(
                                                                      _imageBytes!),
                                                            ),
                                                  const SizedBox(height: 5),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        state.profileData[
                                                                    'data1'][0]
                                                                ['sUserName'] ??
                                                            '',
                                                        style: AppStyles
                                                                .titleTextStyle(
                                                                    context)
                                                            .copyWith(
                                                          color: AppColors
                                                              .textWhiteColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              appSize(context) /
                                                                  80,
                                                        ),
                                                      ),
                                                      if (state.profileData[
                                                                  'data1'][0]
                                                              ['sUserCode'] !=
                                                          null)
                                                        Text(
                                                          state.profileData[
                                                                      'data1'][0]
                                                                  [
                                                                  'sUserCode'] ??
                                                              '',
                                                          style: AppStyles
                                                                  .titleTextStyle(
                                                                      context)
                                                              .copyWith(
                                                            color: AppColors
                                                                .textWhiteColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: appSize(
                                                                    context) /
                                                                80,
                                                          ),
                                                        ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide(
                                                  color: Colors.white
                                                      .withOpacity(0.3),
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Mobile No.:',
                                                    style: AppStyles
                                                            .titleTextStyle(
                                                                context)
                                                        .copyWith(
                                                      color: AppColors
                                                          .textWhiteColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          appSize(context) / 80,
                                                    ),
                                                  ),
                                                  Text(
                                                    state.profileData['data1']
                                                                [0]
                                                            ['sUserMobileNo'] ??
                                                        '',
                                                    style: AppStyles
                                                            .titleTextStyle(
                                                                context)
                                                        .copyWith(
                                                      color: AppColors
                                                          .textWhiteColor
                                                          .withOpacity(0.65),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          appSize(context) / 80,
                                                    ),
                                                  ),
                                                  if (state.profileData['data1']
                                                                  [0][
                                                              'sDriverLicense'] !=
                                                          null &&
                                                      state.profileData['data1']
                                                                  [0][
                                                              'sDriverLicense'] !=
                                                          "")
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                            height: 10),
                                                        Text(
                                                          'License No.:',
                                                          style: AppStyles
                                                                  .titleTextStyle(
                                                                      context)
                                                              .copyWith(
                                                            color: AppColors
                                                                .textWhiteColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: appSize(
                                                                    context) /
                                                                80,
                                                          ),
                                                        ),
                                                        Text(
                                                          state.profileData[
                                                                      'data1'][0]
                                                                  [
                                                                  'sDriverLicense'] ??
                                                              '',
                                                          style: AppStyles
                                                                  .titleTextStyle(
                                                                      context)
                                                              .copyWith(
                                                            color: AppColors
                                                                .textWhiteColor
                                                                .withOpacity(
                                                                    0.65),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: appSize(
                                                                    context) /
                                                                80,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  if (state.profileData['data1']
                                                                  [0][
                                                              'sDriverLicenseExpDate'] !=
                                                          null &&
                                                      state.profileData['data1']
                                                                  [0][
                                                              'sDriverLicenseExpDate'] !=
                                                          "")
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          'license Expiry On :', // Replace with actual user name
                                                          style: AppStyles
                                                                  .titleTextStyle(
                                                                      context)
                                                              .copyWith(
                                                            color: AppColors
                                                                .textWhiteColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: appSize(
                                                                    context) /
                                                                80,
                                                          ),
                                                        ),
                                                        Text(
                                                          state.profileData[
                                                                      'data1'][0]
                                                                  [
                                                                  'sDriverLicenseExpDate'] ??
                                                              '', // Replace with actual user name
                                                          style: AppStyles
                                                                  .titleTextStyle(
                                                                      context)
                                                              .copyWith(
                                                            color: AppColors
                                                                .textWhiteColor
                                                                .withOpacity(
                                                                    0.65),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: appSize(
                                                                    context) /
                                                                80,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          buildDrawerItem(
                              "Profile Details", AppIcons.kProfileIcons, () {
                            if (state is ProfileLoaded) {
                              Navigator.of(context)
                                  .push(goToRoute(ProfileDetailsScreen(
                                response: state.newProfileData,
                              )));
                            }
                          }, context),
                          const SizedBox(height: 15),
                          buildDrawerItem(
                              "Logout", "assets/images/new/Group 9720.png", () {
                            AppBottomSheet.show(
                              context: context,
                              child: AppBottomActionWidget(
                                onSuccess: () {
                                  Navigator.pop(context);
                                  AppStorage().clear();
                                  Navigator.of(context).pushReplacement(
                                      goToRoute(const LoginScreen()));
                                },
                                successLabel: "Logout",
                                message: "Are you sure you want to logout?",
                                isError: false,
                                isCancel: true,
                              ),
                              then: (v) {},
                            );
                          }, context),
                          const SizedBox(height: 15),
                          buildDrawerItem("Delete Account",
                              "assets/images/new/Group 9720.png", () {
                            AppBottomSheet.show(
                              context: context,
                              child: AppBottomActionWidget(
                                onSuccess: () {
                                  ProfileBloc().add(DeleteAccountEvent());
                                },
                                successLabel: "Delete",
                                message:
                                    "Are you sure you want to delete your account? This action cannot be undone.",
                                isError: false,
                                isCancel: true,
                              ),
                              then: (v) {},
                            );
                          }, context),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

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

  Widget shimmerLoadingWidget(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(80))),
      child: Container(
        padding: const EdgeInsets.only(top: 16, left: 0, right: 0),
        decoration: const BoxDecoration(
          color: AppColors.newLightBlue,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.white.withOpacity(0.3), // Top border color
                      width: 2.0, // Top border width
                    ),
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.3), // Top border color
                      width: 2.0, // Bottom border width
                    ),
                  ),
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spa,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Colors.white
                                  .withOpacity(0.3), // Top border color
                              width: 1.0, // Right border width
                            ),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            children: [
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
                              const SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Text(
                                      "loading...",
                                      style: AppStyles.titleTextStyle(context)
                                          .copyWith(
                                        color: AppColors.textWhiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: appSize(context) / 80,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.white
                                  .withOpacity(0.3), // Top border color
                              width: 1.0, // Right border width
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mobile No.:', // Replace with actual user name
                                style:
                                    AppStyles.titleTextStyle(context).copyWith(
                                  color: AppColors.textWhiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: appSize(context) / 80,
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Text(
                                  "loading...", // Replace with actual user name
                                  style: AppStyles.titleTextStyle(context)
                                      .copyWith(
                                    color: AppColors.textWhiteColor
                                        .withOpacity(0.65),
                                    fontWeight: FontWeight.bold,
                                    fontSize: appSize(context) / 80,
                                  ),
                                ),
                              ),
                              if (userType == '2')
                                const SizedBox(
                                  height: 10,
                                ),
                              if (userType == '2')
                                Text(
                                  'License No.:', // Replace with actual user name
                                  style: AppStyles.titleTextStyle(context)
                                      .copyWith(
                                    color: AppColors.textWhiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: appSize(context) / 80,
                                  ),
                                ),
                              if (userType == '2')
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Text(
                                    'loading...', // Replace with actual user name
                                    style: AppStyles.titleTextStyle(context)
                                        .copyWith(
                                      color: AppColors.textWhiteColor
                                          .withOpacity(0.65),
                                      fontWeight: FontWeight.bold,
                                      fontSize: appSize(context) / 80,
                                    ),
                                  ),
                                ),
                              if (userType == '2')
                                const SizedBox(
                                  height: 10,
                                ),
                              if (userType == '2')
                                Text(
                                  'license Expiry On :', // Replace with actual user name
                                  style: AppStyles.titleTextStyle(context)
                                      .copyWith(
                                    color: AppColors.textWhiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: appSize(context) / 80,
                                  ),
                                ),
                              if (userType == '2')
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Text(
                                    "loading...", // Replace with actual user name
                                    style: AppStyles.titleTextStyle(context)
                                        .copyWith(
                                      color: AppColors.textWhiteColor
                                          .withOpacity(0.65),
                                      fontWeight: FontWeight.bold,
                                      fontSize: appSize(context) / 80,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
