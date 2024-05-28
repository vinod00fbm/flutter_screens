import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/response/Status.dart';
import 'package:flutter_mvvm/res/components/round_button.dart';
import 'package:flutter_mvvm/utils/routes/routes_names.dart';
import 'package:provider/provider.dart';
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
              'Jobs List',
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
            width: 120.0,
          )
        ],
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: value.jobsList.data?.jobsList?.length ?? 0,
                        itemBuilder: (context, index) {
                          var job = value.jobsList.data?.jobsList?[index];
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
                                title: Column(
                                  children: [
                                    Text(
                                      'Job Name:-> ${job?.jobName}',
                                      style: const TextStyle(
                                        fontFamily: 'sourcesanspro_bold',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Job Id:-> ${job?.jobId}',
                                      style: const TextStyle(
                                        fontFamily: 'sourcesanspro_bold',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    /*Expanded(
                                    child: Text(
                                      maxLines: 10,
                                      // Limit the number of lines displayed
                                      overflow: TextOverflow.ellipsis,
                                      'Job Description:-> ${job?.jobDesc}' ??
                                          'No Job desc',
                                      style: const TextStyle(
                                        fontFamily: 'sourcesanspro_bold',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),*/
                                    Text(
                                      'Job Tye:-> ${job?.jobType}',
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
