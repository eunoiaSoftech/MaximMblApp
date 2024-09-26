import 'package:flutter/material.dart';
import '../../../../../core/res/app_colors.dart';
import '../../../../../core/res/app_styles.dart';
import '../../../data/models/trip_model.dart';
import 'custom_trip_button.dart';

class BuildMyTripCard extends StatelessWidget {
  final Trip trip;

  const BuildMyTripCard({required this.trip, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.fromCity,
                      textAlign: TextAlign.center,
                      style: AppStyles.titleTextStyle(context).copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      trip.fromState,
                      textAlign: TextAlign.center,
                      style: AppStyles.titleTextStyle(context).copyWith(
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const Expanded(
                    child: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      trip.toCity,
                      textAlign: TextAlign.center,
                      style: AppStyles.titleTextStyle(context).copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      trip.toState,
                      textAlign: TextAlign.center,
                      style: AppStyles.titleTextStyle(context).copyWith(
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/icons/parcel.png',
                  height: 18,
                ),
                const SizedBox(
                  width: 7,
                ),
                Text(
                  trip.cargo,
                  textAlign: TextAlign.center,
                  style: AppStyles.titleTextStyle(context).copyWith(
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const Spacer(),
                Image.asset(
                  'assets/icons/flat-bed-truck.png',
                  height: 22,
                ),
                const SizedBox(
                  width: 7,
                ),
                Text(
                  trip.vehicleType,
                  textAlign: TextAlign.center,
                  style: AppStyles.titleTextStyle(context).copyWith(
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const Spacer(),
                Image.asset(
                  'assets/icons/weight.png',
                  height: 18,
                ),
                const SizedBox(
                  width: 7,
                ),
                Text(
                  '${trip.weight} Tons',
                  textAlign: TextAlign.center,
                  style: AppStyles.titleTextStyle(context).copyWith(
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lr date : ${trip.lrDate}',
                  textAlign: TextAlign.center,
                  style: AppStyles.titleTextStyle(context).copyWith(
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                Text(
                  'Lr number : ${trip.lrNumber}',
                  textAlign: TextAlign.center,
                  style: AppStyles.titleTextStyle(context).copyWith(
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: CustomButton(
                    text: "LR DTL",
                    onPressed: () {},
                    borderRadius: 50,
                    borderColor: Colors.grey,
                    textColor: Colors.white,
                    backgroundColor: AppColors.newBlue,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomButton(
                    text: "Expenses",
                    onPressed: () {},
                    borderRadius: 50,
                    borderColor: Colors.transparent,
                    textColor: Colors.white,
                    backgroundColor: AppColors.green,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomButton(
                    text: "POD",
                    onPressed: () {},
                    borderRadius: 50,
                    borderColor: Colors.transparent,
                    textColor: Colors.white,
                    backgroundColor: AppColors.borderColor,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
