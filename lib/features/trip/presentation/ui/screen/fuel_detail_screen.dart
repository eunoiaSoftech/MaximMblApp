import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/common_page_appbar.dart';

import '../../../../../core/res/app_styles.dart';
import '../../../data/models/trip_model.dart';

class FuelDetailScreen extends StatefulWidget {
  FuelDetailScreen({super.key, required this.trip});
  final Trip trip;

  @override
  State<FuelDetailScreen> createState() => _FuelDetailScreenState();
}

class _FuelDetailScreenState extends State<FuelDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonPageAppBar(
        title: "Fuel Detail",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Card(
              color: Colors.white,
              elevation: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trip no : ${widget.trip.vehicleType}',
                          textAlign: TextAlign.center,
                          style: AppStyles.titleTextStyle(context).copyWith(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Driver name : ${widget.trip.vehicleType}',
                          textAlign: TextAlign.center,
                          style: AppStyles.titleTextStyle(context).copyWith(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Driver name : ${widget.trip.vehicleType}',
                          textAlign: TextAlign.center,
                          style: AppStyles.titleTextStyle(context).copyWith(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Card(
              color: Colors.white,
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.qrcode_viewfinder,
                      size: 300,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
