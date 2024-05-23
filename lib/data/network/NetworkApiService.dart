import 'dart:convert';
import 'dart:io';

import 'package:flutter_mvvm/data/exceptions.dart';
import 'package:flutter_mvvm/data/network/BaseApiService.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkApiServices extends BaseApiServices {
  /// Get Api
  @override
  Future getGetApiResponse(String url) async {
    dynamic jsonResponse;
    try {
      final response =
      await http.get(Uri.parse(url)).timeout(const Duration(seconds: 60));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
    return jsonResponse;
  }

  ///  Post Api
  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic jsonResponse;
    final msg = jsonEncode(data);
    try {
      Response response = await post(Uri.parse(url),
          body: msg, headers: {"Content-Type": "application/json"})
          .timeout(const Duration(seconds: 60));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
    return jsonResponse;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while communicating with server' +
                'with status code:' +
                response.statusCode.toString());
    }
  }

  @override
  Future getGetApiResponseQuery(String url, data) async {
    dynamic jsonResponse;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
    return jsonResponse;
  }
}
