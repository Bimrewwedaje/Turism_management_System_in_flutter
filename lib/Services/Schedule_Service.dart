import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/scheduleModel.dart';
import 'package:http/http.dart' as http;

class ScheduleProvider with ChangeNotifier{
  ScheduleProvider(){
    this.fettchTasks();
  }
//creating privet user list
  List<ScheduleModel> _todos=[];
  //making users list to public
  List<ScheduleModel> get todos{
    return[..._todos];
  }
  fettchTasks() async{
    final url='http://10.0.2.2:8000/apis/v1/Schedules?format=json';
    final response=await http.get(Uri.parse(url));
    var data;
    if(response.statusCode==200){
      data=json.decode(response.body) as List;
      _todos=data.map<ScheduleModel>((json) => ScheduleModel.fromJson(json)).toList();
      notifyListeners();
    }
  }
}


