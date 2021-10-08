//import 'dart:convert';

class HotelD_Model {

  String id;
  final String Hotel_name;
  final String Hotel_type;
  final String Hotel_location;
  final String Hotel_detail;
  final String Hotel_price;
  final String Image;


  HotelD_Model({this.id,this.Hotel_name, this.Hotel_type, this.Hotel_location, this.Hotel_detail, this.Hotel_price,this.Image});
//
  factory HotelD_Model.fromJson(Map<String, dynamic> item) {
    return HotelD_Model(
      id: item['id'].toString(),
      Hotel_name: item['hotel_name'],
      Hotel_type:item['hotel_type'],
      Hotel_location: item['hotel_location'],
      Hotel_detail:item['hotel_detail'],
      Hotel_price: item['hotel_price'].toString(),
      Image:item['picture'].toString(),
    );
  }
}
