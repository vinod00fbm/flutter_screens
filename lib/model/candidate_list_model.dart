class CandidateListModel {
  List<Candidate>? candidateList;

  CandidateListModel({this.candidateList});

  factory CandidateListModel.fromJson(List<dynamic> json) {
    List<Candidate> candidatesList = json.map((item) => Candidate.fromJson(item)).toList();
    return CandidateListModel(candidateList: candidatesList);
  }
}

class Candidate {
  String? sId;
  int? candidateId;
  String? fullName;
  String? fileName;
  String? jobId;

  Candidate({this.sId, this.candidateId, this.fullName, this.fileName, this.jobId});

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      sId: json['_id'],
      candidateId: json['candidateId'] is String ? int.parse(json['candidateId']) : json['candidateId'],
      fullName: json['fullName'],
      fileName: json['fileName'],
      jobId: json['jobId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'candidateId': candidateId,
      'fullName': fullName,
      'fileName': fileName,
      'jobId': jobId,
    };
  }
}