import '../consts/urls/urls.dart';
import '../service/baseApiService.dart';
import '../service/networkService.dart';

class CmndRepository {
  BaseApiService _apiServices = NetworkService();

  Future sendCmndInfor(Map<String, dynamic> data) async {
    try {
      dynamic response = await _apiServices.postApi(MyUrls.sendCmnd, data);
    } catch (e) {
      print(e);
    }
  }

  Future getPark() async {
    try {
      dynamic res = await _apiServices.getApi(MyUrls.listPark);
      print('your park : $res');
    } catch (e) {
      print(e);
    }
  }
}
