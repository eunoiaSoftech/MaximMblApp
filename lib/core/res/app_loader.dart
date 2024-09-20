import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_styles.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 33),
      child: Row(
        children: [
          const CupertinoActivityIndicator(color: Colors.black, radius: 20),
          const SizedBox(width: 12),
          Text("Processing your request",
              style: AppStyles.bottomSheetSUBTitleTextStyle(context))
        ],
      ),
    );
  }
}
