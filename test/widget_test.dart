// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:logistics_app/core/res/app_colors.dart';
// import 'package:logistics_app/core/res/app_functions.dart';
// import 'package:logistics_app/core/res/app_images.dart';
// import 'package:logistics_app/core/res/app_storage.dart';
// import 'package:logistics_app/core/res/app_styles.dart';
// import 'package:logistics_app/features/auth/presentation/ui/login_screen.dart';
//
// class AppDrawer extends StatelessWidget {
//   const AppDrawer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Drawer(
//         backgroundColor: AppColors.darkViolet,
//         shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: appSize(context) / 15,
//                   vertical: appSize(context) / 50),
//               child: Image.asset(AppImages.kImageAppRoundLogo),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
//               child: ListTile(
//                 title: Text("Logout",
//                     style: AppStyles.titleTextStyle(context)
//                         .copyWith(color: Colors.white)),
//                 contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(6)),
//                 onTap: () {
//                   AppStorage().clear();
//                   Navigator.of(context)
//                       .pushReplacement(goToRoute(const LoginScreen()));
//                 },
//                 tileColor: AppColors.lightViolet,
//                 trailing: const Icon(CupertinoIcons.power),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
