//monde for user data
class HotelForListing{
  String id;
  final String Hotel_name;
  final String Hotel_type;
  final String Hotel_location;
  final String Hotel_detail;
  final String Hotel_price;
  final String Image;

//intialization of model data
  HotelForListing({this.id,this.Hotel_name,this.Hotel_type,this.Hotel_location,
    this.Hotel_detail,this.Hotel_price,this.Image,});

  //method that used to map josn/server data with local data
  factory HotelForListing.fromJson(Map<String,dynamic>json){

    return HotelForListing(
      id: json['id'].toString(),
      Hotel_name: json['hotel_name'],
      Hotel_type:json['hotel_type'],
      Hotel_location: json['hotel_location'],
      Hotel_detail:json['hotel_detail'],
      Hotel_price: json['hotel_price'].toString(),
      Image:json['picture'].toString(),
    );
  }
  dynamic toJson()=>{
    "id":id,
    "hotel_name":Hotel_name,
    "hotel_type":Hotel_type,
    "hotel_location":Hotel_location,
    "hotel_detail":Hotel_detail,
    "hotel_price":Hotel_price,
    "picture":Image,
  };

}
