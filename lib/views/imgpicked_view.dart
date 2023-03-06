import 'package:bank_application/views/scan_view.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../consts/colors/colors.dart';
import '../consts/images/image_path.dart';
import '../viewmodels/home_viewmodel.dart';

class ImgPick extends StatefulWidget {
  const ImgPick({Key? key}) : super(key: key);

  @override
  State<ImgPick> createState() => _ImgPickState();
}

class _ImgPickState extends State<ImgPick> {
  final HomeViewModel _homeViewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          (_homeViewModel.imageFile == null)
              ? Center(
                  child: Image.asset(
                    ImagePath.iconBgCMND,
                    width: MediaQuery.of(context).size.width,
                  ),
                )
              : Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Image.file(
                        fit: BoxFit.cover,
                        File(_homeViewModel.imageFile!.path),
                      ),
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.7),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.065,
                      left: MediaQuery.of(context).size.width * 0.05,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.white, width: 4),
                            left: BorderSide(color: Colors.white, width: 4),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.125,
                      right: MediaQuery.of(context).size.width * 0.05,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.white, width: 4),
                            right: BorderSide(color: Colors.white, width: 4),
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.white)),
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: MediaQuery.of(context).size.height * 0.78,
                            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                            child: Image.file(
                              fit: BoxFit.cover,
                              File(_homeViewModel.imageFile!.path),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CameraApp()));
                              _homeViewModel.imageFile = null;
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: const Center(
                                  child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.blue, fontSize: 17),
                              )),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: const Center(
                                child: Text(
                              "Choose",
                              style: TextStyle(color: Colors.amber, fontSize: 17),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

          // Center(
          // Center(
          //         child: Column(
          //           mainAxisSize: MainAxisSize.max,
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: [
          //             Image.file(File(_homeViewModel.imageFile!.path)),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 InkWell(
          //                   onTap: () {
          //                     _homeViewModel.imageFile = null;
          //                     setState(() {});
          //                   },
          //                   child: Container(
          //                     height: 20,
          //                     width: 100,
          //                     decoration: BoxDecoration(
          //                       color: ColorStyle.norange,
          //                       borderRadius: BorderRadius.circular(10),
          //                     ),
          //                     child: Center(child: Text("Chụp lại")),
          //                   ),
          //                 ),
          //                 const Spacer(),
          //                 Container(
          //                   height: 20,
          //                   width: 100,
          //                   decoration: BoxDecoration(
          //                     color: ColorStyle.pinkBg,
          //                     borderRadius: BorderRadius.circular(10),
          //                   ),
          //                   child: Center(child: Text("Dùng ảnh này")),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
        ],
      ),
    );
  }
}
