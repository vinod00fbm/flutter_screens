import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm/model/jobs_list_model.dart';
import 'package:flutter_mvvm/repository/jobs_repository.dart';

import '../data/response/api_response.dart';
import '../utils/routes/routes_names.dart';
import '../utils/utils.dart';

class JobsViewModel with ChangeNotifier {
  final _myRepo = JobsRepository();

  Future<void> createJob(dynamic data, BuildContext context) async {
    _myRepo.createJob(data).then((value) {
      Utils.printLogs(value.toString());
      Utils.printLogs('Inside On success');
      Utils.showFlushBarSuccessMessage(value.toString(), context);
      Navigator.pushNamed(context, RoutesNames.createCandidate);
    }).onError((error, stackTrace) {
      Utils.printLogs('Inside On error');
      Utils.showFlushBarErrorMessage(error.toString(), context);
      Utils.printLogs(error.toString());
    });
  }

  ApiResponse<JobsListModel> jobsList = ApiResponse.loading();

  void _setJobList(ApiResponse<JobsListModel> response) {
    jobsList = response;
    notifyListeners();
  }

  Future<void> getJobs(BuildContext context) async {
    try {
      var jobs = await _myRepo.getJobs();
      Utils.printLogs('Inside On success job list');
      _setJobList(ApiResponse.completed(JobsListModel(jobsList: jobs)));
    } catch (error) {
      Utils.printLogs('Inside On Error job list: $error');
      _setJobList(ApiResponse.error(error.toString()));
    }
  }

  Future<void> generateJobDescription(
      dynamic data, BuildContext context) async {
    _myRepo.generateJobDescription(data).then((value) {
      Utils.printLogs(value.toString());
      Utils.printLogs('Inside generate JobDescription');
    }).onError((error, stackTrace) {
      Utils.printLogs('Inside On error generate JobDescription');
    });
  }
}
