abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url, Map<String, dynamic> params);
  Future<dynamic> getPostApiResponse(String url,  Map<String, dynamic> data);

  Future<dynamic> getGetApiResponseWithAuth(
      String url, Map<String, dynamic> params);

  Future<dynamic> getGetApiResponseWithAuthnoParams(String url);

  Future<dynamic> getPostApiResponseWithAuth(String url, dynamic params);
}
