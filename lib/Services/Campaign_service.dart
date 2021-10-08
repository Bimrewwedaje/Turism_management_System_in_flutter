import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/campaign.dart';
import '../models/AnnouncmentModel.dart';
import 'package:http/http.dart' as http;

class CampaignProvider with ChangeNotifier{
  CampaignProvider(){
    this.fettchTasks();
  }
//creating privet user list
  List<campaign> _todos=[];

  //making users list to public
  List<campaign> get todos{
    return[..._todos];
  }

//used to fetch data from server
  fettchTasks() async{
    final url='http://10.0.2.2:8000/apis/v1/campaigns?format=json';
    final response=await http.get(Uri.parse(url));
    var data;
    if(response.statusCode==200){
      data=json.decode(response.body) as List;
      _todos=data.map<campaign>((json) => campaign.fromJson(json)).toList();
      notifyListeners();
    }

  }
}


