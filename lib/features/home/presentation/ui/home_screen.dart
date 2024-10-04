import 'package:flutter/material.dart';
import 'package:logistics_app/core/constants/globals.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_icons.dart';
import 'package:logistics_app/core/res/app_storage.dart';
import 'package:logistics_app/core/res/app_styles.dart';
import 'package:logistics_app/core/shared/data/user.dart';
import 'package:logistics_app/features/expense/presentation/ui/expense_booking_screen.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/drawer.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/home_screen_appbar.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/stats_widget.dart';
import 'package:logistics_app/features/legals/presentation/ui/legals_screen.dart';
import 'package:logistics_app/features/things_to_review/screen/things_to_review_screen.dart';
import 'package:logistics_app/features/trip/presentation/ui/screen/my_trip_screen.dart';

import '../../../../core/services/local_permission_services.dart';

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
        // backgroundColor: const Color(0xffE3F2FD),
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
                          if (PermissionService().hasPermission("My Trip"))
                            _tab("My Trip", AppIcons.kIconTruckTablet, () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyTripScreen()));
                            }),
                          if (PermissionService().hasPermission("Legal"))
                            _tab("Legal", AppIcons.kIconUpward, () {
                              Navigator.push(
                                  context, goToRoute(const LegalScreen()));
                            }),
                          if (PermissionService().hasPermission("Salary"))
                            _tab("Salary", AppIcons.kIconWallet, () {}),
                        ],
                      ),
                      Row(
                        children: [
                          if (PermissionService()
                              .hasPermission("Book Expenses"))
                            _tab("Book\nExpenses", AppIcons.kIconLabelLocation,
                                () {
                              Navigator.of(context).push(
                                  goToRoute(const ExpenseBookingScreen()));
                            }),
                          if (PermissionService()
                              .hasPermission("Things To Review"))
                            _tab("Things To \nReview", AppIcons.kIconNoIdeaTwo,
                                () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ThingsToReviewScreen()));
                            }),
                          if (PermissionService().hasPermission("SOS"))
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
            height: appSize(context) / 10.5,
            child: Card(
              elevation: 3,
              color: Colors.white,
              surfaceTintColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    const Spacer(),
                    Image.asset(icon, width: appSize(context) / 35),
                    const Spacer(),
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
