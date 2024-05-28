import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/response/Status.dart';
import 'package:flutter_mvvm/res/components/round_button.dart';
import 'package:flutter_mvvm/utils/routes/routes_names.dart';
import 'package:provider/provider.dart';
import '../res/components/Constants.dart';
import '../utils/GradientAppBar.dart';
import '../view_model/jobs_viewmodel.dart';

class JobListPage extends StatefulWidget {
  const JobListPage({super.key});

  @override
  State<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  JobsViewModel jobsViewModel = JobsViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      jobsViewModel.getJobs(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: AppConstants.jobList,
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      body: ChangeNotifierProvider<JobsViewModel>(
        create: (BuildContext context) => jobsViewModel,
        child: Consumer<JobsViewModel>(
          builder: (context, value, child) {
            switch (value.jobsList.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Center(child: Text(value.jobsList.message.toString()));
              case Status.COMPLETED:
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150.0,
                            child: RoundedButton(
                              title: 'Create Candidate',
                              onPress: () {
                                Navigator.pushNamed(
                                    context, RoutesNames.createCandidate);
                              },
                            ),
                          ),
                          const SizedBox(width: 25.0),
                          SizedBox(
                            width: 150.0,
                            child: RoundedButton(
                              title: 'Create Job',
                              onPress: () {
                                Navigator.pushNamed(
                                    context, RoutesNames.createJob);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: value.jobsList.data?.jobsList?.length ?? 0,
                        itemBuilder: (context, index) {
                          var job = value.jobsList.data?.jobsList?[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 6.0),
                            child: Card(
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(16.0),
                                title: Text(
                                  'Job Name: ${job?.jobName ?? 'No Job Name'}',
                                  style: const TextStyle(
                                    fontFamily: 'sourcesanspro_bold',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Job Id: ${job?.jobId ?? 'No Job ID'}',
                                      style: const TextStyle(
                                        fontFamily: 'sourcesanspro_bold',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Job Type: ${job?.jobType ?? 'No Job Type'}',
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
                      ),
                    ),
                  ],
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
