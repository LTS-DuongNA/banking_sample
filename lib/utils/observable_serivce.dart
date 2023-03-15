import 'dart:async';
import 'package:rxdart/rxdart.dart';

import '../model/listdata_model.dart';

class ObservableService {
  static final ObservableService _observableService = ObservableService._internal();

  ObservableService._internal();

  factory ObservableService() {
    return _observableService;
  }

  //alert controller
  final StreamController<String> showAlertController = StreamController<String>.broadcast();
  Stream<String> get showAlertStream => showAlertController.stream;

  final StreamController<String> showSaveAlertController = StreamController<String>.broadcast();
  Stream<String> get showSaveAlertStream => showSaveAlertController.stream;


  final StreamController<List<ListSaveModel>?> listSaveController = StreamController<List<ListSaveModel>?>.broadcast();
  Stream<List<ListSaveModel>?> get listSaveStream => listSaveController.stream;


}
