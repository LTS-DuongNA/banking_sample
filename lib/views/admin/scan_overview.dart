import 'dart:async';
import 'dart:io';
import 'package:bank_application/model/cmnd_data.dart';
import 'package:bank_application/views/admin/scan_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../consts/colors/colors.dart';
import '../../service/observable_serivce.dart';
import '../../utils/alert.dart';
import '../../viewmodels/home_viewmodel.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScanOverview extends StatefulWidget {
  const ScanOverview({super.key});

  @override
  State<ScanOverview> createState() => _FormWithImgState();
}

class _FormWithImgState extends State<ScanOverview> {
  ObservableService _observableService = ObservableService();

  final HomeViewModel _homeViewModel = HomeViewModel();
  final _formKey = GlobalKey<FormState>();
  TextEditingController textcontroller_email = TextEditingController();

  TextEditingController textcontroller_num = TextEditingController();
  TextEditingController textcontroller_name = TextEditingController();
  TextEditingController textcontroller_dob = TextEditingController();
  TextEditingController textcontroller_gender = TextEditingController();
  TextEditingController textcontroller_national = TextEditingController();
  TextEditingController textcontroller_home = TextEditingController();
  TextEditingController textcontroller_house = TextEditingController();
  final TextRecognizer textRecognizer = GoogleVision.instance.textRecognizer();

  StreamSubscription<bool>? apiResponseListener = null;

  @override
  void initState() {
    listenToAPIResponse();
    super.initState();
  }

  @override
  void dispose() {
    print("DISPONSE SCAN OVERVIEW");
    apiResponseListener?.cancel();
    super.dispose();
  }

  void listenToAPIResponse() {
    apiResponseListener ??= _observableService.reloadInfoStream.asBroadcastStream().listen((data) async {
      setState(() {});

      final GoogleVisionImage visionImage = GoogleVisionImage.fromFile(File(_homeViewModel.imgFront!.path));
      final VisionText visionText = await textRecognizer.processImage(visionImage);
      _homeViewModel.textsRecognizedFromIng = "";
      for (TextBlock block in visionText.blocks) {
        final String? text = block.text;
        _homeViewModel.textsRecognizedFromIng += "$text";
      }
      _homeViewModel.analyzeText();

      print("RELOADING OVERVIEW ${_homeViewModel.textsRecognizedFromIng}");
      setInfo();
      setState(() {});
    });
  }

