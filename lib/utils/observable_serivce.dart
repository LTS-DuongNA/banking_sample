import 'dart:async';
import 'package:rxdart/rxdart.dart';

class ObservableService {
  static final ObservableService _observableService = ObservableService._internal();

  ObservableService._internal();

  factory ObservableService() {
    return _observableService;
  }

  //alert controller
  final StreamController<String> showAlertController = StreamController<String>.broadcast();
  Stream<String> get showAlertStream => showAlertController.stream;

}
