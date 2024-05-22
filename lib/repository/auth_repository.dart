import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm/data/network/BaseApiService.dart';
import 'package:flutter_mvvm/data/network/NetworkApiService.dart';
import 'package:flutter_mvvm/res/components/app_url.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrls.loginEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrls.registerApiEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
