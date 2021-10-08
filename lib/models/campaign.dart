import 'dart:convert';

class campaign {

  int id;
  final String camp_by;
  final String camp_title;
  final String camp_dis;
  final String camp_date;


  campaign({this.id,this.camp_by,this.camp_title, this.camp_dis, this.camp_date});
//
  factory campaign.fromJson(Map<String, dynamic> json) {
    return campaign(
        camp_by: json['camp_by'],
        camp_title:json['camp_title'],
        camp_dis: json['camp_dis'],
        camp_date:json['camp_date'],
    );
  }

  dynamic toJson()=>{
    "camp_by":camp_by,
    "camp_title":camp_title,
    "camp_dis":camp_dis,
    "camp_date":camp_date,
  };

}
