import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bella_olonje/model/response.dart';
import 'package:http/http.dart' as http;

import 'custom_exception.dart';

class ApiProvider {
  final String _baseUrl = "http://php10.shaligraminfotech.com/Demo/public/api/";

  Future<dynamic> post(String url) async {
    var responseJson;
    try {
      final response = await http.post(_baseUrl + url);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        print(responseJson);
       /* List<VegetableResponse> responses =
        responseJson.map((j) => VegetableResponse.fromJson(j)).toList();*/
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode :'
            ' ${response.statusCode}');
    }
  }
}
