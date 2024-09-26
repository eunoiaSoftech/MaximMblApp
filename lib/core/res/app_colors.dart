import 'package:flutter/material.dart';

class AppColors {
  // new ........
  static const Color newBlue = Color(0xff0F91DC);
  static const Color newLightBlue = Color(0xff43BEE7);
  static const Color newLightBlueOne = Color(0xff16AEE0);
  static const Color newOrange = Color(0xff494545);
  static const Color newGolden = Color(0xffFFAB3C);

  /// old....
  static const Color darkViolet = Color(0xff513BAA);
  static const Color lightViolet = Color(0xff6B56CD);
  static const Color lightPink = Color(0xffEB80C2);
  static const Color darkPink = Color(0xffDB63D3);
  static const Color skyBlue = Color(0xff72B5F5);
  static const Color skyBlueLight = Color(0xff72B5F5);

  static const Color vibrantPink = Color(0xffEF739F);
  static const Color vibrantPinkLight = Color(0xffFA78A6);

  static const Color goldenOrange = Color(0xffE2A347);
  static const Color goldenOrangeLight = Color(0xffFAAF44);

  static const Color green = Color(0xff56C887);
  static const Color greenLight = Color(0xff72E5A4);

  static const Color brownishPink = Color(0xffE5987E);
  static const Color brownishPinkLight = Color(0xffF6B19A);

  static const Color iconWhiteColor = Colors.white;
  static const Color textWhiteColor = Colors.white;
  static const Color textBlackColor = Colors.black;

  static const Color buttonColor = Color(0xff9078FE);

  static const Color borderColor = Color.fromRGBO(168, 178, 188, 0.84);
  static const Color textColor = Color.fromRGBO(30, 60, 87, 1);

  static getFloatingRoundButtonColor() =>
      const LinearGradient(colors: [darkPink, lightPink]);
}