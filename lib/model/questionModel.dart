import 'dart:convert';

AssessmentModel assessmentModelFromJson(String str) => AssessmentModel.fromJson(json.decode(str));

String assessmentModelToJson(AssessmentModel data) => json.encode(data.toJson());

class AssessmentModel {
  Evaluation evaluation;

  AssessmentModel({
    required this.evaluation,
  });

  factory AssessmentModel.fromJson(Map<String, dynamic> json) => AssessmentModel(
    evaluation: Evaluation.fromJson(json["evaluation"]),
  );

  Map<String, dynamic> toJson() => {
    "evaluation": evaluation.toJson(),
  };
}

class Evaluation {
  int overallScore;
  String summary;
  String verdict;
  List<QandAScoring> qandAScoring;
  List<SkillsAssessment> skillsAssessment;

  Evaluation({
    required this.overallScore,
    required this.summary,
    required this.verdict,
    required this.qandAScoring,
    required this.skillsAssessment,
  });

  factory Evaluation.fromJson(Map<String, dynamic> json) => Evaluation(
    overallScore: json["overallScore"],
    summary: json["summary"],
    verdict: json["verdict"],
    qandAScoring: List<QandAScoring>.from(json["QandAScoring"].map((x) => QandAScoring.fromJson(x))),
    skillsAssessment: List<SkillsAssessment>.from(json["skillsAssessment"].map((x) => SkillsAssessment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "overallScore": overallScore,
    "summary": summary,
    "verdict": verdict,
    "QandAScoring": List<dynamic>.from(qandAScoring.map((x) => x.toJson())),
    "skillsAssessment": List<dynamic>.from(skillsAssessment.map((x) => x.toJson())),
  };
}

class QandAScoring {
  String question;
  String answer;
  int score;

  QandAScoring({
    required this.question,
    required this.answer,
    required this.score,
  });

  factory QandAScoring.fromJson(Map<String, dynamic> json) => QandAScoring(
    question: json["question"],
    answer: json["answer"],
    score: json["score"],
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answer": answer,
    "score": score,
  };
}

class SkillsAssessment {
  String skill;
  String rating;

  SkillsAssessment({
    required this.skill,
    required this.rating,
  });

  factory SkillsAssessment.fromJson(Map<String, dynamic> json) => SkillsAssessment(
    skill: json["skill"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "skill": skill,
    "rating": rating,
  };
}