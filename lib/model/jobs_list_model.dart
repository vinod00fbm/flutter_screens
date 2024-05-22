class JobsListModel {
  List<Jobs>? jobsList;

  JobsListModel({this.jobsList});

  factory JobsListModel.fromJson(List<dynamic> json) {
    List<Jobs> jobsList = json.map((item) => Jobs.fromJson(item)).toList();
    return JobsListModel(jobsList: jobsList);
  }
}

class Jobs {
  String? sId;
  int? jobId;
  String? jobName;
  String? jobDesc;
  String? jobType;

  Jobs({this.sId, this.jobId, this.jobName, this.jobDesc, this.jobType});

  factory Jobs.fromJson(Map<String, dynamic> json) {
    return Jobs(
        sId: json['_id'],
        jobId: json['jobId'],
        jobName: json['jobName'],
        jobDesc: json['jobDesc'],
        jobType: json['jobType']);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'jobId': jobId,
      'jobName': jobName,
      'jobDesc': jobDesc,
      'jobType': jobType,
    };
  }
}
