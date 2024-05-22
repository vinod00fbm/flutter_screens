
import '../data/network/BaseApiService.dart';
import '../data/network/NetworkApiService.dart';
import '../res/components/app_url.dart';

class CreateSessionRepository{
  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> createSession(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponseQuery(AppUrls.createSession, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
