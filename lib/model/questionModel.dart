
class QuestionsModel {
  final String question;
  final int duration;

  QuestionsModel({required this.question, required this.duration});

  factory QuestionsModel.fromJson(Map<String, dynamic> json) {
    return QuestionsModel(
      question: json['question'],
      duration: json['duration'],
    );
  }
}

class AnswersModel {
  String question;
  String answer;
  int qt;
  int at;

  AnswersModel({
    required this.question,
    this.answer = '',
    required this.qt,
    required this.at,
  });

  Map<String, dynamic> toJson() => {
    'question': question,
    'answer': answer,
    'qt': qt,
    'at': at,
  };

  factory AnswersModel.fromJson(Map<String, dynamic> json) {
    return AnswersModel(
      question: json['question'],
      answer: json['answer'] ?? '',
      qt: json['qt'],
      at: json['at'],
    );
  }
}


class Assessment {
  final int overallScore;
  final List<QandAScoring> qandAScoring;
  final List<SkillsAssessment> skillsAssessment;

  Assessment({
    required this.overallScore,
    required this.qandAScoring,
    required this.skillsAssessment,
  });

  factory Assessment.fromJson(Map<String, dynamic> json) {
    var qandAScoringList = json['QandAScoring'] as List;
    var skillsAssessmentList = json['skillsAssessment'] as List;

    return Assessment(
      overallScore: json['overallScore'],
      qandAScoring: qandAScoringList.map((i) => QandAScoring.fromJson(i)).toList(),
      skillsAssessment: skillsAssessmentList.map((i) => SkillsAssessment.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'overallScore': overallScore,
      'QandAScoring': qandAScoring.map((e) => e.toJson()).toList(),
      'skillsAssessment': skillsAssessment.map((e) => e.toJson()).toList(),
    };
  }
}

class QandAScoring {
  final String question;
  final String answer;
  final int score;

  QandAScoring({
    required this.question,
    required this.answer,
    required this.score,
  });

  factory QandAScoring.fromJson(Map<String, dynamic> json) {
    return QandAScoring(
      question: json['question'],
      answer: json['answer'],
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
      'score': score,
    };
  }
}

class SkillsAssessment {
  final String skill;
  final String rating;

  SkillsAssessment({
    required this.skill,
    required this.rating,
  });

  factory SkillsAssessment.fromJson(Map<String, dynamic> json) {
    return SkillsAssessment(
      skill: json['skill'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'skill': skill,
      'rating': rating,
    };
  }
}
