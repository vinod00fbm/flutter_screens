import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm/model/questionModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mvvm/repository/evaluation_repository.dart';
import '../utils/utils.dart';

class PreScreeningViewModel extends ChangeNotifier {
  List<QandAScoring> qaScoring = [];
  List<SkillsAssessment> skillsAssessment = [];
  Evaluation? assessment;
  final _myRepo = SessionEvaluationRepository();

  Future<void> submitAnswers(Map<String, String> data) async {
    var uri =
        Uri.https('select-sense-apis.azurewebsites.net', '/session/getEvaluation',data);

    try {
      final response = await http.get(uri,
          headers: {"Content-Type": "application/json"},
          );

     /* body: jsonEncode({
        'questions': answers.map((answer) => answer.toJson()).toList(),
      })*/

      if (response.statusCode == 200 || response.statusCode == 201) {
        // API call was successful, handle the response data here
        print("SUCCESS:${response.body}");
        Map<String, dynamic> jsonMap = json.decode(response.body);
        assessment = AssessmentModel.fromJson(jsonMap).evaluation;

        // qaScoring = assessment.qandAScoring;
        // skillsAssessment = assessment.skillsAssessment;
        notifyListeners();
      } else {
        // API call failed, handle the error
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred during the API call
      print('Error: $e');
    }
  }

  Future<void> selectOrRejectCandidate(String candidateId, bool isSelected,  BuildContext context) async {

    _myRepo.selectOrRejectCandidate(candidateId,isSelected).then((value) {
        print(value.toString());
        Utils.showFlushBarErrorMessage(value.toString(), context);
    }).onError((error, stackTrace) {
        Utils.printLogs('Inside On error');
        Utils.printLogs('Create Session ${error.toString()}');
        Utils.showFlushBarErrorMessage(error.toString(), context);
    });
  }
}
