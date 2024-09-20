import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_images.dart';
import 'package:logistics_app/core/res/app_storage.dart';
import 'package:logistics_app/core/res/app_styles.dart';
import 'package:logistics_app/features/auth/presentation/ui/login_screen.dart';
import 'package:logistics_app/features/home/controller/main_controller.dart';
import 'package:logistics_app/features/profile/profile_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/res/app_bottomsheet.dart';
import '../../../../../core/shared/widgets/app_bottom_action_widget.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  MainController mainController = MainController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          // Container with top-left and bottom-right rounded corners
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(80))),
            child: Container(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              decoration: const BoxDecoration(
                color: AppColors.newLightBlue,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(80),
                  bottomLeft: Radius.circular(80),
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
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
                    const SizedBox(height: 0),

                    // User avatar and name
                    Center(
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
                                    width: 80,
                                    height: 80,
                                    color: Colors.grey[
                                        300], // Shimmer color while loading
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  radius: 40,
                                  backgroundImage: imageProvider,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'User Name', // Replace with actual user name
                            style: AppStyles.titleTextStyle(context).copyWith(
                              color: AppColors.textWhiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: appSize(context) / 70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
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
                  Obx(
                    () {
                      return mainController.index.value == 10 ? Container(): _buildDrawerItem(
                          "Profile", "assets/images/new/Group 9706.png", () {
                        mainController.index.value = 2;
                        print('check mainController.index.value ${mainController.index.value}');
                        // Get.back();
                      }, context);
                    }
                  ),
                  const SizedBox(
                    height: 15,
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
