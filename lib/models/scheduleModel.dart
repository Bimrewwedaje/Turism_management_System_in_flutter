//monde for user data


class ScheduleModel{
  int id;
  final String action;
  final String Start_date;
  final String End_date;
  final String Scheduled_date;
  //DateTime Ann_Date;


//intialization of model data
  ScheduleModel ({this.id,this.action,this.Start_date,this.End_date,this.Scheduled_date});


  //method that used to map josn/server data with local data
  factory ScheduleModel.fromJson(Map<String,dynamic>json){

    return ScheduleModel(
      id: json['id'],
      action: json['action'],
      Start_date:json['Start_date'],
      End_date: json['End_date'],
      Scheduled_date: json['Scheduled_date'],
      //Ann_Date:json['Ann_Date']
    );
  }
}