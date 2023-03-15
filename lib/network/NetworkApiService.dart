import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../../utils/pref_util.dart';
import 'BaseApiServices.dart';
import 'app_excaptions.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url, Map<String, dynamic> params) async {
    dynamic responseJson;
    var header = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer ${PrefUtil.getValue('accessToken', "")}",
    };
    try {
      final response = await http
          .get(Uri.parse(url), headers: header)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url,  Map<String, dynamic> data) async {
    dynamic responseJson;
    var header = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer ${PrefUtil.getValue('accessToken', "")}",
    };
    try {
      final msg = jsonEncode(data);
      Response response = await post(Uri.parse(url), body: msg,headers: header)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } catch (e){
      print(" getPostApiResponse $e");
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  /// WITH AUTHENTICATION

  @override
  Future getGetApiResponseWithAuth(
      String url, Map<String, dynamic> params) async {
    dynamic responseJson;

    var header = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer ${PrefUtil.getValue('accessToken', "")}",
    };

    try {
      final response = await http
          .get(Uri.parse(url), headers: header)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponseWithAuth(String url, dynamic params) async {
    dynamic responseJson;
    Uri uri = Uri.parse(url);
    final finalUri = uri.replace(queryParameters: params);
    try {
      final response = await http.get(
        finalUri,
        headers: {
          'Authorization': 'Bearer ${PrefUtil.getValue('accessToken', "")}',
        },
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 500:
        throw BadRequestException(response.body.toString());
      default:
        throw FetchDataException(
            'Error accured while communicating with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }

  @override
  Future getGetApiResponseWithAuthnoParams(String url) async {
    dynamic responseJson;

    var header = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer ${PrefUtil.getValue('accessToken', "")}",
    };

    try {
      final response = await http
          .get(Uri.parse(url), headers: header)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }
}
