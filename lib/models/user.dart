import 'dart:convert';

class User {

  int id;
  final String username;
  final String User_Fname;
  final String User_Lname;
  final String User_Gender;
  final String User_Email;
  final String User_Phone;
  final String User_Role;


  User({this.id, this.username, this.User_Fname, this.User_Lname, this.User_Gender, this.User_Email,this.User_Phone, this.User_Role});
//
  factory User.fromJson(Map<String, dynamic> item) {
    return User(
    id: item['id'],
    username: item['username'],
    User_Fname:item['user_fname'],
    User_Lname: item['user_lname'],
    User_Gender:item['user_gender'],
    User_Email: item['user_email'],
    User_Phone:item['user_phone'],
    User_Role: item['user_role'],
    );
  }
  }
