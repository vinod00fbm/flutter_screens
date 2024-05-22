import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';

import 'package:flutter_mvvm/model/candidate_list_model.dart';

import '../data/network/BaseApiService.dart';
import '../data/network/NetworkApiService.dart';
import '../res/components/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class CandidateRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  /* Future<dynamic> createCandidate(dynamic data,String? filePath) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(AppUrls.createCandidate, data);
      return response;
    } catch (e) {
      print('$e');
      rethrow;
    }
  }*/

  //Using bytes instead of file path
  //request.files.add(http.MultipartFile.fromBytes(       'file',       file.bytes!,       filename: file.name,     ));

  Future<dynamic> createCandidate(dynamic data, PlatformFile? filePath) async {
    try {
      var uri =
          Uri.parse('https://select-sense-apis.azurewebsites.net/candidate/');
      var request = http.MultipartRequest('POST', uri);
      request.files.add(http.MultipartFile.fromBytes('resume', filePath!.bytes!,
          filename: filePath.name));
      request.fields.addAll(data);
      var response = await request.send();
      if (response.statusCode == 200) {
        print('File uploaded successfully');
      } else {
        print('File upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('$e');
      rethrow;
    }
  }

  Future<List<Candidate>> getCandidatesList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrls.getCandidates);
      // Assuming response is already a List<dynamic>
      List<dynamic> responseList = response as List<dynamic>;
      List<Candidate> candidates =
          responseList.map((item) => Candidate.fromJson(item)).toList();
      print("candidate List $candidates");
      return candidates;
    } catch (e) {
      print('$e');
      rethrow;
    }
  }
}
