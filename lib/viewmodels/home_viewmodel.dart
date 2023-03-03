import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../utils/observable_serivce.dart';
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

  List<CameraDescription> cameras = <CameraDescription>[];

  XFile? imageFile;
  XFile? videoFile;

  @override
  FutureOr<void> init() {}
}
