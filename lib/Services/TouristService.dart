import 'dart:convert';
import 'package:flutter_app/models/TouristJoin.dart';
import 'package:flutter_app/models/TouristJoinModel.dart';
import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/models/note_insert.dart';
import 'package:http/http.dart' as http;

class TouristService {
  static const API = 'http://10.0.2.2:8000/apis/v1/Registertourist?format=json';
  static const headers = {"Content-Type":"application/json"};


  Future<APIResponse<List<TouristJoinForListing>>> getEventList() {
    return http.get(Uri.parse(API), headers: headers).then((data) {
      if (data.statusCode ==  200) {
        final jsonData = json.decode(data.body);
        final eventModel = <TouristJoinForListing>[];
        for (var item in jsonData) {
          eventModel.add(TouristJoinForListing.fromJson(item));
        }
        return APIResponse<List<TouristJoinForListing>>(data: eventModel);
      }
      return APIResponse<List<TouristJoinForListing>>(error: true, errorMessage: 'An error occured1');
    })
        .catchError((_) => APIResponse<List<TouristJoinForListing>>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<TouristJoinD_Model>> getEvent(String id) {

    return http.get(Uri.parse('http://10.0.2.2:8000/apis/v1/Registertourist/${id}/'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<TouristJoinD_Model>(data: TouristJoinD_Model.fromJson(jsonData));
      }
      return APIResponse<TouristJoinD_Model>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<TouristJoinD_Model>(error: true, errorMessage: 'An error occured'));
  }




  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http.post(Uri.parse('http://10.0.2.2:8000/apis/v1/Registertourist'), headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }




  Future<APIResponse<bool>> updateNote(String noteID, NoteManipulation item) {
    return http.put(Uri.parse('http://10.0.2.2:8000/apis/v1/Registertourist/${noteID}/'), headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }



  Future<APIResponse<bool>> deleteNote(String noteID) {
    return http.delete(Uri.parse('http://10.0.2.2:8000/apis/v1/Registertourist/${noteID}/'), headers: headers).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

}