  void setInfo() {
    if (_homeViewModel.cmnd_data != null && _homeViewModel.cmnd_data!.data != null) {
      if (_homeViewModel.cmnd_data!.data!.cmnd_num != null && _homeViewModel.cmnd_data!.data!.cmnd_num!.isNotEmpty) {
        textcontroller_num.text = _homeViewModel.cmnd_data!.data!.cmnd_num!;
      }
      if (_homeViewModel.cmnd_data!.data!.cmnd_name != null && _homeViewModel.cmnd_data!.data!.cmnd_name!.isNotEmpty) {
        textcontroller_name.text = _homeViewModel.cmnd_data!.data!.cmnd_name!;
      }
      if (_homeViewModel.cmnd_data!.data!.cmnd_dob != null && _homeViewModel.cmnd_data!.data!.cmnd_dob!.isNotEmpty) {
        textcontroller_dob.text = _homeViewModel.cmnd_data!.data!.cmnd_dob!;
      }
      if (_homeViewModel.cmnd_data!.data!.cmnd_gender != null &&
          _homeViewModel.cmnd_data!.data!.cmnd_gender!.isNotEmpty) {
        textcontroller_gender.text = _homeViewModel.cmnd_data!.data!.cmnd_gender!;
      }
      if (_homeViewModel.cmnd_data!.data!.cmnd_nation != null &&
          _homeViewModel.cmnd_data!.data!.cmnd_nation!.isNotEmpty) {
        textcontroller_national.text = _homeViewModel.cmnd_data!.data!.cmnd_nation!;
      }
      if (_homeViewModel.cmnd_data!.data!.cmnd_home != null && _homeViewModel.cmnd_data!.data!.cmnd_home!.isNotEmpty) {
        textcontroller_home.text = _homeViewModel.cmnd_data!.data!.cmnd_home!;
      }
      if (_homeViewModel.cmnd_data!.data!.cmnd_house != null &&
          _homeViewModel.cmnd_data!.data!.cmnd_house!.isNotEmpty) {
        textcontroller_house.text = _homeViewModel.cmnd_data!.data!.cmnd_house!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20,
                bottom: 10,
                left: 10,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Go Back',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
              color: Colors.white,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    try {
                                      WidgetsFlutterBinding.ensureInitialized();
                                      _homeViewModel.cameras = await availableCameras();
                                    } on CameraException catch (e) {
                                      print(e.code);
                                      print(e.description);
                                    }

                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                          builder: (_) {
                                            return CameraExampleHome(
                                              cameraKey: 'Front',
                                            );
                                          },
                                          settings: RouteSettings(
                                            name: 'CameraExampleHome',
                                          ),
                                        ))
                                        .then((value) => () {
                                              print("CameraExampleHome closed");
                                            });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1.0, color: Colors.black54),
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: (_homeViewModel.imgFront == null)
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                size: 60,
                                                Icons.linked_camera,
                                                color: Colors.blue,
                                              ),
                                              SizedBox(height: 16),
                                              Text("Chụp ảnh mặt trước")
                                            ],
                                          )
                                        : ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: Image.file(File(_homeViewModel.imgFront!.path)),
                                          ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                try {
                                  WidgetsFlutterBinding.ensureInitialized();
                                  _homeViewModel.cameras = await availableCameras();
                                } on CameraException catch (e) {
                                  print(e.code);
                                  print(e.description);
                                }

                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                      builder: (_) {
                                        return CameraExampleHome(
                                          cameraKey: 'Back',
                                        );
                                      },
                                      settings: RouteSettings(
                                        name: 'CameraExampleHome',
                                      ),
                                    ))
                                    .then((value) => () {
                                          print("CameraExampleHome closed");
                                        });
                              },
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1.0, color: Colors.black54),
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                ),
                                child: (_homeViewModel.imgBack == null)
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            size: 60,
                                            Icons.linked_camera,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(height: 16),
                                          Text("Chụp ảnh mặt sau")
                                        ],
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.file(File(_homeViewModel.imgBack!.path)),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                inputWihtTitle(
                                    "Email", "...", "Nhập email", textcontroller_email, TextInputType.emailAddress),
                                const SizedBox(height: 8),
                                inputWihtTitle(
                                    "Số CMND", "000...", "Nhập số CMND", textcontroller_num, TextInputType.number),
                                const SizedBox(height: 8),
                                inputWihtTitle(
                                    "Họ và tên", "...", "Nhập họ và tên", textcontroller_name, TextInputType.text),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: textcontroller_dob, //editing controller of this TextField
                                  decoration: InputDecoration(
                                    labelText: 'Ngày sinh',
                                    labelStyle: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 17,
                                    ),
                                    filled: true,
                                    fillColor: Colors.black.withOpacity(0.1),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
                                  ),
                                  readOnly: true, //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101));

                                    if (pickedDate != null) {
                                      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                                      setState(() {
                                        textcontroller_dob.text = formattedDate;
                                      });
                                    } else {
                                      print("Date is not selected ${textcontroller_dob.text}");
                                      setState(() {});
                                    }
                                  },
                                ),
                                const SizedBox(height: 8),
                                inputWihtTitle(
                                    "Giới tính", "...", "Nhập giới tính", textcontroller_gender, TextInputType.text),
                                const SizedBox(height: 8),
                                inputWihtTitle(
                                    "Quốc tịch", "...", "Nhập quốc tịch", textcontroller_national, TextInputType.text),
                                const SizedBox(height: 8),
                                inputWihtTitle(
                                    "Nguyên quán", "...", "Nhập nguyên quán", textcontroller_home, TextInputType.text),
                                const SizedBox(height: 8),
                                inputWihtTitle("Nơi ĐKHK thường trú", "...", "Nhập nơi ĐKHK thường trú",
                                    textcontroller_house, TextInputType.text),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 30),
                        child: Container(
                          width: 350,
                          height: 50,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: ColorStyle.pinkBg),
                          child: InkWell(
                            onTap: () async {
                              await addImageToFirebase();
                              await signUpForUser();
                              saveInfor();
                            },
                            child: const Center(
                                child: Text(
                              'Lưu',
                              style: TextStyle(fontSize: 18),
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addImageToFirebase() async {
    if (_homeViewModel.imgFront == null || _homeViewModel.imgBack == null) {
      return;
    }

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    Reference referenceImageToUploadFront = referenceDirImages.child("${uniqueFileName}_front");
    Reference referenceImageToUploadBack = referenceDirImages.child("${uniqueFileName}_back");

    try {
      await referenceImageToUploadFront.putFile(File(_homeViewModel.imgFront!.path));
      _homeViewModel.imgFrontUrl = await referenceImageToUploadFront.getDownloadURL();

      await referenceImageToUploadBack.putFile(File(_homeViewModel.imgBack!.path));
      _homeViewModel.imgBackUrl = await referenceImageToUploadBack.getDownloadURL();

      print("FRONT IMG URL ${_homeViewModel.imgFrontUrl}");
      print("BACK IMG URL ${_homeViewModel.imgBackUrl}");
    } catch (e) {
      showDialog(context: context, builder: (context) => ErrorAlert.alert(context, "FAIL ON UP LOAD IMG OR GET URL AFTER UPLOAD CAUSE OF: $e"));
      print("FAIL ON UP LOAD IMG OR GET URL AFTER UPLOAD CAUSE OF:");
      print(e);
    }
  }

  Future<void> signUpForUser() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: textcontroller_email.text,
        password: "12345678@",
      );
      FirebaseAuth.instance.currentUser!.sendEmailVerification();

      print("Email verification sent");
    } catch (e) {
      showDialog(context: context, builder: (context) => ErrorAlert.alert(context, "FAIL ON AUTHEN CAUSE OF: $e"));
      print("FAIL ON AUTHEN CAUSE OF:");
      print(e);
    }
  }

  void saveInfor() {
    Map<String, dynamic> data = {
      "cmnd_num": textcontroller_num.text,
      "cmnd_name": textcontroller_name.text,
      "cmnd_dob": textcontroller_dob.text,
      "cmnd_gender": textcontroller_gender.text,
      "cmnd_nation": textcontroller_national.text,
      "cmnd_house": textcontroller_house.text,
      "cmnd_home": textcontroller_home.text,
      "dkx_plates": _homeViewModel.cmnd_data?.data?.dkx_plates,
      "dkx_engine": _homeViewModel.cmnd_data?.data?.dkx_engine,
      "dkx_chassis": _homeViewModel.cmnd_data?.data?.dkx_chassis,
      "url_front": _homeViewModel.imgFrontUrl,
      "url_behind": _homeViewModel.imgBackUrl,
      "url_front_dkx": _homeViewModel.cmnd_data?.data?.url_front_dkx,
      "url_behind_dkx": _homeViewModel.cmnd_data?.data?.url_behind_dkx,
      "email": textcontroller_email.text
    };
    _homeViewModel.SaveInfor(data, context);
  }

  Widget inputWihtTitle(
      String? title, String? hintext, String? validateText, TextEditingController controller, TextInputType? type) {
    return Column(
      children: [
        // Align(alignment: Alignment.bottomLeft, child: Text(title ?? '')),
        // const SizedBox(
        //   height: 7,
        // ),
        TextFormField(
          keyboardType: type,
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validateText;
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: title ?? '',
            labelStyle: const TextStyle(
              color: Colors.black87,
              fontSize: 17,
            ),
            filled: true,
            fillColor: Colors.black.withOpacity(0.1),
            isDense: true,
            contentPadding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}
