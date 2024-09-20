import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_colors.dart';

class MenuBgWidget extends StatelessWidget {
  const MenuBgWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: child,
    );
  }
}
