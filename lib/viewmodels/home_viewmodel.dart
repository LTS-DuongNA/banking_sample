import 'dart:async';
import 'package:bank_application/model/cmnd_data.dart';
import 'package:flutter/cupertino.dart';
import '../model/listdata_model.dart';
import '../repository/home_repo.dart';
import '../utils/observable_serivce.dart';
import 'base_viewmodel.dart';
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:string_similarity/string_similarity.dart';

class HomeViewModel extends BaseViewModel {
  static final HomeViewModel _instance = HomeViewModel._internal();

  factory HomeViewModel() {
    return _instance;
  }

  HomeViewModel._internal();

  final ObservableService _observableService = ObservableService();

  List<CameraDescription> cameras = <CameraDescription>[];

  XFile? imgFront;
  String imgFrontUrl = "";
  XFile? imgBack;
  String imgBackUrl = "";

  final _myRepo = HomeRepository();
  String textsRecognizedFromIng = "";
  List<ListSaveModel?> listData = [];

  void getListData(List<ListSaveModel> input) {
    listData = input;
    notifyListeners();
  }

  Future<void> SaveInfor(Map<String, dynamic> data, BuildContext context) async {
    _myRepo.SaveInfor(data).then((value) {
      if (value != null) {
        _observableService.showSaveAlertController.sink.add('Save Success !');
      } else {
        _observableService.showSaveAlertController.sink.add('Save Fail !');
      }
    }).onError((error, stackTrace) {
      print('save infor erorr:${error}');
    });
  }

  List<ListSaveModel>? saveList;

  getListSave() {
    dynamic data = "dev.duong.nguyenanh@gmail.com";
    Map<String, dynamic> params = {
      'email': data,
    };
    _myRepo.getListSaveData(params).then((value) {
      _observableService.listSaveController.sink.add(value);
    }).onError((error, stackTrace) {
      print('get save list erorr:$error');
    });
  }

  CMND_Data? cmnd_data = null;

