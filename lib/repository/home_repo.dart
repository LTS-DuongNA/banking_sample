import '../consts/urls/urls.dart';
import '../model/listdata_model.dart';
import '../model/saveInfor_model.dart';
import '../network/BaseApiServices.dart';
import '../network/NetworkApiService.dart';

class HomeRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<ResSaveIforModel> SaveInfor(Map<String, dynamic> data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.saveInfor, data);
      ResSaveIforModel SaveInforRes = ResSaveIforModel.fromJson(response);
      return SaveInforRes;
    } catch (e) {
      print("save erorr repo:${e}");
      rethrow;
    }
  }

  Future<List<ListSaveModel>> getListSaveData(dynamic params) async {
    try {
      dynamic response = await _apiServices.getPostApiResponseWithAuth(AppUrl.listInfor, params);
      print('res list save :$response');
      List<ListSaveModel>listSave=[];
      listSave.add( ListSaveModel.fromJson(response));
      return listSave;
    } catch (e) {
      print("get getListLeave erorr:${e}");
      throw e;
    }
  }
}
