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
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.file(File(_homeViewModel.imageFile!.path)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              _homeViewModel.imageFile = null;
                              setState(() {});
                            },
                            child: Container(
                              height: 20,
                              width: 100,
                              decoration: BoxDecoration(
                                color: ColorStyle.norange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text("Chụp lại")),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 20,
                            width: 100,
                            decoration: BoxDecoration(
                              color: ColorStyle.pinkBg,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text("Dùng ảnh này")),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
