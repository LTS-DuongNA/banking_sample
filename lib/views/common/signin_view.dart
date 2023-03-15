import 'dart:async';
import 'package:bank_application/api/api_repository.dart';
import 'package:bank_application/utils/expansion_panel_fix.dart';
import 'package:bank_application/views/admin/scan_overview.dart';
import 'package:bank_application/views/admin/scan_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../consts/images/image_path.dart';
import '../../../viewmodels/home_viewmodel.dart';
import '../../consts/colors/colors.dart';
import '../../service/ocr_service.dart';
import '../../utils/alert.dart';
import '../../utils/exit_app_scope.dart';
import '../../utils/observable_serivce.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../admin/home_navigation.dart';
import '../user/home_user.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignInView();
  }
}

class _SignInView extends State<SignInView> {
  final ObservableService _observableService = ObservableService();
  final HomeViewModel _homeViewModel = HomeViewModel();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  double getSmallDiameter(BuildContext context) => MediaQuery.of(context).size.width * 2 / 3;
  double getBiglDiameter(BuildContext context) => MediaQuery.of(context).size.width * 7 / 8;

  @override
  void initState() {
    super.initState();

    //set orientation is landscape
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: Stack(
        children: <Widget>[
          Positioned(
            right: -getSmallDiameter(context) / 3,
            top: -getSmallDiameter(context) / 3,
            child: Container(
              width: getSmallDiameter(context),
              height: getSmallDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFFB226B2), Color(0xFFFF6DA7)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            left: -getBiglDiameter(context) / 4,
            top: -getBiglDiameter(context) / 4,
            child: Container(
              child: const Center(
                child: Text(
                  "Presales",
                  style: TextStyle(fontFamily: "Pacifico", fontSize: 40, color: Colors.white),
                ),
              ),
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFFB226B2), Color(0xFFFF4891)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            right: -getBiglDiameter(context) / 2,
            bottom: -getBiglDiameter(context) / 2,
            child: Container(
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFF3E9EE)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      //border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.fromLTRB(20, 300, 20, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 6,
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.email,
                              color: Color(0xFFFF4891),
                            ),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade100)),
                            labelText: "Email",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.vpn_key,
                              color: Color(0xFFFF4891),
                            ),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade100)),
                            labelText: "Password",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),
                      )
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                        child: const Text(
                          "FORGOT PASSWORD?",
                          style: TextStyle(color: Color(0xFFFF4891), fontSize: 11),
                        ))),
                Container(
                  margin: EdgeInsets.only(top: 52),
                  padding: EdgeInsets.only(left: 24, right: 24),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 40,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                            colors: [Color(0xFFB226B2), Color(0xFFFF4891)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        splashColor: Colors.amber,
                        onTap: () async {
                          try {
                            print("Logging in with ${emailController.text} - ${passwordController.text}");
                            UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );

                            if (userCredential.user != null) {
                              if (userCredential.user!.emailVerified) {
                                /// user
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                      builder: (_) {
                                        return HomeViewUser();
                                      },
                                      settings: RouteSettings(
                                        name: 'HomeNavigator',
                                      ),
                                    ))
                                    .then((value) => () {});
                              } else if (emailController.text == "admin@gmail.com") {
                                /// admin
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                      builder: (_) {
                                        return HomeNavigator();
                                      },
                                      settings: RouteSettings(
                                        name: 'HomeNavigator',
                                      ),
                                    ))
                                    .then((value) => () {});
                              } else {
                                print('Vui lòng kiểm tra email và xác nhận tài khoản trước khi đăng nhập.');
                                showDialog(
                                    context: context,
                                    builder: (context) => ErrorAlert.alert(
                                        context, "Vui lòng kiểm tra email và xác nhận tài khoản trước khi đăng nhập."));
                              }
                            } else {
                              print('Gặp lỗi trong quá trình đăng nhập, vui lòng thử lại sau.');
                              showDialog(
                                  context: context,
                                  builder: (context) => ErrorAlert.alert(
                                      context, "Gặp lỗi trong quá trình đăng nhập, vui lòng thử lại sau."));
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('Người dùng không tồn tại.');
                              showDialog(
                                  context: context,
                                  builder: (context) => ErrorAlert.alert(context, "Người dùng không tồn tại."));
                            } else if (e.code == 'wrong-password') {
                              print('Sai mật khẩu.');
                              showDialog(
                                  context: context, builder: (context) => ErrorAlert.alert(context, "Sai mật khẩu."));
                            } else {
                              print('Gặp lỗi trong quá trình đăng nhập, thử lại sau.');
                              showDialog(
                                  context: context,
                                  builder: (context) => ErrorAlert.alert(context, e.message.toString()));
                            }
                          } catch (e) {
                            print('Gặp lỗi trong quá trình đăng nhập, vui lòng thử lại sau.');
                            showDialog(context: context, builder: (context) => ErrorAlert.alert(context, e.toString()));
                            print(e);
                          }
                        },
                        child: const Center(
                          child: Text(
                            "SIGN IN",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      "DON'T HAVE AN ACCOUNT ? ",
                      style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      " SIGN UP",
                      style: TextStyle(fontSize: 11, color: Color(0xFFFF4891), fontWeight: FontWeight.w700),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
