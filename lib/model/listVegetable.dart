import 'package:bella_olonje/model/response.dart';

class VegetableResponseList  {

  final List<VegetableResponse> vegetables;


  VegetableResponseList({this.vegetables});

    Map<String, dynamic> toMap() {
    return {
      'vegetables': vegetables
    };
  }


    factory VegetableResponseList.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return VegetableResponseList(
        vegetables: [VegetableResponse.fromJson(map)]);
  }



    factory VegetableResponseList.addedfromMap(List<VegetableResponse> ld) {
    if (ld == null) return null;
    return VegetableResponseList(
        vegetables: ld);
  }

}