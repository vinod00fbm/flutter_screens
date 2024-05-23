class EvaluationModel {
  Evaluation? evaluation;

  EvaluationModel({this.evaluation});

  EvaluationModel.fromJson(Map<String, dynamic> json) {
    evaluation = json['evaluation'] != null
        ? new Evaluation.fromJson(json['evaluation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.evaluation != null) {
      data['evaluation'] = this.evaluation!.toJson();
    }
    return data;
  }
}

class Evaluation {
  int? overallScore;
  String? summary;
  String? verdict;
  List<QandAScoring>? qandAScoring;
  List<SkillsAssessment>? skillsAssessment;

  Evaluation(
      {this.overallScore,
      this.summary,
      this.verdict,
      this.qandAScoring,
      this.skillsAssessment});

  Evaluation.fromJson(Map<String, dynamic> json) {
    overallScore = json['overallScore'];
    summary = json['summary'];
    verdict = json['verdict'];
    if (json['QandAScoring'] != null) {
      qandAScoring = <QandAScoring>[];
      json['QandAScoring'].forEach((v) {
        qandAScoring!.add(new QandAScoring.fromJson(v));
      });
    }
    if (json['skillsAssessment'] != null) {
      skillsAssessment = <SkillsAssessment>[];
      json['skillsAssessment'].forEach((v) {
        skillsAssessment!.add(new SkillsAssessment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['overallScore'] = this.overallScore;
    data['summary'] = this.summary;
    data['verdict'] = this.verdict;
    if (this.qandAScoring != null) {
      data['QandAScoring'] = this.qandAScoring!.map((v) => v.toJson()).toList();
    }
    if (this.skillsAssessment != null) {
      data['skillsAssessment'] =
          this.skillsAssessment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QandAScoring {
  String? question;
  String? answer;
  int? score;

  QandAScoring({this.question, this.answer, this.score});

  QandAScoring.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['score'] = this.score;
    return data;
  }
}

class SkillsAssessment {
  String? skill;
  String? rating;

  SkillsAssessment({this.skill, this.rating});

  SkillsAssessment.fromJson(Map<String, dynamic> json) {
    skill = json['skill'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['skill'] = this.skill;
    data['rating'] = this.rating;
    return data;
  }
}
