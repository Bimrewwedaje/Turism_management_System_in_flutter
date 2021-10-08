//import 'dart:convert';

class TourEventD_Model {

  String id;
  final String Event_name;
  final String Event_type;
  final String Event_location;
  final String Event_Date;
  final String Event_Detail;
  final String Event_Price;
  final String Image;

  TourEventD_Model({this.id,this.Event_name, this.Event_type, this.Event_location, this.Event_Date,this.Event_Detail,this.Event_Price, this.Image});
//
  factory TourEventD_Model.fromJson(Map<String, dynamic> item) {
    return TourEventD_Model(
      id: item['id'].toString(),
      Event_name: item['eventName'],
      Event_type:item['eventType'],
      Event_location: item['eventLoc'],
      Event_Date: item['eventDate'],
      Event_Detail:item['eventDetail'],
      Event_Price:item['eventPrice'],
      Image:item['picture'].toString(),
    );
  }
}
