import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../observable/observable_serivce.dart';
import '../repository/cmnd_repository.dart';
import 'base_viewmodel.dart';
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';

class HomeViewModel extends BaseViewModel {
  static final HomeViewModel _instance = HomeViewModel._internal();

  factory HomeViewModel() {
    return _instance;
  }

  HomeViewModel._internal();

  final ObservableService _observableService = ObservableService();
  final _myRepo = CmndRepository();
  List<CameraDescription> cameras = <CameraDescription>[];
  final ObservableService _myObservable = ObservableService();
  XFile? imageFile;
  XFile? videoFile;

  @override
  FutureOr<void> init() {}

  Future<void> sendCmnd(Map<String, dynamic> data) async {
    _myRepo.sendCmndInfor(data).then((value) {
      if (value != null) {
        _myObservable.cmndController.sink.add(value);
      } else {
        _myObservable.cmndController.sink.add([]);
      }
    }).onError((error, stackTrace) {
      print('send cmnd erorr: $error');
    });
  }

  Future<void> getListPark() async {
    _myRepo.getPark().then((value) {
      if (value != null) {
        //
      } else {
        //
      }
    }).onError((error, stackTrace) {
      print('get list park error : $error');
    });
  }
}
