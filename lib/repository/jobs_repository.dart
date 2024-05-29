import 'package:flutter_mvvm/model/jobs_list_model.dart';

import '../data/network/BaseApiService.dart';
import '../data/network/NetworkApiService.dart';
import '../res/components/app_url.dart';
import '../utils/utils.dart';

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

  Future<List<Jobs>> getJobs() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrls.getJobs);
      if (response is List) {
        List<Jobs> jobs = response.map((item) => Jobs.fromJson(item)).toList();
        Utils.printLogs('Jobs List ${jobs.toString()}');
        return jobs;
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      Utils.printLogs('Error: $e');
      rethrow;
    }
  }

  /*Future<dynamic> getJobs() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrls.getJobs);
      List<dynamic> responseList = response as List<dynamic>;
      List<Jobs> jobs =
          responseList.map((item) => Jobs.fromJson(item)).toList();
      Utils.printLogs('Jobs List ${jobs.toString()}');
      return jobs;
    } catch (e) {
      Utils.printLogs('$e');
      rethrow;
    }
  }*/

  Future<dynamic> generateJobDescription(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrls.getJobDescription, data);
      Utils.printLogs('App Url: ${AppUrls.getJobDescription}');
      Utils.printLogs('Input: $data');
      return response;
    } catch (e) {
      Utils.printLogs('$e');
      rethrow;
    }
  }
}
