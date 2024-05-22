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
      print(value.toString());
      print('Inside On success');
      Utils.showFlushBarErrorMessage(value.toString(), context);
      Navigator.pushNamed(context, RoutesNames.createCandidate);
    }).onError((error, stackTrace) {
      print('Inside On error');
      Utils.showFlushBarErrorMessage(error.toString(), context);
      print(error.toString());
    });
  }

  ApiResponse<JobsListModel> jobsList = ApiResponse.loading();

  setJobList(ApiResponse<JobsListModel> response) {
    jobsList = response;
    notifyListeners();
  }
  Future<void> getJobs(BuildContext context) async {
    _myRepo.getJobs().then((value) {
      print(value.toString());
      print('Inside On get jobs');
      Utils.showFlushBarErrorMessage(value.toString(), context);
      //Navigator.pushNamed(context, RoutesNames.home);
    }).onError((error, stackTrace) {
      print('Inside On error get jobs');
      Utils.showFlushBarErrorMessage(error.toString(), context);
      print(error.toString());
    });
  }

  Future<void> generateJobDescription(
      dynamic data, BuildContext context) async {
    _myRepo.generateJobDescription(data).then((value) {
      print(value.toString());
      print('Inside generate JobDescription');
    }).onError((error, stackTrace) {
      print('Inside On error generate JobDescription');
    });
  }
}
