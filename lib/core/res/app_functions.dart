import 'package:flutter/material.dart';

class AppFunctions {
  static unFocus(context) => FocusScope.of(context).requestFocus(FocusNode());

  static bool isNumeric(String value) {
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(value);
  }
}

double appSize(BuildContext context) {
  return MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
}

double appSizeUnit({required BuildContext context, required double unit}) {
  double baseUnit = 100;
  double s =
      MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
  double val = s / 100 * unit + baseUnit;
  return val;
}

Route<dynamic> goToRoute(screen) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      });
}
