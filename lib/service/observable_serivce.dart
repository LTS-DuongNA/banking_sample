import 'dart:async';
import 'package:rxdart/rxdart.dart';

class ObservableService {
  static final ObservableService _observableService = ObservableService._internal();

  ObservableService._internal();

  factory ObservableService() {
    return _observableService;
  }

  ///Declare observer object and stream
  final StreamController<bool> reloadInfoController = BehaviorSubject<bool>();
  Stream<bool> get reloadInfoStream => reloadInfoController.stream;
}
