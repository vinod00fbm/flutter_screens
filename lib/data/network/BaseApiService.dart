abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);

  Future<dynamic> getGetApiResponseQuery(String url, dynamic data);

  Future<dynamic> getPostApiResponse(String url, dynamic data);
}
