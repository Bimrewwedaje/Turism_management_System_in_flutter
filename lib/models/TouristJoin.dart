//import 'dart:convert';

class TouristJoinD_Model {

  String id;
  final String First_name;
  final String Father_Name;
  final String Event_name;
  final String Contact;
  final String Dob;
  final String Fee;


  TouristJoinD_Model({this.id,this.First_name, this.Father_Name, this.Event_name, this.Dob, this.Contact,this.Fee});
//
  factory TouristJoinD_Model.fromJson(Map<String, dynamic> item) {
    return TouristJoinD_Model(
      id: item['id'].toString(),
      First_name: item['First_name'],
      Father_Name:item['Father_Name'],
      Event_name: item['Event_name'],
      Dob: item['Dob'],
      Contact:item['Contact'],
      Fee:item['Fee'],
    );
  }
}
