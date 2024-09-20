import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/res/app_bottomsheet.dart';
import '../../core/res/app_colors.dart';
import '../../core/res/app_functions.dart';
import '../../core/res/app_storage.dart';
import '../../core/res/app_styles.dart';
import '../../core/shared/widgets/app_bottom_action_widget.dart';
import '../auth/presentation/ui/login_screen.dart';
import '../home/controller/main_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  MainController mainController = MainController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Container with top-left and bottom-right rounded corners
          Container(
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
                    // Back button
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            mainController.index(0);
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_back,
                                color: AppColors.iconWhiteColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // User avatar and name
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.white
                                .withOpacity(0.3), // Top border color
                            width: 2.0, // Top border width
                          ),
                          bottom: BorderSide(
                            color: Colors.white
                                .withOpacity(0.3), // Top border color
                            width: 2.0, // Bottom border width
                          ),
                        ),
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spa,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
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
                                    Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://randomuser.me/api/portraits/men/32.jpg",
                                          placeholder: (context, url) =>
                                              Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              width: 70,
                                              height: 70,
                                              color: Colors.grey[
                                                  300], // Shimmer color while loading
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  CircleAvatar(
                                            radius: 40,
                                            backgroundImage: imageProvider,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Mr. Leonardo', // Replace with actual user name
                                          style:
                                              AppStyles.titleTextStyle(context)
                                                  .copyWith(
                                            color: AppColors.textWhiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: appSize(context) / 80,
                                          ),
                                        ),
                                        Text(
                                          '+91 6351294099', // Replace with actual user name
                                          style:
                                              AppStyles.titleTextStyle(context)
                                                  .copyWith(
                                            color: AppColors.textWhiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: appSize(context) / 80,
                                          ),
                                        ),
                                        Text(
                                          '32 Years', // Replace with actual user name
                                          style:
                                              AppStyles.titleTextStyle(context)
                                                  .copyWith(
                                            color: AppColors.textWhiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: appSize(context) / 80,
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
                              padding: EdgeInsets.symmetric(vertical: 20),
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
                                      style: AppStyles.titleTextStyle(context)
                                          .copyWith(
                                        color: AppColors.textWhiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: appSize(context) / 80,
                                      ),
                                    ),
                                    Text(
                                      '43523412', // Replace with actual user name
                                      style: AppStyles.titleTextStyle(context)
                                          .copyWith(
                                        color: AppColors.textWhiteColor
                                            .withOpacity(0.65),
                                        fontWeight: FontWeight.bold,
                                        fontSize: appSize(context) / 80,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'License No.:', // Replace with actual user name
                                      style: AppStyles.titleTextStyle(context)
                                          .copyWith(
                                        color: AppColors.textWhiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: appSize(context) / 80,
                                      ),
                                    ),
                                    Text(
                                      '43523412', // Replace with actual user name
                                      style: AppStyles.titleTextStyle(context)
                                          .copyWith(
                                        color: AppColors.textWhiteColor
                                            .withOpacity(0.65),
                                        fontWeight: FontWeight.bold,
                                        fontSize: appSize(context) / 80,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'license Expiry On :', // Replace with actual user name
                                      style: AppStyles.titleTextStyle(context)
                                          .copyWith(
                                        color: AppColors.textWhiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: appSize(context) / 80,
                                      ),
                                    ),
                                    Text(
                                      '09/08/2027', // Replace with actual user name
                                      style: AppStyles.titleTextStyle(context)
                                          .copyWith(
                                        color: AppColors.textWhiteColor
                                            .withOpacity(0.65),
                                        fontWeight: FontWeight.bold,
                                        fontSize: appSize(context) / 80,
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
                    const SizedBox(height: 50),
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
                  const SizedBox(
                    height: 30,
                  ),
                  _buildDrawerItem("Logout", "assets/images/new/Group 9720.png",
                      () {
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
                            isCancel: true),
                        then: (v) {});
                  }, context),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      String itemName, String assetPath, VoidCallback onTap, context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 10),
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
}
