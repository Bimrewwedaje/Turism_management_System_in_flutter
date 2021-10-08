//import 'dart:convert';

class EventD_Model {

  String id;
  final String Event_name;
  final String Event_type;
  final String Event_location;
  final String Event_detail;
  final String Image;


  EventD_Model({this.id,this.Event_name, this.Event_type, this.Event_location, this.Event_detail,this.Image});
//
  factory EventD_Model.fromJson(Map<String, dynamic> item) {
    return EventD_Model(
      id: item['id'].toString(),
      Event_name: item['event_name'],
      Event_type:item['event_type'],
      Event_location: item['event_location'],
      Event_detail:item['event_detail'],
      Image:item['picture'].toString(),
    );
  }
}
