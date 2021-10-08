import 'dart:convert';

import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/models/note.dart';
import 'package:flutter_app/models/note_for_listing.dart';
import 'package:flutter_app/models/note_insert.dart';
import 'package:flutter_app/models/user.dart';
import 'package:http/http.dart' as http;

class userService {
  static const API = 'http://10.0.2.2:8000/apis/v1/notes';
  static const headers = {"Content-Type":"application/json"};


  Future<APIResponse<User>> getUser(String username) {

    return http.get(Uri.parse('http://10.0.2.2:8000/apis/v1/profile/${username}/'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<User>(data: User.fromJson(jsonData));
      }
      return APIResponse<User>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<User>(error: true, errorMessage: 'An error occured'));
  }




  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http.post(Uri.parse('http://10.0.2.2:8000/apis/v1/notes'), headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }


  Future<APIResponse<bool>> updateNote(String noteID, NoteManipulation item) {
    return http.put(Uri.parse('http://10.0.2.2:8000/apis/v1/notes/${noteID}/'), headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }



  Future<APIResponse<bool>> deleteNote(String noteID) {
    return http.delete(Uri.parse('http://10.0.2.2:8000/apis/v1/notes/${noteID}/'), headers: headers).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

}
