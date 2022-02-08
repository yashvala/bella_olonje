import 'dart:async';

import 'package:bella_olonje/model/response.dart';
import 'package:bella_olonje/network/api_response.dart';
import 'package:bella_olonje/repository/vegetables_repository.dart';

class VegetableBloc {
  VegetableRepository _veggieRepository;
  StreamController _listController;
  bool _isStreaming;

  StreamSink<ApiResponse<VegetableResponse>> get veggieDataSink =>
      _listController.sink;

  Stream<ApiResponse<VegetableResponse>> get veggieDataStream =>
      _listController.stream;

  VegetableBloc(String category) {
    _listController = StreamController<ApiResponse<VegetableResponse>>();
    _veggieRepository = VegetableRepository();
    _isStreaming = true;
    fetchVegetables(category);
  }

  fetchVegetables(String category) async {
    veggieDataSink.add(ApiResponse.loading('Getting you Vegetables !'));
    try {
      VegetableResponse response =
          (await _veggieRepository.fetchVegetables(category)) as VegetableResponse;
      if (_isStreaming) veggieDataSink.add(ApiResponse.completed(response));
    } catch (e) {
      if (_isStreaming) veggieDataSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _isStreaming = false;
    _listController?.close();
  }
}
