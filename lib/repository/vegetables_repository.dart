import 'dart:async';
import 'dart:convert';

import 'package:bella_olonje/model/response.dart';
import 'package:bella_olonje/network/api_provider.dart';

class VegetableRepository {
  List<VegetableResponse> veggieResponseFromJson(String str) =>
      List<VegetableResponse>.from(
          json.decode(str).map((x) => VegetableResponse.fromJson(x)));

  Future<List<VegetableResponse>> fetchVegetables(String category) async {
    ApiProvider _provider = ApiProvider();
    final response =
        await _provider.post("get_practical_data?practical_type=" + category);
    return veggieResponseFromJson(response);
  }
}
