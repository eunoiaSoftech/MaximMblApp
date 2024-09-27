import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_icons.dart';
import 'package:logistics_app/core/res/app_styles.dart';
import 'package:logistics_app/core/shared/widgets/app_button.dart';
import 'package:logistics_app/core/shared/widgets/app_next_button.dart';
import 'package:logistics_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:logistics_app/features/auth/presentation/ui/login_screen.dart';
import 'package:logistics_app/features/onboarding/presentation/ui/image_stack_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController controller = PageController();
  final List<Widget> _list = <Widget>[
    const ImageStackWidget(image: AppIcons.kIconTruckGlow),
    const ImageStackWidget(image: AppIcons.kIconTruckScan),
    const ImageStackWidget(image: AppIcons.kIconTruckNav),
    // Image.asset(AppImages.kImageTruck),
    // Stack(
    //   alignment: Alignment.bottomCenter,
    //   children: [
    //     Image.asset(AppImages.kImageDeliveryMan),
    //     Container(
    //         height: 137,
    //         // width: 400,
    //         decoration: const BoxDecoration(
    //             // color: Colors.green,
    //             gradient: LinearGradient(
    //                 begin: Alignment.topCenter,
    //                 end: Alignment.bottomCenter,
    //                 colors: [
    //               Color.fromRGBO(94, 73, 188, 0),
    //               Color.fromRGBO(94, 73, 188, 1)
    //             ]))),
    //   ],
    // ),
  ];
  int _curr = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     colors: [
            //   AppColors.lightViolet,
            //   AppColors.darkViolet,
            // ]),
            ),
        child: Column(
          children: [
            _imageStack(),
            const SizedBox(height: 33),
            _contentStack(),
            // const Spacer(),
            // _btnStack(),
            // _skipBtn(),
          ],
        ),
      ),
    );
  }

  _imageStack() => Stack(
        children: [
          SizedBox(
            // color: Colors.white12,
            height: appSize(context) / 2.7,
            child: PageView(
              allowImplicitScrolling: true,
              scrollDirection: Axis.horizontal,
              // reverse: true,
              // physics: BouncingScrollPhysics(),
              controller: controller,
              onPageChanged: (n) {
                setState(() {
                  _curr = n;
                });
              },
              children: _list,
            ),
          ),
          _skipBtn()
          // _indicator(),
        ],
      );

  _indicator() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 6,
            width: _curr == 0 ? 20 : 6,
            decoration: BoxDecoration(
                color: _curr == 0
                    ? AppColors.newBlue
                    : AppColors.newLightBlue.withOpacity(.6),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white70)),
          ),
          const SizedBox(width: 2),
          Container(
            height: 6,
            width: _curr == 1 ? 20 : 6,
            decoration: BoxDecoration(
                color: _curr == 1
                    ? AppColors.newBlue
                    : AppColors.newLightBlue.withOpacity(.6),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white70)),
          ),
          const SizedBox(width: 2),
          Container(
            height: 6,
            width: _curr == 2 ? 20 : 6,
            decoration: BoxDecoration(
                color: _curr == 2
                    ? AppColors.newBlue
                    : AppColors.newLightBlue.withOpacity(.6),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white70)),
          ),
        ],
      );

  _contentStack() => Container(
        // color: Colors.green,
        width: appSize(context) / 4,
        child: Column(
          children: [
            Text(
                _curr == 0
                    ? "Maxim fleet management"
                    : _curr == 1
                        ? "Driver management system"
                        : "Fleet management GPS",
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.2,
                    color: Colors.black,
                    fontSize: appSize(context) / 45,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 22),
            Text(
                _curr == 0
                    ? "Helps you track your deliveries by giving on time updates"
                    : _curr == 1
                        ? "Helps drivers to book there Expense and track their performance"
                        : "Helps you to get live updates of your fleet",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black38, fontSize: appSize(context) / 80)),
            const SizedBox(height: 22),
            _indicator(),
            const SizedBox(height: 33),
            AppButton(
                onPressed: () {
                  if (_curr < 2) {
                    setState(() {
                      controller.jumpToPage(_curr + 1);
                    });
                  } else {
                    Navigator.of(context).push(goToRoute(BlocProvider(
                        create: (context) => context.read<AuthBloc>(),
                        child: const LoginScreen())));
                    // setState(() {
                    //   controller.jumpToPage(0);
                    // });
                  }
                },
                text: _curr == 0 ? "Get Started" : "Next",
                circular: 44)
          ],
        ),
      );

  _btnStack() => Column(
        children: [
          AppNextButton(onTap: () {}),
          const SizedBox(height: 20),
          // _skipBtn()
        ],
      );

  _skipBtn() => Positioned(
        right: 22,
        top: 20,
        child: SafeArea(
          child: InkWell(
              onTap: () {
                /// navigate to branch selection
                Navigator.of(context).pushAndRemoveUntil(
                    goToRoute(BlocProvider(
                        create: (context) => context.read<AuthBloc>(),
                        child: const LoginScreen())),
                    (route) => true);
              },
              child: Text(
                "Skip",
                style: AppStyles.titleTextStyle(context)
                    .copyWith(color: Colors.white),
              )),
        ),
      );
}
