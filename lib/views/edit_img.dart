import 'package:bank_application/views/scan_view.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../consts/colors/colors.dart';
import '../consts/images/image_path.dart';
import '../viewmodels/home_viewmodel.dart';
import 'form_img.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

class EditImgPick extends StatefulWidget {
  EditImgPick({
    Key? key,
  }) : super(key: key);

  @override
  State<EditImgPick> createState() => _EditImgPickState();
}

class _EditImgPickState extends State<EditImgPick> {
  final HomeViewModel _homeViewModel = HomeViewModel();

  Future<File?> _cropImage(XFile file) async {
    final File? croppedImage = await ImageCropper().cropImage(
      androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Edit',
          toolbarColor: ColorStyle.pinkBg,
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: ColorStyle.pinkBg,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: const IOSUiSettings(
        title: 'Edit',
      ),
      sourcePath: file.path,
      maxWidth: 1080,
      maxHeight: 1080,
      compressFormat: ImageCompressFormat.jpg,
    );

    if (croppedImage != null) {
      _homeViewModel.imageFile = XFile(croppedImage.path);
      setState(() {});
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

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
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.white)),
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: MediaQuery.of(context).size.height * 0.6,
                              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                              child: Image.file(
                                fit: BoxFit.cover,
                                File(_homeViewModel.imageFile!.path),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.8),
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
                          InkWell(
                            onTap: () {
                              _cropImage(_homeViewModel.imageFile!);
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: const Center(
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(color: Colors.green, fontSize: 17),
                                  )),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const FormWithImg()));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: const Center(
                                  child: Text(
                                "Choose",
                                style: TextStyle(color: Colors.amber, fontSize: 17),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
