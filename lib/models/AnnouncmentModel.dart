//monde for user data


class AnnouncmentModel{
  int id;
  final String Ann_By;
  final String Ann_Title;
  final String Ann_Dis;
  //DateTime Ann_Date;


//intialization of model data
  AnnouncmentModel ({this.id,this.Ann_By,this.Ann_Title,this.Ann_Dis,
    });


  //method that used to map josn/server data with local data
  factory AnnouncmentModel.fromJson(Map<String,dynamic>json){

    return AnnouncmentModel(
        id: json['id'],
        Ann_By: json['Ann_By'],
        Ann_Title:json['Ann_Title'],
        Ann_Dis: json['Ann_Dis'],
        //Ann_Date:json['Ann_Date']
    );
  }
  dynamic toJson()=>{
    "id":id,
    "Ann_By":Ann_By,
    "Ann_Title":Ann_Title,
    "Ann_Dis":Ann_Dis,
    //"Ann_Date":Ann_Date,
  };

}