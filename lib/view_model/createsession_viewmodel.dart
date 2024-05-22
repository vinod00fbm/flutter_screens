import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../repository/create_session_repository.dart';
import '../utils/utils.dart';

class CreateSessionViewModel with ChangeNotifier {
  final _myRepo = CreateSessionRepository();

  Future<void> createSessionWithQueryParam(
      Map<String, String> data, BuildContext context) async {
    final uri = Uri.https('select-sense-apis.azurewebsites.net', 'session/createSession/', data);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Handle successful response
        print('Session created successfully');
      } else {
        // Handle error response
        print('Failed to create session: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error: $e');
    }
  }

  Future<void> createSession(dynamic data, BuildContext context) async {
    _myRepo.createSession(data).then((value) {
      if (kDebugMode) {
        print(value.toString());
        Utils.showFlushBarErrorMessage(value.toString(), context);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('Inside On error');
        Utils.showFlushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }
}
