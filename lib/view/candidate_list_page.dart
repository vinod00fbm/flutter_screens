import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/response/Status.dart';
import 'package:flutter_mvvm/res/components/round_button.dart';
import 'package:flutter_mvvm/utils/routes/routes_names.dart';
import 'package:flutter_mvvm/view_model/candidate_viewmodel.dart';
import 'package:provider/provider.dart';

class CandidateListPage extends StatefulWidget {
  const CandidateListPage({super.key});

  @override
  State<CandidateListPage> createState() => _CandidateListPageState();
}

class _CandidateListPageState extends State<CandidateListPage> {
  CandidateViewModel candidateViewModel = CandidateViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      candidateViewModel.getCandidatesList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Spacer(),
            SizedBox(
              width: 250.0,
            ),
            Text(
              'Candidate List',
              style: TextStyle(
                fontFamily: 'sourcesanspro_bold',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
          ],
        ),
        actions: [
          SizedBox(
            width: 150.0,
            child: RoundedButton(
              title: 'Create Candidate',
              onPress: () {
                Navigator.pushNamed(context, RoutesNames.createCandidate);
              },
            ),
          ),
          const SizedBox(
            width: 25.0,
          ),
          SizedBox(
            width: 150.0,
            child: RoundedButton(
              title: 'Create Job',
              onPress: () {
                Navigator.pushNamed(context, RoutesNames.createJob);
              },
            ),
          ),
          const SizedBox(
            width: 25.0,
          ),
          SizedBox(
            width: 150.0,
            child: RoundedButton(
              title: 'Jobs List',
              onPress: () {
                Navigator.pushNamed(context, RoutesNames.jobsList);
              },
            ),
          ),
          const SizedBox(
            width: 120.0,
          )
        ],
      ),
      body: ChangeNotifierProvider<CandidateViewModel>(
        create: (BuildContext context) => candidateViewModel,
        child: Consumer<CandidateViewModel>(
          builder: (context, value, child) {
            switch (value.candidateList.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Center(
                    child: Text(value.candidateList.message.toString()));
              case Status.COMPLETED:
                return ListView.builder(
                  itemCount:
                      value.candidateList.data?.candidateList?.length ?? 0,
                  itemBuilder: (context, index) {
                    var candidate =
                        value.candidateList.data?.candidateList?[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 150.0, vertical: 6.0),
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Candidate Name:-> ${candidate?.fullName}' ??
                                    'No Name',
                                style: TextStyle(
                                  fontFamily: 'sourcesanspro_bold',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Job Id:-> ${candidate?.jobId}' ??
                                    'No Job ID',
                                style: const TextStyle(
                                  fontFamily: 'sourcesanspro_bold',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'File Name:-> ${candidate?.fileName}' ??
                                    'No File Name',
                                style: const TextStyle(
                                  fontFamily: 'sourcesanspro_bold',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Candidate Id:-> ${candidate?.candidateId?.toString()}' ??
                                    'No ID',
                                style: const TextStyle(
                                  fontFamily: 'sourcesanspro_bold',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            // Handle tap if needed, e.g., navigate to a detailed view
                          },
                        ),
                      ),
                    );
                  },
                );
              default:
                return Container(); // or some default widget
            }
          },
        ),
      ),
    );
  }
}
