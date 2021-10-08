//monde for user data
class GasStationForListing{
  String id;
  final String GasStation_name;
  final String GasStation_location;
  final String GasStation_detail;
  final String Image;

//intialization of model data
  GasStationForListing({this.id,this.GasStation_name, this.GasStation_location,
    this.GasStation_detail,this.Image,});

  //method that used to map josn/server data with local data
  factory GasStationForListing.fromJson(Map<String,dynamic>json){

    return GasStationForListing(
      id: json['id'].toString(),//gas_name gas_location gas_detail picture
      GasStation_name: json['gas_name'],
      GasStation_location: json['gas_location'],
      GasStation_detail:json['gas_detail'],
      Image:json['picture'].toString(),
    );
  }
  dynamic toJson()=>{
    "id":id,
    "gas_name":GasStation_name,
    "gas_location":GasStation_location,
    "gas_detail":GasStation_detail,
    "picture":Image,
  };

}
