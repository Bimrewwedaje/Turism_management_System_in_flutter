//monde for user data
class EventForListing{
  String id;
  final String Event_name;
  final String Event_type;
  final String Event_location;
  final String Event_detail;
  final String Image;

//intialization of model data
  EventForListing({this.id,this.Event_name, this.Event_type, this.Event_location, this.Event_detail,this.Image});


  factory EventForListing.fromJson(Map<String,dynamic>json){

    return EventForListing(
      id: json['id'].toString(),
      Event_name: json['event_name'],
      Event_type:json['event_type'],
      Event_location: json['event_location'],
      Event_detail:json['event_detail'],
      Image:json['picture'].toString(),
    );
  }
  dynamic toJson()=>{
    "id":id,
    "event_name":Event_name,
    "event_type":Event_type,
    "event_location":Event_location,
    "event_detail":Event_detail,
    "picture":Image,
  };

}