  CMND_Data? analyzeText() {
    double cccdTitleSimilar = 0.0;
    int cccdTitleStartIndex = 0;
    int cccdTitleStopIndex = 0;

    double cccdHoTenSimilar = 0.0;
    int cccdHoTenStartIndex = 0;
    int cccdHoTenStopIndex = 0;

    double cccdDOBSimilar = 0.0;
    int cccdDOBStartIndex = 0;
    int cccdDOBStopIndex = 0;

    double cccdGenderSimilar = 0.0;
    int cccdGenderStartIndex = 0;
    int cccdGenderStopIndex = 0;

    double cccdNationalSimilar = 0.0;
    int cccdNationalStartIndex = 0;
    int cccdNationalStopIndex = 0;

    double cccdHomeSimilar = 0.0;
    int cccdHomeStartIndex = 0;
    int cccdHomeStopIndex = 0;

    double cccdHouseSimilar = 0.0;
    int cccdHouseStartIndex = 0;
    int cccdHouseStopIndex = 0;

    double cccdDeadlineSimilar = 0.0;
    int cccdDeadlineStartIndex = 0;
    int cccdDeadlineStopIndex = 0;

    for (int i = 0; i < textsRecognizedFromIng.length; i++) {
      if (i < textsRecognizedFromIng.length - 19) {
        //can cuoc cong dan so
        double similarCCCD =
            textsRecognizedFromIng.substring(i, i + 19).toLowerCase().similarityTo("can cuoc cong dan so");
        if (similarCCCD > cccdTitleSimilar) {
          cccdTitleSimilar = similarCCCD;
          cccdTitleStartIndex = i;
          cccdTitleStopIndex = i + 19;
        }
      }

      if (i < textsRecognizedFromIng.length - 9) {
        //ho va ten
        double similarHoVaTen = textsRecognizedFromIng.substring(i, i + 9).toLowerCase().similarityTo("ho va ten");
        if (similarHoVaTen > cccdHoTenSimilar) {
          cccdHoTenSimilar = similarHoVaTen;
          cccdHoTenStartIndex = i;
          cccdHoTenStopIndex = i + 9;
        }
      }

      if (i < textsRecognizedFromIng.length - 19) {
        //ngay thang nam sinh
        double similarDOB =
            textsRecognizedFromIng.substring(i, i + 19).toLowerCase().similarityTo("ngay thang nam sinh");
        if (similarDOB > cccdDOBSimilar) {
          cccdDOBSimilar = similarDOB;
          cccdDOBStartIndex = i;
          cccdDOBStopIndex = i + 19;
        }
      }

      if (i < textsRecognizedFromIng.length - 9) {
        //gioi tinh
        double similarGender = textsRecognizedFromIng.substring(i, i + 9).toLowerCase().similarityTo("gioi tinh");
        if (similarGender > cccdGenderSimilar) {
          cccdGenderSimilar = similarGender;
          cccdGenderStartIndex = i;
          cccdGenderStopIndex = i + 9;
        }
      }

      if (i < textsRecognizedFromIng.length - 9) {
        //quoc tich
        double similarNational = textsRecognizedFromIng.substring(i, i + 9).toLowerCase().similarityTo("quoc tich");
        if (similarNational > cccdNationalSimilar) {
          cccdNationalSimilar = similarNational;
          cccdNationalStartIndex = i;
          cccdNationalStopIndex = i + 9;
        }
      }

      if (i < textsRecognizedFromIng.length - 8) {
        //que quan
        double similarHome = textsRecognizedFromIng.substring(i, i + 8).toLowerCase().similarityTo("que quan");
        if (similarHome > cccdHomeSimilar) {
          cccdHomeSimilar = similarHome;
          cccdHomeStartIndex = i;
          cccdHomeStopIndex = i + 8;
        }
      }

      if (i < textsRecognizedFromIng.length - 14) {
        //noi thuong tru
        double similarHouse = textsRecognizedFromIng.substring(i, i + 14).toLowerCase().similarityTo("noi thuong tru");
        if (similarHouse > cccdHouseSimilar) {
          cccdHouseSimilar = similarHouse;
          cccdHouseStartIndex = i;
          cccdHouseStopIndex = i + 14;
        }
      }

      if (i < textsRecognizedFromIng.length - 14) {
        //co gia tri den
        double similarDeadline =
            textsRecognizedFromIng.substring(i, i + 14).toLowerCase().similarityTo("co gia tri den");
        if (similarDeadline > cccdDeadlineSimilar) {
          cccdDeadlineSimilar = similarDeadline;
          cccdDeadlineStartIndex = i;
          cccdDeadlineStopIndex = i + 14;
        }
      }
    }

    cmnd_data = CMND_Data(
        status: "Success",
        message: "Message",
        data: Data(
          cmnd_num: "",
          cmnd_name: "",
          cmnd_dob: "",
          cmnd_house: "",
          cmnd_home: "",
          cmnd_nation: "",
        ));

    print("------------------------------");
    print(textsRecognizedFromIng);
    print("------------------------------");

    if (cccdTitleStopIndex < cccdHoTenStartIndex) {
      print("analyzeText - cccd - ${textsRecognizedFromIng.substring(cccdTitleStopIndex, cccdHoTenStartIndex)}");
      cmnd_data!.data!.cmnd_num = "${textsRecognizedFromIng.substring(cccdTitleStopIndex, cccdHoTenStartIndex)}";
    }
    if (cccdHoTenStopIndex < cccdDOBStartIndex) {
      print("analyzeText - ho ten - ${textsRecognizedFromIng.substring(cccdHoTenStopIndex, cccdDOBStartIndex)}");
      cmnd_data!.data!.cmnd_name = "${textsRecognizedFromIng.substring(cccdHoTenStopIndex, cccdDOBStartIndex)}";
    }
    if (cccdDOBStopIndex < cccdGenderStartIndex) {
      print("analyzeText - dob - ${textsRecognizedFromIng.substring(cccdDOBStopIndex, cccdGenderStartIndex)}");
      cmnd_data!.data!.cmnd_dob = "${textsRecognizedFromIng.substring(cccdDOBStopIndex, cccdNationalStartIndex)}";
    }
    if (cccdGenderStopIndex < cccdNationalStartIndex) {
      print("analyzeText - gender - ${textsRecognizedFromIng.substring(cccdGenderStopIndex, cccdNationalStartIndex)}");
      cmnd_data!.data!.cmnd_gender = "${textsRecognizedFromIng.substring(cccdGenderStopIndex, cccdNationalStartIndex)}";
    }
    if (cccdNationalStopIndex < cccdHomeStartIndex) {
      print("analyzeText - national - ${textsRecognizedFromIng.substring(cccdNationalStopIndex, cccdHomeStartIndex)}");
      cmnd_data!.data!.cmnd_nation = "${textsRecognizedFromIng.substring(cccdNationalStopIndex, cccdHomeStartIndex)}";
    }
    if (cccdHomeStopIndex < cccdHouseStartIndex) {
      print("analyzeText - home - ${textsRecognizedFromIng.substring(cccdHomeStopIndex, cccdHouseStartIndex)}");
      cmnd_data!.data!.cmnd_home = "${textsRecognizedFromIng.substring(cccdHomeStopIndex, cccdHouseStartIndex)}";
    }
    if (cccdHouseStopIndex < cccdDeadlineStartIndex) {
      print("analyzeText - house - ${textsRecognizedFromIng.substring(cccdHouseStopIndex, cccdDeadlineStartIndex)}");
      cmnd_data!.data!.cmnd_house = "${textsRecognizedFromIng.substring(cccdHouseStopIndex, cccdDeadlineStartIndex)}";
    }

    return cmnd_data;
  }

  @override
  FutureOr<void> init() {}
}
