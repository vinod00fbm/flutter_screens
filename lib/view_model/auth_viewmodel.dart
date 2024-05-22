import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm/repository/auth_repository.dart';
import 'package:flutter_mvvm/utils/routes/routes_names.dart';
import 'package:flutter_mvvm/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  Future<void> loginApi(dynamic data, BuildContext context) async {
    _myRepo.loginApi(data).then((value) {
      if (kDebugMode) {
        print(value.toString());
        Utils.showFlushBarErrorMessage(value.toString(), context);
        Navigator.pushNamed(context, RoutesNames.home);
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
