//monde for user data
class TouristJoinForListing{
  String id;
  final String First_name;
  final String Father_Name;
  final String Event_name;
  final String Dob;
  final String Contact;
  final String Fee;


  TouristJoinForListing({this.id,this.First_name, this.Father_Name, this.Event_name, this.Dob,this.Contact,this.Fee});


  factory TouristJoinForListing.fromJson(Map<String,dynamic>json){

    return TouristJoinForListing(
      id: json['id'].toString(),
      First_name: json['First_name'],
      Father_Name:json['Father_Name'],
      Event_name: json['Event_name'],
      Dob:json['Dob'],
      Contact: json['Contact'],
      Fee:json['Fee'],
      //Image:json['picture'].toString(),
    );
  }
  dynamic toJson()=>{
    "id":id,
    "First_name":First_name,
    "Father_Name":Father_Name,
    "Event_name":Event_name,
    "Dob":Dob,
    "Contact":Contact,
    "Fee": Fee,
   // "picture":Image,
  };

}
