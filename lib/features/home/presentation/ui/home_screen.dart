import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistics_app/core/constants/globals.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_icons.dart';
import 'package:logistics_app/core/res/app_storage.dart';
import 'package:logistics_app/core/res/app_styles.dart';
import 'package:logistics_app/core/shared/data/user.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/drawer.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/home_screen_appbar.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/stats_widget.dart';
import 'package:logistics_app/features/things_to_review/screen/things_to_review_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;

  getUserDetails() async {
    user = User.fromJson(AppStorage().getUserDetails);
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xffE3F2FD),
        key: Globals.homeScreenScaffoldKey,
        drawer: const AppDrawer(),
        resizeToAvoidBottomInset: true,
        appBar: const HomeScreenAppbar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: appSize(context) / 100),
              const StatsWidget(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _tab("My Trip", AppIcons.kIconTruckTablet, () {}),
                          _tab("Legal", AppIcons.kIconUpward, () {}),
                          _tab("Salary", AppIcons.kIconWallet, () {}),
                        ],
                      ),
                      Row(
                        children: [
                          _tab("Book\nExpenses", AppIcons.kIconLabelLocation,
                              () {}),
                          _tab("Things To \nReview", AppIcons.kIconNoIdeaTwo,
                              () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ThingsToReviewScreen()));
                          }),
                          _tab("SOS", AppIcons.kIconNoIdeaOne, () {}),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Expanded(child: _categories(context))
            ],
          ),
        ),
      ),
    );
  }

  _tab(title, icon, VoidCallback ontap) => Expanded(
        child: GestureDetector(
          onTap: () {
            ontap();
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 6, left: 3, right: 3),
            height: appSize(context) / 11,
            child: Card(
              elevation: 3,
              color: Colors.white,
              surfaceTintColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    Image.asset(icon, width: appSize(context) / 32),
                    Spacer(),
                    Text(title,
                        textAlign: TextAlign.center,
                        style: AppStyles.titleTextStyle(context)
                            .copyWith(fontSize: appSize(context) / 110))
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
