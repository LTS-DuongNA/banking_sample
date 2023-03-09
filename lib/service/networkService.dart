import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'app_excaptions.dart';
import 'baseApiService.dart';

class NetworkService extends BaseApiService {
  @override
  Future getApi(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postApi(String url, Map<String, dynamic> data) async {
    dynamic responseJson;
    try {
      final response = await http.post(
        Uri.parse(url),
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
            'Error accured while communicating with server' + 'with status code' + response.statusCode.toString());
    }
  }
}
