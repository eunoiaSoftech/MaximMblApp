import 'package:flutter/material.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/common_page_appbar.dart';

import '../widget/build_my_trip_card.dart';

class MyTripScreen extends StatefulWidget {
  const MyTripScreen({super.key});

  @override
  State<MyTripScreen> createState() => _MyTripScreenState();
}

class _MyTripScreenState extends State<MyTripScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonPageAppBar(
        title: "My Trips",
      ),
      body: _getBodyView(),
    );
  }

  Widget _getBodyView() {
    return SingleChildScrollView(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return const BuildMyTripCard();
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
      ),
    );
  }
}
