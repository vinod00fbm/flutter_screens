import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/res/components/round_button.dart';
import 'package:flutter_mvvm/view_model/jobs_viewmodel.dart';
import 'package:provider/provider.dart';

import '../res/components/Constants.dart';
import '../utils/GradientAppBar.dart';
import '../utils/utils.dart';

class CreateJob extends StatefulWidget {
  const CreateJob({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<CreateJob> createState() => _FormExampleState();
}

class _FormExampleState extends State<CreateJob> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _location = '';
  String _description = '';
  String? _nameError = null;

  @override
  Widget build(BuildContext context) {
    final jobsViewModel = Provider.of<JobsViewModel>(context);
    return Scaffold(
      appBar: GradientAppBar(
        title: AppConstants.createNewJob,
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 100.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Job Title*',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter job title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              GestureDetector(
                onTap: () {
                  _showJobLocationDropdown(context);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Location Type*',
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    controller: TextEditingController(text: _location),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter type of location';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _location = value!;
                    },
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: TextFormField(
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _description = value!;
                      },
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    flex: 3,
                    child: RoundedButton(
                      onPress: () {
                        setState(() {
                          _nameError = null;
                        });
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          if (_name.isEmpty) {
                            setState(() {
                              _nameError = 'Please enter a job title';
                            });
                          } else {
                            Map data = {
                              'positionName': 'Senior Software Engineer',
                              'roles': 'Developing, Testing, Debugging',
                              'experience': 5
                            };
                            jobsViewModel.generateJobDescription(data, context);
                          }
                        }
                      },
                      title: 'Generate Description',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundedButton(
                    title: 'Submit Data',
                    loading: false,
                    onPress: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        // Do something with the form data, like submit it
                        print('Name: $_name');
                        print('Location: $_location');
                        print('Description: $_description');

                        Map data = {
                          'jobName': _name,
                          'jobDesc': _description,
                          'jobType': _location
                        };
                        // print('data: $data');
                        //jobsViewModel.createJob(data, context);
                        print('data:$data');
                        jobsViewModel.createJob(data, context);
                      }
                    },
                  ),
                  RoundedButton(
                      title: 'Next Button',
                      loading: false,
                      onPress: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          print('insode next button');
                          /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CandidatePage()),
                        );*/
                          //Navigator.pushNamed(context, RoutesNames.createCandidate);
                          Map data = {
                            'jobsId': Utils.randomNumberGenerator(context),
                            'jobName': _name,
                            'jobDesc': _description,
                            'jobType': _location
                          };
                          jobsViewModel.createJob(data, context);
                        }
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showJobLocationDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Location type'),
          content: SingleChildScrollView(
            child: Column(
              children: _locationTypes.map((locationType) {
                return ListTile(
                  title: Text(locationType),
                  onTap: () {
                    setState(() {
                      _location = locationType;
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  final List<String> _jobNames = [
    'Client Partner',
    'UI Developer',
    'QA Analyst',
    'Application Engineer',
    'Treasury App Support',
    'Dot Net Lead',
  ];
  final List<String> _locationTypes = ['On-site', 'Hybrid', 'Remote'];
/*void _showJobNameDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Job Name'),
          content: SingleChildScrollView(
            child: Column(
              children: _jobNames.map((jobName) {
                return ListTile(
                  title: Text(jobName),
                  onTap: () {
                    setState(() {
                      _name = jobName;
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }*/
}
