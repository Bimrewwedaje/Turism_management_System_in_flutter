//import 'dart:convert';


class GasStationD_Model {

  String id;
  final String GasStation_name;
  final String GasStation_location;
  final String GasStation_detail;
  final String Image;


  GasStationD_Model({this.id,this.GasStation_name, this.GasStation_location, this.GasStation_detail, this.Image});

  factory GasStationD_Model.fromJson(Map<String, dynamic> item) {
    return GasStationD_Model(
      id: item['id'].toString(),
      GasStation_name: item['gas_name'],
      GasStation_location: item['gas_location'],
      GasStation_detail:item['gas_detail'],
      Image:item['picture'].toString(),
    );
  }
}

