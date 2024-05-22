import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/res/components/round_button.dart';
import 'package:flutter_mvvm/view_model/createsession_viewmodel.dart';
import 'package:provider/provider.dart';

class CreateSession extends StatefulWidget {
  final int candidateId;

  const CreateSession({required this.candidateId, Key? key}) : super(key: key);

  @override
  State<CreateSession> createState() => _CreateSessionState();
}

class _CreateSessionState extends State<CreateSession> {
  final _sessionformKey = GlobalKey<FormState>();
  final String _candidateId = '';
  String _duration = '';
  String _numberOfQuestions = '';
  String _date = '';
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final createSessionViewModel = Provider.of<CreateSessionViewModel>(context);
    print('CandidateId: ${widget.candidateId}');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Session',
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
          key: _sessionformKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Duration*'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter duration';
                  }
                  return null;
                },
                onSaved: (value) {
                  _duration = value!;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Number of Questions*'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter number of questions';
                  }
                  return null;
                },
                onSaved: (value) {
                  _numberOfQuestions = value!;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Select Date*'),
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter date';
                  }
                  return null;
                },
                onSaved: (value) {
                  _date = value!;
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              RoundedButton(
                title: 'Create Session',
                onPress: () {
                  if (_sessionformKey.currentState?.validate() ?? false) {
                    _sessionformKey.currentState?.save();

                    Map<String, String> data = {
                      'candidateId': widget.candidateId.toString(),
                      'duration': _duration,
                      'numberOfQuestions': _numberOfQuestions,
                      'date': _selectedDate!.millisecondsSinceEpoch.toString()
                    };
                    print('CreateSession ${ 'Duration: '+ _duration +' No of questions: '+ _numberOfQuestions + ' Selected Date: '+ _selectedDate!.millisecondsSinceEpoch.toString() }');
                    createSessionViewModel.createSessionWithQueryParam(data, context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
        _date = _selectedDate!.millisecondsSinceEpoch.toString();
        print('Selected Date: ${_selectedDate}');
        print('Selected Date in millis: ${_date}');
      });
    }
  }
}
