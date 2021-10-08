import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/AnnouncmentModel.dart';
import 'package:http/http.dart' as http;
class AnnouncmentProvider with ChangeNotifier{
  AnnouncmentProvider(){
    this.fettchTasks();
  }
//creating privet user list
  List<AnnouncmentModel> _todos=[];

  //making users list to public
  List<AnnouncmentModel> get todos{
    return[..._todos];
  }
  //method used to add user, async type
  void AddAnnouncement(AnnouncmentModel Announce)async{
    final response=await http.post(Uri.parse('http://10.0.2.2:8000/apis/v1/Announcements'),
        headers: {"Content-Type":"application/json"},
        //used into encode users list into json format
        body: json.encode(Announce));
    if(response.statusCode==201){
      Announce.id=json.decode(response.body)["id"];
      _todos.add(Announce);
      notifyListeners();
    }
  }
  void deleteAnnouncment(AnnouncmentModel todo)async{
    final response=await http.delete(Uri.parse('http://10.0.2.2:8000/apis/v1/Announcement/${todo.id}/'));
    if(response.statusCode==204){
      _todos.remove(todo);
      notifyListeners();
    }
  }
//used to fetch data from server
  fettchTasks() async{
    final url='http://10.0.2.2:8000/apis/v1/Announcements?format=json';
    final response=await http.get(Uri.parse(url));
    var data;
    if(response.statusCode==200){
      data=json.decode(response.body) as List;
      _todos=data.map<AnnouncmentModel>((json) => AnnouncmentModel.fromJson(json)).toList();
      notifyListeners();
    }
  }
}


