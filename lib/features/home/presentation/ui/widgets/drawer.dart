import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_styles.dart';
import 'package:logistics_app/features/auth/presentation/ui/login_screen.dart';
import 'package:logistics_app/features/home/controller/main_controller.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/res/app_functions.dart';
import '../../../../../core/res/app_icons.dart';
import '../../../../../core/services/func_sertives.dart';
import '../../../../profile/presentation/bloc/profile_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = MainController();
    return Drawer(
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.newLightBlue,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(80),
                bottomLeft: Radius.circular(0),
              ),
            ),
            child: SafeArea(
              child: BlocProvider(
                create: (context) => ProfileBloc()..add(FetchProfileEvent()),
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return _userDetailsLoadingWidget(context);
                    } else {
                      if (state is ProfileLoaded) {
                        return _userDetailsWidget(context, state);
                      } else {
                        return Container();
                      }
                    }
                  },
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
                    buildDrawerItem("Profile", AppIcons.kProfileIcons, () {
                      mainController.index.value = 2;
                      // Add any navigation logic here if needed
                    }, context),
                    const SizedBox(height: 15),
                    buildDrawerItem("Salary", AppIcons.kIconWallet, () {
                      mainController.index.value = 2;
                      // Add any navigation logic here if needed
                    }, context),
                    const SizedBox(height: 15),
                    buildDrawerItem("Logout", AppIcons.kLogoutIcon, () {
                      // Logout logic
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    }, context),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _userDetailsLoadingWidget(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: "https://randomuser.me/api/portraits/men/32.jpg",
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300], // Shimmer color while loading
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 40,
                  backgroundImage: imageProvider,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Text(
              "Loading...",
              style: AppStyles.titleTextStyle(context).copyWith(
                color: AppColors.textWhiteColor,
                fontWeight: FontWeight.bold,
                fontSize: appSize(context) / 70,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          // if(profileController.isDriver.value)
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Text(
                          'Mobile No.: Loading...',
                          style: AppStyles.titleTextStyle(context).copyWith(
                            color: AppColors.textWhiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: appSize(context) / 80,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Text(
                          'License No.: Loading...', // Replace with actual user name
                          style: AppStyles.titleTextStyle(context).copyWith(
                            color: AppColors.textWhiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: appSize(context) / 80,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Text(
                          'license Expiry On : Loading...', // Replace with actual user name
                          style: AppStyles.titleTextStyle(context).copyWith(
                            color: AppColors.textWhiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: appSize(context) / 80,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _userDetailsWidget(BuildContext context, ProfileLoaded state) {
    return Center(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: "https://randomuser.me/api/portraits/men/32.jpg",
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300], // Shimmer color while loading
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 40,
                  backgroundImage: imageProvider,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            getValidatedString(state.profileData['data1'][0]['sUserName']),
            style: AppStyles.titleTextStyle(context).copyWith(
              color: AppColors.textWhiteColor,
              fontWeight: FontWeight.bold,
              fontSize: appSize(context) / 70,
            ),
          ),
          Text(
            getValidatedString(state.profileData['data1'][0]['sUserMobileNo']),
            style: AppStyles.titleTextStyle(context).copyWith(
              color: AppColors.textWhiteColor,
              fontWeight: FontWeight.bold,
              fontSize: appSize(context) / 70,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          if (state.profileData['data1'][0]['sDriverLicense'] != "")
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mobile No.: ${getValidatedString(state.profileData['data1'][0]['sUserMobileNo'])}', // Replace with actual user name
                          style: AppStyles.titleTextStyle(context).copyWith(
                            color: AppColors.textWhiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: appSize(context) / 80,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'License No.: ${getValidatedString(state.profileData['data1'][0]['sDriverLicense'])}', // Replace with actual user name
                          style: AppStyles.titleTextStyle(context).copyWith(
                            color: AppColors.textWhiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: appSize(context) / 80,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'license Expiry On : ${getValidatedString(state.profileData['data1'][0]['sDriverLicenseExpDate'])}', // Replace with actual user name
                          style: AppStyles.titleTextStyle(context).copyWith(
                            color: AppColors.textWhiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: appSize(context) / 80,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}

Widget buildDrawerItem(
    String itemName, String assetPath, VoidCallback onTap, context) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 25,
            padding: const EdgeInsets.only(left: 30),
            child: Image(
              image: AssetImage(
                assetPath,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              itemName,
              style: AppStyles.titleTextStyle(context).copyWith(
                color: AppColors.textBlackColor,
                fontSize: appSize(context) / 80,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
