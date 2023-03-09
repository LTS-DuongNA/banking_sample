import 'dart:async';

class ObservableService {
  static final ObservableService _observableService = ObservableService._internal();

  ObservableService._internal();

  factory ObservableService() {
    return _observableService;
  }

  //cmnd
  final StreamController<dynamic> cmndController = StreamController<dynamic>.broadcast();

  Stream<dynamic> get cmndStream => cmndController.stream;
}
