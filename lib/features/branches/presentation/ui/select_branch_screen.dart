import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_app/core/res/app_bottomsheet.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_icons.dart';
import 'package:logistics_app/core/res/app_images.dart';
import 'package:logistics_app/core/res/app_styles.dart';
import 'package:logistics_app/core/shared/widgets/app_bottom_action_widget.dart';
import 'package:logistics_app/core/shared/widgets/app_button.dart';
import 'package:logistics_app/core/shared/widgets/app_next_button.dart';
import 'package:logistics_app/core/shared/widgets/app_textfield.dart';
import 'package:logistics_app/features/auth/presentation/ui/widgets/branchlist_bottomsheet_widget.dart';
import 'package:logistics_app/features/branches/presentation/bloc/branch_bloc.dart';
import 'package:logistics_app/features/branches/presentation/bloc/branch_events/branch_events.dart';
import 'package:logistics_app/features/branches/presentation/bloc/branch_states/branch.dart';
import 'package:logistics_app/features/branches/presentation/bloc/branch_states/branch_states.dart';
import 'package:logistics_app/features/home/presentation/ui/home_screen.dart';
import 'package:svg_flutter/svg.dart';
import 'dart:math' as math;

import '../../../home/presentation/ui/main_screen.dart';

class SelectBranchScreen extends StatefulWidget {
  const SelectBranchScreen({super.key, required this.userId});

  final int? userId;

  @override
  State<SelectBranchScreen> createState() => _SelectBranchScreenState();
}

class _SelectBranchScreenState extends State<SelectBranchScreen> {
  _callApi() {
    context.read<BranchBloc>().add(BranchListEvent(widget.userId ?? 0));
  }

  @override
  void initState() {
    super.initState();
    _callApi();
  }

  @override
  Widget build(BuildContext context) {
    double size = appSize(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.newLightBlueOne,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: appSize(context) / 3,
              left: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0)),
              ),
            ),
            Positioned(
              top: appSize(context) / 4,
              left: -appSize(context) / 40,
              child: Transform.rotate(
                angle: math.pi / 7,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(55)),
                ),
              ),
            ),
            Positioned(
              top: 2,
              left: -appSize(context) / 3.3,
              child: Transform.rotate(
                angle: math.pi / 7,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColors.newLightBlue.withOpacity(.5),
                      borderRadius: BorderRadius.circular(55)),
                ),
              ),
            ),
            Positioned(
              top: -appSize(context) / 10,
              left: appSize(context) / 6.3,
              child: Transform.rotate(
                angle: math.pi / 6.8,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColors.newLightBlue.withOpacity(.5),
                      borderRadius: BorderRadius.circular(55)),
                ),
              ),
            ),
            Positioned(
              top: -appSize(context) / 10,
              left: appSize(context) / 3.4,
              child: Transform.rotate(
                angle: math.pi / 6.8,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColors.newLightBlue,
                      borderRadius: BorderRadius.circular(55)),
                ),
              ),
            ),
            _content(),
          ],
        ),
      ),
    );
  }

  _content() => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            SizedBox(height: appSize(context) / 16),
            _imageStack(),
            const SizedBox(height: 8),
            _welcomeLine(),
            SizedBox(height: appSize(context) / 100),
            SizedBox(height: appSize(context) / 15),
            Image.asset(AppIcons.kIconNewProfile, width: appSize(context) / 20),
            const SizedBox(height: 12),
            Text("Log In",
                style: AppStyles.titleTextStyle(context).copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: appSize(context) / 40)),
            const SizedBox(height: 22),
            _textFields(),
            const SizedBox(height: 22),
            AppButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      goToRoute(const MainScreen()), (route) => false);
                },
                text: "Submit")
          ],
        ),
      );

  Widget _imageStack() =>
      SvgPicture.asset(AppIcons.kNewIconLogo, width: appSize(context) / 9);

  Widget _welcomeLine() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Welcome to\nMaxim",
              textAlign: TextAlign.center,
              style: AppStyles.titleTextStyle(context).copyWith(
                fontWeight: FontWeight.w600,
                fontSize: appSize(context) / 44,
                height: 1.2,
                color: Colors.white,
              )),
        ],
      );

  Widget _textFields() => Column(
        children: [
          GestureDetector(
            onTap: () {
              AppBottomSheet.show(
                  context: context,
                  child:
                      BranchListBottomSheetWidget(userId: widget.userId ?? 0),
                  then: (v) {});
            },
            child: AppTextField(
              hintText: "Select Your Branch",
              prefix: _iconContainer(AppIcons.kIconSociety),
              enabled: false,
              suffix: _iconContainer(AppIcons.kIconArrowDown),
            ),
          ),
          const SizedBox(height: 22),
          GestureDetector(
            onTap: () {},
            child: AppTextField(
              hintText: "Select Your Location",
              prefix: _iconContainer(AppIcons.kIconLocation),
              enabled: false,
              suffix: _iconContainer(AppIcons.kIconArrowDown),
            ),
          ),
        ],
      );

  _iconContainer(iconUrl) => Image.asset(iconUrl, width: appSize(context) / 80);

  // _content(context, size) => SingleChildScrollView(
  //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           SizedBox(height: size / 16),
  //           Text("Select Branch",
  //               style: TextStyle(
  //                   fontSize: size / 50, fontWeight: FontWeight.bold)),
  //           _grid(size),
  //         ],
  //       ),
  //     );

  // _grid(size) => BlocBuilder<BranchBloc, BranchState>(
  //       builder: (context, state) {
  //         if (state is BranchListLoaded) {
  //           return Column(
  //             children: [
  //               Container(
  //                 child: GridView.count(
  //                   shrinkWrap: true,
  //                   primary: false,
  //                   crossAxisSpacing: 22,
  //                   mainAxisSpacing: 22,
  //                   crossAxisCount: 2,
  //                   childAspectRatio: 1.2,
  //                   children: [
  //                     ...?state.resp.data1?.map((e) => _branchCard(
  //                             size,
  //                             AppIcons.kIconBranchJaipur,
  //                             e.branchName?.split("-").last, [
  //                           AppColors.skyBlueLight,
  //                           AppColors.skyBlue,
  //                         ])),
  //                   ],
  //                 ),
  //               ),
  //               // _btn(context, size)
  //             ],
  //           );
  //         }
  //         if (state is BranchListError) {
  //           return Container(
  //               child: AppBottomActionWidget(
  //                   message: state.error,
  //                   isError: true,
  //                   isCancel: false,
  //                   isOkayButton: false));
  //         }
  //         return const Center(
  //             child:
  //                 CupertinoActivityIndicator(radius: 20, color: Colors.white));
  //       },
  //     );
  //
  // _btn(context, size) => Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         SizedBox(height: appSize(context) / 30),
  //         AppNextButton(onTap: () {
  //           Navigator.of(context).push(goToRoute(const HomeScreen()));
  //         }),
  //       ],
  //     );

  _branchCard(size, imageUrl, title, List<Color> colors) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(goToRoute(const MainScreen()));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: RadialGradient(colors: colors)),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(imageUrl, height: size / 24),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: size / 70, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      );

  _bg() => Stack(
        children: [
          Row(
            children: [
              Expanded(
                  child:
                      Image.asset(AppImages.kImageTruckBg, fit: BoxFit.cover))
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.lightViolet.withOpacity(.6)),
                ),
              )
            ],
          )
        ],
      );
}
