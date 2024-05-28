class JobNameList {
  List<Jobs>? jobsList;

  JobNameList({this.jobsList});

  factory JobNameList.fromJson(List<dynamic> json) {
    List<Jobs> jobsList = json.map((item) => Jobs.fromJson(item)).toList();
    return JobNameList(jobsList: jobsList);
  }
}

class Jobs {
  String? sId;
  int? jobId;
  String? jobName;
  String? jobType;

  Jobs({this.sId, this.jobId, this.jobName, this.jobType});

  factory Jobs.fromJson(Map<String, dynamic> json) {
    return Jobs(
        sId: json['_id'],
        jobId: json['jobId'],
        jobName: json['jobName'],
        jobType: json['jobType']);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'jobId': jobId,
      'jobName': jobName,
      'jobType': jobType,
    };
  }

  @override
  String toString() {
    return 'Job{jobId: $jobId, jobName: $jobName}';
  }
}
