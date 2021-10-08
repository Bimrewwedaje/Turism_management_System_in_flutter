import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/hotel.dart';
import '../models/UserModel.dart';
import 'package:http/http.dart' as http;

class HotelProvider with ChangeNotifier{
  HotelProvider(){
    this.fettchTasks();
  }
//creating privet user list
  List<User> _todos=[];

  //making users list to public
  List<User> get todos{
    return[..._todos];
  }

  //method used to add user, async type
  void AddHotel(User todo)async{
    final response=await http.post(Uri.parse('http://10.0.2.2:8000/apis/v1/ListHotel/'),
        headers: {"Content-Type":"application/json"},
        //used into encode users list into json format
        body: json.encode(todo));
    if(response.statusCode==201){
      todo.id=json.decode(response.body)["id"];
      _todos.add(todo);
      notifyListeners();
    }
  }
  void deleteHotel(User todo)async{
    final response=await http.delete(Uri.parse('http://10.0.2.2:8000/apis/v1/ListHotel/${todo.id}/'));
    if(response.statusCode==204){
      _todos.remove(todo);
      notifyListeners();
    }
  }
//used to fetch data from server
  fettchTasks() async{
    final url='http://10.0.2.2:8000/apis/v1/ListHotel/?format=json';
    final response=await http.get(Uri.parse(url));
    var data;
    if(response.statusCode==200){
      data=json.decode(response.body) as List;
      _todos=data.map<User>((json) => HotelD_Model.fromJson(json)).toList();
      notifyListeners();
    }

  }

  void userpro(String username) async{
    final response=await http.delete(Uri.parse('http://10.0.2.2:8000/apis/v1/ListHotel/profile/${username}/'));
    var data;
    if(response.statusCode==200){
      data=json.decode(response.body) as List;
      _todos=data.map<User>((json) => HotelD_Model.fromJson(json)).toList();
      notifyListeners();
    }

  }

}


