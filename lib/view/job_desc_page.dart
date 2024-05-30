import 'package:flutter/material.dart';
import 'package:flutter_mvvm/res/components/Constants.dart';
import 'package:flutter_mvvm/utils/GradientAppBar.dart';
import 'package:provider/provider.dart';

import '../res/colors/app_colors.dart';
import '../res/components/round_button.dart';
import '../utils/utils.dart';
import '../view_model/jobs_viewmodel.dart';

class JobDescriptionPage extends StatefulWidget {
  const JobDescriptionPage({super.key});

  @override
  State<JobDescriptionPage> createState() => _JobDescriptionPageState();
}

class _JobDescriptionPageState extends State<JobDescriptionPage> {
  final _formKey = GlobalKey<FormState>();
  String _positionName = '';
  String _roles = '';
  String _experience = '';

  @override
  Widget build(BuildContext context) {
    final jobsViewModel = Provider.of<JobsViewModel>(context);
    return Scaffold(
      appBar: GradientAppBar(
        title: AppConstants.jobDescription,
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
            children: [
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: AppColors.borderColor)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: AppColors.borderColor)),
                    labelText: 'Position Name*'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter position name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _positionName = value!;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: AppColors.borderColor)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: AppColors.borderColor)),
                    labelText: 'Roles*'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter roles';
                  }
                  return null;
                },
                onSaved: (value) {
                  _roles = value!;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: AppColors.borderColor)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: AppColors.borderColor)),
                    labelText: 'Experience*'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter experience';
                  }
                  return null;
                },
                onSaved: (value) {
                  _experience = value!;
                },
              ),
              const SizedBox(height: 20.0),
              RoundedButton(
                title: "Generate Job Description",
                onPress: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    Utils.printLogs('Position Name: $_positionName');
                    Utils.printLogs('Roles: $_roles');
                    Utils.printLogs('Experience: $_experience');

                    Map data = {
                      'positionName': _positionName,
                      'roles': _roles,
                      'experience': _experience.toString()
                    };
                    //jobsViewModel.generateJobDescription(data, context);
                    Utils.printLogs('Generate Job desc clicked ->');
                    final result = await jobsViewModel.generateJobDescription(data, context);
                    if (result != null) {
                      Navigator.pop(context, result);
                    }
                    /*setState(() {
                      _positionName = null;
                      _roles = null;
                      _experience = null;
                    });*/
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
