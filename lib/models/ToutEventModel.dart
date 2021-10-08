//monde for user data
class TourEventForListing{
  String id;
  final String Event_name;
  final String Event_type;
  final String Event_location;
  final String Event_Date;
  final String Event_Detail;
  final String Event_Price;
  final String Image;


  TourEventForListing({this.id,this.Event_name, this.Event_type, this.Event_location, this.Event_Date,this.Event_Detail,this.Event_Price, this.Image});


  factory TourEventForListing.fromJson(Map<String,dynamic>json){

    return TourEventForListing(
      id: json['id'].toString(),
      Event_name: json['eventName'],
      Event_type:json['eventType'],
      Event_location: json['eventLoc'],
      Event_Date:json['eventDate'],
      Event_Detail: json['eventDetail'],
      Event_Price:json['eventPrice'],
      Image:json['picture'].toString(),
    );
  }
  dynamic toJson()=>{
    "id":id,
    "eventName":Event_name,
    "eventType":Event_type,
    "eventLoc":Event_location,
    "eventDate":Event_Date,
    "eventDetail":Event_Detail,
    "eventPrice": Event_Price,
    "picture":Image,
  };

}
