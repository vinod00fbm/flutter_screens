import 'package:flutter/material.dart';
import 'package:flutter_mvvm/model/questionModel.dart';
import 'package:provider/provider.dart';

import '../view_model/preScreeningViewModel.dart';

class AssessmentReviewScreen extends StatelessWidget {
  final int candidateId;

  AssessmentReviewScreen({required this.candidateId, Key? key})
      : super(key: key);
late PreScreeningViewModel createSessionViewModel;
  @override
  Widget build(BuildContext context) {
     createSessionViewModel =
        Provider.of<PreScreeningViewModel>(context as BuildContext);
    Map<String, String> data = {
      'candidateId': '1716284683481'
    }; //candidateId.toString()
    createSessionViewModel.submitAnswers(data);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text('DSA Coding Conassessments - January 23'),
        actions: const [
          CircleAvatar(
            child: Icon(Icons.person),
          ),
        ],
      ),
      body: Consumer<PreScreeningViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.assessment == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final assessment = viewModel.assessment!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildCandidateInfo(),
                const SizedBox(height: 16.0),
                buildScoreSummary(assessment),
                const SizedBox(height: 16.0),
                buildSpotlightSection(assessment.skillsAssessment),
                const SizedBox(height: 16.0),
                buildProctoringSection(),
                const SizedBox(height: 16.0),
                buildQandAScoring(assessment.qandAScoring),
                const SizedBox(height: 16.0),
                buildDetailsSubmissionReport(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildCandidateInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Bobby Williams (aka: Workable Octobriana)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            IconButton(icon: const Icon(Icons.report), onPressed: () {}),
            IconButton(icon: const Icon(Icons.copy), onPressed: () {}),
            ElevatedButton(onPressed: () {}, child: const Text('Shortlist')),
            const SizedBox(width: 8),
            ElevatedButton(
                onPressed: () {
                 // createSessionViewModel.selectOrRejectCandidate(this.candidateId,true);
                }, child: const Text('Start Instant Interview')),
          ],
        ),
      ],
    );
  }

  Widget buildScoreSummary(Evaluation assessment) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildScoreCard('Total Score', '${assessment.overallScore}/100',
                    'Qualified the ${assessment.overallScore} passing score'),
                buildScoreCard('Test Rank', '99/100', ''),
                buildBenchmarkingCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildScoreCard(String title, String score, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(score,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget buildBenchmarkingCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Global Benchmarking',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        const Text('Top 10% out of 175,020 candidates',
            style: TextStyle(fontSize: 16)),
        const SizedBox(height: 4),
        Container(
          height: 20,
          width: 200,
          color: Colors.grey[300],
          child: Row(
            children: [
              Container(color: Colors.red, width: 40),
              Container(color: Colors.orange, width: 40),
              Container(color: Colors.yellow, width: 40),
              Container(color: Colors.green, width: 40),
              Container(color: Colors.blue, width: 40),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSpotlightSection(List<SkillsAssessment> skillsAssessment) {
    Map<String, List<String>> categorizedSkills = {
      'good': [],
      'notsure': [],
      'bad': []
    };

    for (var skill in skillsAssessment) {
      if (categorizedSkills.containsKey(skill.rating.toLowerCase())) {
        categorizedSkills[skill.rating.toLowerCase()]?.add(skill.skill);
      }
    }

    return Row(
      children: [
        if (categorizedSkills['good']!.isNotEmpty)
          Expanded(
              child: buildSpotlightCard(
                  'Good',
                  categorizedSkills['good']!.join(', '),
                  Colors.green.shade100)),
        if (categorizedSkills['notsure']!.isNotEmpty)
          Expanded(
              child: buildSpotlightCard(
                  'Needs Review',
                  categorizedSkills['notsure']!.join(', '),
                  Colors.orange.shade100)),
        if (categorizedSkills['bad']!.isNotEmpty)
          Expanded(
              child: buildSpotlightCard('Could Be Better',
                  categorizedSkills['bad']!.join(', '), Colors.red.shade100)),
      ],
    );
  }

  Widget buildSpotlightCard(String title, String content, Color color) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(content, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProctoringSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildProctoringCard('5', 'Tab switches', Colors.red.shade100),
            buildProctoringCard(
                '0', 'Plagiarised answers', Colors.green.shade100),
            buildProctoringCard(
                '3', 'Snapshot violations', Colors.red.shade100),
          ],
        ),
      ),
    );
  }

  Widget buildProctoringCard(String value, String title, Color color) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget buildQandAScoring(List<QandAScoring> qandAScoring) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Q&A Scoring',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Column(
          children: qandAScoring.map((qa) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              // Add vertical margin for spacing between cards
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Question: ${qa.question}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Answer: ${qa.answer}',
                        style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 8),
                    Text('Score: ${qa.score}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget buildDetailsSubmissionReport() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Details submission report',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        buildQuestionReport(
            'Computer Networking',
            '5min / 10min',
            '8/10',
            'With the permission of an individual, you have to identify which operating system...',
            '32/40'),
        buildQuestionReport(
            'Data Structures',
            '10min / 15min',
            '30/30',
            '1 - With the permission of an individual, you have to identify which operating system...\n2 - Bob was given a string consisting of only 0, 1, A, O, X where\n3 - In Data structures, what is the time complexity of the following code',
            '32/40'),
      ],
    );
  }

  Widget buildQuestionReport(String title, String time, String score,
      String details, String totalScore) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style:
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Score: $totalScore',
                    style:
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            // SizedBox(height: 8),
            // Text('Time Taken: $time', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text('Score: $score', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(details, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
