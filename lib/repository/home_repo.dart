import '../consts/urls/urls.dart';
import '../model/inforformimg_model.dart';
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

  Future<List<ThongTinCaNhanList>?> getListSaveData(dynamic params) async {
    try {
      dynamic response = await _apiServices.getPostApiResponseWithAuth(AppUrl.listInfor, params);
      print('res list save :$response');
      ListSaveModel listSave = ListSaveModel.fromJson(response);
      List<ThongTinCaNhanList>? listData = listSave.thongTinCaNhanList;
      return listData;
    } catch (e) {
      print("get getListLeave erorr:${e}");
      throw e;
    }
  }

  Future<GetInforFormImgModel> getDataFromImg(dynamic params, String imgUrl) async {
    try {
      dynamic response = await _apiServices.getPostApiResponseWithAuthCustom(AppUrl.getInforFromImg, params, imgUrl);
      GetInforFormImgModel resImgIfor = GetInforFormImgModel.fromJson(response);
      print('getDataFromImg res:$response');
      print('aaaa:${resImgIfor}');
      return resImgIfor;
    } catch (e) {
      print("get getDataFromImg erorr:${e}");
      throw e;
    }
  }
}
