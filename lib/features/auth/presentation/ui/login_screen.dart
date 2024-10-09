import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_app/core/res/app_bottomsheet.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_icons.dart';
import 'package:logistics_app/core/res/app_images.dart';
import 'package:logistics_app/core/res/app_loader.dart';
import 'package:logistics_app/core/res/app_storage.dart';
import 'package:logistics_app/core/res/app_styles.dart';
import 'package:logistics_app/core/shared/data/user.dart';
import 'package:logistics_app/core/shared/widgets/app_button.dart';
import 'package:logistics_app/core/shared/widgets/app_bottom_action_widget.dart';
import 'package:logistics_app/core/shared/widgets/app_textfield.dart';
import 'package:logistics_app/features/auth/data/models/login_req_model.dart';
import 'package:logistics_app/features/auth/data/models/loginwith_otp_req.dart';
import 'package:logistics_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:logistics_app/features/auth/presentation/bloc/auth_events/login_events.dart';
import 'package:logistics_app/features/auth/presentation/bloc/auth_events/loginwith_otp_events.dart';
import 'package:logistics_app/features/auth/presentation/bloc/auth_states/auth.dart';
import 'package:logistics_app/features/auth/presentation/bloc/auth_states/login_states.dart';
import 'package:logistics_app/features/auth/presentation/bloc/auth_states/loginwith_otp_states.dart';
import 'package:logistics_app/features/branches_n_locations/presentation/ui/select_branch_screen.dart';
import 'package:logistics_app/features/home/presentation/ui/home_screen.dart';
import 'package:logistics_app/features/home/presentation/ui/main_screen.dart';
import 'package:pinput/pinput.dart';
import 'dart:math' as math;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameOrMobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  bool isValidated = false;
  bool isLoading = false;
  bool isLoginWithPassword = true;
  String? otp;
  User? userData;

  String? name;
  String? img;
  bool hidePassword = true;
  final users = [
    {
      "name": "Abhijeet Shankar Sonawane",
      "username": "jeet126",
      "password": "123456",
      "mobile": "8080227727",
      "photo":
          "https://static.vecteezy.com/system/resources/thumbnails/019/900/322/small/happy-young-cute-illustration-face-profile-png.png",
    },
    {
      "name": "Ajay Kumar",
      "username": "ajaykumar01",
      "password": "123456",
      "mobile": "9876543210",
      "photo":
          "https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA4L2pvYjEwMzQtZWxlbWVudC0wNi0zOTcucG5n.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.newLightBlueOne,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: appSize(context) / 3,
              left: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0)),
              ),
            ),
            Positioned(
              top: appSize(context) / 4,
              left: -appSize(context) / 40,
              child: Transform.rotate(
                angle: math.pi / 7,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(55)),
                ),
              ),
            ),
            Positioned(
              top: 2,
              left: -appSize(context) / 3.3,
              child: Transform.rotate(
                angle: math.pi / 7,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColors.newLightBlue.withOpacity(.5),
                      borderRadius: BorderRadius.circular(55)),
                ),
              ),
            ),
            Positioned(
              top: -appSize(context) / 10,
              left: appSize(context) / 6.3,
              child: Transform.rotate(
                angle: math.pi / 6.8,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColors.newLightBlue.withOpacity(.5),
                      borderRadius: BorderRadius.circular(55)),
                ),
              ),
            ),
            Positioned(
              top: -appSize(context) / 10,
              left: appSize(context) / 3.4,
              child: Transform.rotate(
                angle: math.pi / 6.8,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColors.newLightBlue,
                      borderRadius: BorderRadius.circular(55)),
                ),
              ),
            ),
            _content(),
          ],
        ),
      ),
    );
  }

  _content() => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            SizedBox(height: appSize(context) / 16),
            _imageStack(),
            const SizedBox(height: 8),
            _welcomeLine(),
            SizedBox(height: appSize(context) / 100),
            if (isLoginWithPassword) ...{
              _loginWithPasswordForm()
            } else ...{
              _pinField()
            }
            // _formForLogin()
            // _formForCheckMobile(),
          ],
        ),
      );

  Widget _loginWithPasswordForm() => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: appSize(context) / 15),
            Image.asset(AppIcons.kIconNewProfile, width: appSize(context) / 20),
            const SizedBox(height: 12),
            Text("Log In",
                style: AppStyles.titleTextStyle(context).copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: appSize(context) / 40)),
            const SizedBox(height: 22),
            AppTextField(
              prefix: Container(
                height: appSize(context) / 50,
                width: appSize(context) / 50,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppIcons.kIconMailBox))),
              ),
              controller: _usernameController,
              hintText: "Enter Username",
              height: appSize(context) / 27,
              // inputType: TextInputType.text,
              // readOnly: false,
              // onChanged: (v) {
              //   log(v);
              //   // log("on change >> ${AppFunctions.isNumeric(v)}");
              // },
            ),
            const SizedBox(height: 16),
            AppTextField(
                prefix: Container(
                  height: appSize(context) / 50,
                  width: appSize(context) / 50,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppIcons.kIconLock))),
                ),
                controller: _passwordController,
                obscureText: hidePassword,
                height: appSize(context) / 27,
                // controller: _passwordController,
                hintText: "Enter Password",
                suffix: IconButton(
                    icon: hidePassword
                        ? const Icon(CupertinoIcons.eye_slash,
                            color: Colors.black)
                        : const Icon(CupertinoIcons.eye, color: Colors.black),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    })),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login with ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.newLightBlueOne,
                      fontSize: appSize(context) / 90),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLoginWithPassword = false;
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 9),
                      decoration: BoxDecoration(
                          color: AppColors.newLightBlueOne,
                          borderRadius: BorderRadius.circular(44)),
                      child: Text(
                        "OTP",
                        style: AppStyles.titleTextStyle(context).copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      )),
                )
              ],
            ),
            const SizedBox(height: 22),
            BlocProvider(
              create: (context) => context.read<AuthBloc>(),
              child: _loginButton("Login", () async {
                if (_usernameController.text.isEmpty ||
                    _passwordController.text.isEmpty) {
                  AppBottomSheet.show(
                      context: context,
                      child: AppBottomActionWidget(
                          message: "Username and Password is required to Login",
                          isError: false,
                          isCancel: false),
                      then: (v) {});
                  return;
                }

                context.read<AuthBloc>().add(LoginEvent(LoginRequestModel(
                    username: _usernameController.text,
                    password: _passwordController.text,
                    email: "",
                    branchId: 0)));

                /// start loading ...
                AppBottomSheet.show(
                    context: context,
                    then: (v) {},
                    child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is LoginLoaded) {
                          AppStorage().saveUserId(
                              state.resp.data1?.first.iPKUSRID ?? 0);
                          AppStorage().saveBranchId(
                              state.resp.data1?.first.iBranchFlag ?? 0);
                          AppStorage().saveUserDetails(User(
                                  name: state.resp.data1?.first.name,
                                  branchId: state.resp.data1?.first.iBranchFlag,
                                  email: state.resp.data1?.first.sEmail,
                                  phone: state.resp.data1?.first.sPhone,
                                  userId: state.resp.data1?.first.iPKUSRID,
                                  userType: state.resp.data1?.first.iFkUserType)
                              .toJson());

                          int? branchId = state.resp.data1?[0].iBranchFlag;
                          int? userid = state.resp.data1?[0].iPKUSRID;
                          if (branchId != null && branchId == 0) {
                            Navigator.of(context).pushReplacement(
                                goToRoute(SelectBranchScreen(userId: userid)));
                            // .pushReplacement(goToRoute(const HomeScreen()));
                          } else {
                            Navigator.of(context).push(
                                goToRoute(SelectBranchScreen(userId: userid)));
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginError) {
                          return AppBottomActionWidget(
                              message: state.error,
                              isError: true,
                              isCancel: false);
                        }

                        return const AppLoader();
                      },
                    ));
              }, isLoading),
            ),
            const SizedBox(height: 6),
            const SizedBox(height: 22),
          ],
        ),
      );

  Widget _loginButton(text, onTap, isLoadingg) => AppButton(
      // height: appSize(context) / 22,
      onPressed: onTap,
      text: text,
      isLoading: isLoadingg);

  _formForLogin() => Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 22, right: 22, top: 33),
            padding: EdgeInsets.only(
                left: 22, right: 22, top: appSize(context) / 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: Column(
              children: [
                // Text("Welcome, ${name?.toUpperCase() ?? ""}",
                //     maxLines: 1,
                //     textAlign: TextAlign.center,
                //     style: AppStyles.titleTextStyle(context).copyWith(
                //         fontSize: appSize(context) / 80,
                //         fontWeight: FontWeight.w600,
                //         color: AppColors.textColor)),
                const SizedBox(height: 6),
                Text("Log in with",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: AppStyles.titleTextStyle(context).copyWith(
                        fontSize: appSize(context) / 85,
                        fontWeight: FontWeight.w500,
                        color: AppColors.borderColor)),
                const SizedBox(height: 6),
                // Center(child: _passwordField()),
                DefaultTabController(
                  initialIndex: 0,
                  length: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.lightViolet)),
                        child: TabBar(
                          dividerColor: Colors.transparent,
                          indicatorSize: TabBarIndicatorSize.tab,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 12),
                          indicatorPadding:
                              const EdgeInsets.symmetric(vertical: -10),
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            // border: Border.all(color: AppColors.darkViolet),
                            color: AppColors.lightViolet.withOpacity(.2),
                          ),
                          automaticIndicatorColorAdjustment: true,
                          tabs: <Widget>[
                            // _tab("Fingerprint"),
                            _tab("OTP"),
                            _tab("Password"),
                          ],
                        ),
                      ),
                      Container(
                        height: appSize(context) / 6,
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            // Center(child: _fingerprint()),
                            Center(child: _pinField()),
                            // Center(child: _passwordField()),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8)
                      // const Divider(color: AppColors.borderColor),
                    ],
                  ),
                ),

                ///
                // AppTextFieldWithTitle(
                //     controller: _passwordController,
                //     textFieldName: "",
                //     hint: "Enter Password",
                //     inputType: TextInputType.text,
                //     readOnly: false),
                // const SizedBox(height: 12),
                // _loginButton("Continue", () async {
                //   setState(() {
                //     isLoading = true;
                //   });
                //   await Future.delayed(const Duration(milliseconds: 3000));
                //   setState(() {
                //     isLoading = false;
                //   });
                //   await Future.delayed(const Duration(milliseconds: 1000));
                //   // var data = users.where((element) =>
                //   //     element["password"] == _passwordController.text);
                //   bool res = users
                //       .map((e) => e["password"] == _passwordController.text)
                //       .contains(true);
                //   if (res == true) {
                //     Navigator.of(context)
                //         .push(goToRoute(const SelectBranchScreen()));
                //   } else {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(content: Text("Incorrect Password!")));
                //   }
                // }, isLoading),
                // const SizedBox(height: 12),
                // const Text(
                //   "Forgot Password?",
                //   style: TextStyle(color: AppColors.darkViolet),
                // )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    shape: BoxShape.circle),
                child: CircleAvatar(
                  radius: appSize(context) / 35,
                  backgroundColor: Colors.white,
                  backgroundImage: img != null
                      ? Image.network(img ?? "").image
                      : Image.asset(AppImages.kImageProfile).image,
                ),
              ),
            ],
          )
        ],
      );

  _tab(text) => Text(text,
      style: TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.textColor,
          fontSize: appSize(context) / 90));

  _fingerprint() => AppButton(
      leadingWidget: Icon(Icons.fingerprint, size: appSize(context) / 30),
      onPressed: () {},
      text: "Login with Fingerprint",
      isLoading: false);

  _pinField() {
    final defaultPinTheme = PinTheme(
      width: appSize(context) / 22,
      height: appSize(context) / 22,
      textStyle: const TextStyle(
          fontSize: 20,
          color: AppColors.textColor,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(44),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.3),
              blurRadius: 2,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            )
          ]),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(44),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        otp == null
            ? Column(
                children: [
                  SizedBox(height: appSize(context) / 15),
                  Image.asset(AppIcons.kIconNewProfile,
                      width: appSize(context) / 20),
                  const SizedBox(height: 12),
                  Text("Log In",
                      style: AppStyles.titleTextStyle(context).copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: appSize(context) / 40)),
                  const SizedBox(height: 22),
                  _mobileField(),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login with ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.newLightBlueOne,
                            fontSize: appSize(context) / 90),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLoginWithPassword = true;
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 9),
                            decoration: BoxDecoration(
                                color: AppColors.newLightBlueOne,
                                borderRadius: BorderRadius.circular(44)),
                            child: Text(
                              "Password",
                              style: AppStyles.titleTextStyle(context).copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            )),
                      )
                    ],
                  ),
                  const SizedBox(height: 22),
                  BlocProvider(
                    create: (context) => context.read<AuthBloc>(),
                    child: AppButton(
                        onPressed: () {
                          if (_usernameOrMobileController.text.isEmpty) {
                            AppBottomSheet.show(
                                context: context,
                                child: AppBottomActionWidget(
                                    message:
                                        "Please enter your username or mobile to send OTP",
                                    isError: false,
                                    isCancel: false),
                                then: (v) {});
                            return;
                          }

                          bool isNumber = AppFunctions.isNumeric(
                              _usernameOrMobileController.text);
                          log("isNumber   :::  $isNumber");

                          context.read<AuthBloc>().add(LoginWithOTPEvent(
                              LoginWithOTPRequestModel(
                                  username: isNumber
                                      ? "NA"
                                      : _usernameOrMobileController.text,
                                  phone: isNumber
                                      ? _usernameOrMobileController.text
                                      : "NA")));

                          /// start loading ...
                          AppBottomSheet.show(
                              context: context,
                              then: (v) {},
                              child: BlocConsumer<AuthBloc, AuthState>(
                                listener: (context, state) {
                                  if (state is LoginWithOTPLoaded) {
                                    setState(() {
                                      userData = User(
                                          name: state.resp.data1?.first.name,
                                          branchId: state
                                              .resp.data1?.first.iBranchFlag,
                                          email: state.resp.data1?.first.sEmail,
                                          phone: state.resp.data1?.first.sPhone,
                                          userId:
                                              state.resp.data1?.first.iPKUSRID);
                                      otp = state.resp.data1?.first.otp;
                                    });
                                    Future.delayed(
                                        const Duration(milliseconds: 1000), () {
                                      Navigator.of(context).pop();
                                    });

                                    //
                                    // int? branchId =
                                    //     state.resp.data1?[0].iBranchFlag;
                                    // int? userid = state.resp.data1?[0].iPKUSRID;
                                    // if (branchId != null && branchId == 0) {
                                    //   Navigator.of(context).pushReplacement(
                                    //       goToRoute(const HomeScreen()));
                                    // } else {
                                    //   Navigator.of(context).push(goToRoute(
                                    //       SelectBranchScreen(userId: userid)));
                                    // }
                                  }
                                },
                                builder: (context, state) {
                                  if (state is LoginWithOTPError) {
                                    return AppBottomActionWidget(
                                        message: "Something went wrong",
                                        isError: true,
                                        isCancel: false);
                                  }

                                  return const AppLoader();
                                },
                              ));
                        },
                        text: "Send OTP"),
                  )
                ],
              )
            : Column(
                children: [
                  SizedBox(height: appSize(context) / 12),
                  Image.asset(AppIcons.kIconNewProfile,
                      width: appSize(context) / 20),
                  const SizedBox(height: 12),
                  Text("Log In",
                      style: AppStyles.titleTextStyle(context).copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: appSize(context) / 40)),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      const SizedBox(width: 22),
                      Text(
                        "Enter Your OTP $otp",
                        style: AppStyles.hintTextStyle(context).copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                            fontSize: appSize(context) / 95),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Pinput(
                    length: 5,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    validator: (s) {
                      return s == otp ? null : 'Pin is incorrect';
                    },
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (pin) async {
                      if (pin == otp) {
                        AppStorage().saveUserId(userData?.userId ?? 0);
                        AppStorage().saveBranchId(userData?.branchId ?? 0);
                        AppStorage().saveUserDetails(User(
                                name: userData?.name,
                                branchId: userData?.branchId,
                                email: userData?.email,
                                phone: userData?.phone,
                                userId: userData?.userId,
                                userType: userData?.userType)
                            .toJson());

                        Future.delayed(const Duration(milliseconds: 2000), () {
                          Navigator.of(context)
                              .pushReplacement(goToRoute(const MainScreen()));
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 6),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        otp = null;
                      });
                    },
                    child: Text("Change Username/ Mobile?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkViolet,
                            fontSize: appSize(context) / 90)),
                  ),
                ],
              ),
      ],
    );
  }

  Widget _mobileField() => AppTextField(
        keyboardType: TextInputType.number,
        prefix: Container(
          height: appSize(context) / 50,
          width: appSize(context) / 50,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(AppIcons.kIconCall))),
        ),
        controller: _usernameOrMobileController,
        hintText: "Enter Phone Number",
      );

  // _formForCheckMobile() => Container(
  //       margin: const EdgeInsets.symmetric(horizontal: 22),
  //       padding: EdgeInsets.symmetric(
  //           horizontal: 22, vertical: appSize(context) / 30),
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(12), color: Colors.white),
  //       child: Column(
  //         children: [
  //           AppTextFieldWithTitle(
  //             controller: _usernameController,
  //             textFieldName: "Username",
  //             hint: "Enter Username",
  //             inputType: TextInputType.text,
  //             readOnly: false,
  //             onChanged: (v) {
  //               log(v);
  //               log("on change >> ${AppFunctions.isNumeric(v)}");
  //             },
  //           ),
  //           const SizedBox(height: 12),
  //           AppTextFieldWithTitle(
  //               controller: _passwordController,
  //               textFieldName: "Password",
  //               hint: "Enter Password",
  //               inputType: TextInputType.text,
  //               readOnly: false),
  //           const SizedBox(height: 12),
  //           BlocProvider(
  //             create: (context) => context.read<AuthBloc>(),
  //             child: _loginButton("LOGIN", () async {
  //               if (FocusScope.of(context).hasFocus) {
  //                 AppFunctions.unFocus(context);
  //               }
  //
  //               if (_usernameController.text.isEmpty ||
  //                   _passwordController.text.isEmpty) {
  //                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //                     backgroundColor: Colors.black,
  //                     content: Row(
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: [
  //                         Icon(Icons.warning_rounded, color: Colors.amber),
  //                         SizedBox(width: 6),
  //                         Text(
  //                           "Username and Password is required to login",
  //                           style: TextStyle(color: Colors.white70),
  //                         ),
  //                       ],
  //                     )));
  //                 return;
  //               }
  //
  //               context.read<AuthBloc>().add(LoginEvent(LoginRequestModel(
  //                   username: _usernameController.text,
  //                   password: _passwordController.text,
  //                   email: "",
  //                   branchId: 0)));
  //
  //               // authBloc.postData(LoginRequestModel(
  //               //     username: _usernameController.text,
  //               //     password: _passwordController.text,
  //               //     email: "",
  //               //     branchId: 0));
  //
  //               AppBottomSheet.show(
  //                   context: context,
  //                   showDragHandle: false,
  //                   isDismissible: false,
  //                   then: (v) {},
  //                   child: BlocConsumer<AuthBloc, AuthState>(
  //                     listener: (context, state) {
  //                       if (state is LoginLoaded) {
  //                         AppStorage().saveUserId(
  //                             state.resp.data1?.first.iPKUSRID ?? 0);
  //                         AppStorage().saveBranchId(
  //                             state.resp.data1?.first.iBranchFlag ?? 0);
  //                         AppStorage().saveUserDetails(User(
  //                                 name: state.resp.data1?.first.name,
  //                                 branchId: state.resp.data1?.first.iBranchFlag,
  //                                 email: state.resp.data1?.first.sEmail,
  //                                 phone: state.resp.data1?.first.sPhone,
  //                                 userId: state.resp.data1?.first.iPKUSRID)
  //                             .toJson());
  //
  //                         int? branchId = state.resp.data1?[0].iBranchFlag;
  //                         int? userid = state.resp.data1?[0].iPKUSRID;
  //                         if (branchId != null && branchId == 0) {
  //                           Navigator.of(context)
  //                               .pushReplacement(goToRoute(const HomeScreen()));
  //                         } else {
  //                           Navigator.of(context).push(
  //                               goToRoute(SelectBranchScreen(userId: userid)));
  //                         }
  //                       }
  //                     },
  //                     builder: (context, state) {
  //                       if (state is LoginError) {
  //                         return AppBottomActionWidget(
  //                             message: state.error,
  //                             isError: true,
  //                             isCancel: false);
  //                       }
  //
  //                       return const AppLoader();
  //                     },
  //                   ));
  //
  //               // setState(() {
  //               //   isLoading = true;
  //               // });
  //               // await Future.delayed(const Duration(milliseconds: 3000));
  //               // setState(() {
  //               //   isLoading = false;
  //               // });
  //               // await Future.delayed(const Duration(milliseconds: 1000));
  //               //
  //               // var data = users.where((element) =>
  //               //     element["username"] == _mobileController.text ||
  //               //     element["mobile"] == _mobileController.text);
  //               // bool res = users
  //               //     .map((e) =>
  //               //         e["username"] == _mobileController.text ||
  //               //         e["mobile"] == _mobileController.text)
  //               //     .contains(true);
  //               // log("first >> $data");
  //               // log("data  >> ${data}");
  //               // if (res == true) {
  //               //   setState(() {
  //               //     isValidated = true;
  //               //     name = data.first["name"];
  //               //     img = data.first["photo"];
  //               //   });
  //               // } else {
  //               //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //               //       backgroundColor: Colors.black,
  //               //       content: Text(
  //               //         "You are not registered!",
  //               //         style: TextStyle(color: Colors.white70),
  //               //       )));
  //               // }
  //             }, isLoading),
  //           ),
  //           const SizedBox(height: 12),
  //           const Text(
  //             "Not Registered? Click here to Register",
  //             style: TextStyle(color: Colors.black),
  //           )
  //         ],
  //       ),
  //     );

  _imageStack() => Image.asset(AppIcons.kIconLogo, width: appSize(context) / 9);

  _welcomeLine() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Welcome to\nMaxim",
              textAlign: TextAlign.center,
              style: AppStyles.titleTextStyle(context).copyWith(
                fontWeight: FontWeight.w600,
                fontSize: appSize(context) / 44,
                height: 1.2,
                color: Colors.white,
              )),
          // Text(
          //   "Login to your account and continue",
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //       fontSize: appSize(context) / 72, color: Colors.white70),
          // ),
        ],
      );
}
