import 'package:flutter/material.dart';
import 'package:flutter_mvvm/utils/routes/routes.dart';
import 'package:flutter_mvvm/utils/routes/routes_names.dart';
import 'package:flutter_mvvm/view_model/auth_viewmodel.dart';
import 'package:flutter_mvvm/view_model/candidate_viewmodel.dart';
import 'package:flutter_mvvm/view_model/createsession_viewmodel.dart';
import 'package:flutter_mvvm/view_model/jobs_viewmodel.dart';
import 'package:flutter_mvvm/view_model/preScreeningViewModel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => JobsViewModel()),
        ChangeNotifierProvider(create: (_) => CandidateViewModel()),
        ChangeNotifierProvider(create: (_) => CreateSessionViewModel()),
        ChangeNotifierProvider(create: (_) => PreScreeningViewModel()),
      ],
      child: MaterialApp(
        title: 'Admin',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RoutesNames.candidateList,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
/*

class FormExample extends StatefulWidget {
  const FormExample({super.key, required this.title});
  final String title;

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _location = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create New Job',
          style: TextStyle(
            fontFamily: 'sourcesanspro_bold',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
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
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              */
/* GestureDetector(
                onTap: () {
                  _showJobNameDropdown(context);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Job Title*',
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    controller: TextEditingController(text: _name),
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
                ),
              ),*/ /*

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
              TextFormField(
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  */
/* ElevatedButton(
                    onPressed: () {
                      // Navigate to previous page or perform other action
                    },
                    child: const Text('Previous'),
                  ),*/ /*

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        // Do something with the form data, like submit it
                        print('Name: $_name');
                        print('Location: $_location');
                        print('Description: $_description');
                      }
                    },
                    child: Text('Submit'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CandidatePage()),
                        );
                      }
                    },
                    child: Text('Next'),
                  ),
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

*/
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
  }*/ /*

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

class NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow only digits
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    String _filePath = '';
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
                  FilePickerResult? result =
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
                      print('Selected file path: $filePath');
                    } else {
                      print('Failed to get file path');
                    }
                  } else {
                    // User canceled the file picker
                    print('File picker canceled');
                  }
                },
                child: const Text('Upload Resume'),
              ),
              const SizedBox(height: 20.0),
              _filePath != null
                  ? Text(
                      'Selected File: $_filePath',
                      style: const TextStyle(fontSize: 16.0),
                    )
                  : Container(),
              ElevatedButton(
                onPressed: () {
                  if (_candidateformKey.currentState?.validate() ?? false) {
                    _candidateformKey.currentState?.save();
                    // Do something with the form data, like submit it
                    print('Name: $_name');
                    print('JobName: $_jobName');
                    print('Email: $_email');
                    print('Contact: $_contact');
                  }
                },
                child: const Text('Submit'),
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
}
*/
