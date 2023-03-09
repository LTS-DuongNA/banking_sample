import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../model/cmnd_data.dart';

abstract class APIRepository {
  Future<void> calAPISample();
  Future<CMND_Data?> getInfoFromImg();
}

class APIRepositoryImpl extends APIRepository {
  @override
  Future<CMND_Data?> getInfoFromImg() async {
    print("getListSite -> start");
    try {
      final res = await Dio().post(
          'http://10.0.2.2:5000/key_value_extraction_ns/',
          data: {
            "config_data_id": "3",
            "image_url": "https://lambangnhanh.vn/wp-content/uploads/2019/09/lam-chung-minh-nhan-dan.jpg",
            "public_id": "3"
          }
      );
      CMND_Data result = CMND_Data.fromJson(res.data);
      print('res.data ${res.data}');
      return result;
    } catch (e) {
      print("getInfoFromImg $e");
      return null;
    }
  }

  @override
  Future<void> calAPISample() async {
    print("getListSite -> start");
    var client = http.Client();
    var response = await client.get(Uri.http('10.0.2.2:5000', 'config_data'));

    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    client.close();
    print("getListSite -> done $decodedResponse");
  }
}
