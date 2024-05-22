import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvvm/res/components/round_button.dart';
import 'package:flutter_mvvm/view_model/candidate_viewmodel.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class CandidatePage extends StatefulWidget {
  const CandidatePage({super.key});

  @override
  _CandidatePageState createState() => _CandidatePageState();
}

class _CandidatePageState extends State<CandidatePage> {
  final _candidateformKey = GlobalKey<FormState>();
  String _name = '';
  String _contact = '';
  String _email = '';
  String _jobName = '';

  String? selectedFilePath;
  bool isLoading = false;
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedFile;
  File? fileToDisplay;

  Future<void> pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });

      result = await FilePicker.platform
          .pickFiles(type: FileType.any, allowMultiple: false);
      if (result != null) {
        _fileName = result!.files.first.name;
        pickedFile = result!.files.first;
        selectedFilePath = result!.files.first.path;
        // fileToDisplay = File(pickedFile!.path.toString());
        print('File Name $_fileName');
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String _filePath = '';
    final candidateViewModel = Provider.of<CandidateViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Candidate Page',
          style: TextStyle(
            fontFamily: 'sourcesanspro_bold',
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 100.0),
        child: Form(
          key: _candidateformKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Candidate Name*'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contact Number*'),
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter valid contact number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _contact = value!;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter valid Email Id';
                  }
                  if (!_isValidEmail(value!)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  _showJobNameDropdown(context);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Job Name',
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    controller: TextEditingController(text: _jobName),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please Select Job from Drop down menu';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _jobName = value!;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              TextButton(
                onPressed: () async {
                  // Open file picker
                  /* FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf'],
                  );

                  // Check if a file was selected
                  if (result != null) {
                    // Get the file path
                    String? filePath = result.files.single.path;
                    if (filePath != null) {
                      // Do something with the selected file, like upload it
                      _filePath = filePath;
                      Text('Selected file path: $filePath');
                      print('Selected file path: $filePath');
                    } else {
                      print('Failed to get file path');
                    }
                  } else {
                    // User canceled the file picker
                    print('File picker canceled');
                  }*/

                  pickFile();

                  if (pickedFile != null) {
                    SizedBox(
                      height: 300,
                      width: 400,
                      child: Text('picked file: $pickedFile'),
                    );
                  }
                },
                child: const Text('Upload Resume'),
              ),
              const SizedBox(height: 20.0),
              _fileName != null
                  ? Text(
                      'Selected File: $_fileName',
                      style: const TextStyle(fontSize: 16.0),
                    )
                  : Container(),
              RoundedButton(
                title: "Submit Candidate",
                onPress: () {
                  if (_candidateformKey.currentState?.validate() ?? false) {
                    _candidateformKey.currentState?.save();
                    // Do something with the form data, like submit it
                    print('fullName: $_name');
                    print('JobName: $_jobName');
                    print('Email: $_email');
                    print('Contact: $_contact');
                    Map<String, String> data = {
                      'jobId': '1716284582791',
                      'fullName': _name,
                      'email': _email
                    };
                    candidateViewModel.createCandidate(
                        data, context, pickedFile);
                    Utils.showFlushBarSuccessMessage(
                        'Candidate created successfully!', context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    // Regular expression for validating email addresses
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  final List<String> _jobNames = [
    'Client Partner',
    'UI Developer',
    'QA Analyst',
    'Application Engineer',
    'Treasury App Support',
    'Dot Net Lead',
  ];

  void _showJobNameDropdown(BuildContext context) {
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
                      _jobName = jobName;
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

/*  Future<void> sendFileToApi() async {
    if (selectedFilePath == null) {
      // Handle case where no file is selected
      print('Please select a file');
      return;
    }

    final candidateName = _candidateNameController.text;
    if (candidateName.isEmpty) {
      // Handle case where candidate name is empty
      print('Please enter candidate name');
      return;


    try {
      var http;
      final file = File(selectedFilePath!);
      final request = http.MultipartRequest('POST', Uri.parse('your_api_url'));
      request.fields['candidate_name'] = candidateName;

      request.files.add(MultipartFile.fromPath('file', selectedFilePath!));
      final response = await request.send();

      if (response.statusCode == 200) {
        // Handle successful upload
        print('File uploaded successfully!');
        // Clear UI for next submission (optional)
        setState(() {
          selectedFilePath = null;
          _candidateNameController.text = '';
        });
      } else {
        // Handle upload error
        print('Error uploading file: ${response.statusCode}');
      }
    } catch (error) {
      // Handle other errors
      print('Error sending file: $error');
    }
  }
*/
}
