import '../data/network/BaseApiService.dart';
import '../data/network/NetworkApiService.dart';
import '../res/components/app_url.dart';

class JobsRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> createJob(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrls.postJobEndPoint, data);
      return response;
    } catch (e) {
      print('$e');
      rethrow;
    }
  }

  Future<dynamic> getJobs() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrls.getJobs);
      return response;
    } catch (e) {
      print('$e');
      rethrow;
    }
  }

  Future<dynamic> generateJobDescription(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrls.getJobDescription, data);
      print('App Url: ${AppUrls.getJobDescription}');
      print('Input: $data');
      return response;
    } catch (e) {
      print('$e');
      rethrow;
    }
  }
}
