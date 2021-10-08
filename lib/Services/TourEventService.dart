import 'dart:convert';
import 'package:flutter_app/models/TourEvent.dart';
import 'package:flutter_app/models/ToutEventModel.dart';
import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/models/note_insert.dart';
import 'package:http/http.dart' as http;

class TourEventService {
  static const API = 'http://10.0.2.2:8000/apis/v1/AddTourEvent?format=json';
  static const headers = {"Content-Type":"application/json"};


  Future<APIResponse<List<TourEventForListing>>> getEventList() {
    return http.get(Uri.parse(API), headers: headers).then((data) {
      if (data.statusCode ==  200) {
        final jsonData = json.decode(data.body);
        final eventModel = <TourEventForListing>[];
        for (var item in jsonData) {
          eventModel.add(TourEventForListing.fromJson(item));
        }
        return APIResponse<List<TourEventForListing>>(data: eventModel);
      }
      return APIResponse<List<TourEventForListing>>(error: true, errorMessage: 'An error occured1');
    })
        .catchError((_) => APIResponse<List<TourEventForListing>>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<TourEventD_Model>> getEvent(String id) {

    return http.get(Uri.parse('http://10.0.2.2:8000/apis/v1/AddTourEvent/${id}/'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<TourEventD_Model>(data: TourEventD_Model.fromJson(jsonData));
      }
      return APIResponse<TourEventD_Model>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<TourEventD_Model>(error: true, errorMessage: 'An error occured'));
  }




  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http.post(Uri.parse('http://10.0.2.2:8000/apis/v1/AddTourEvent'), headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }




  Future<APIResponse<bool>> updateNote(String noteID, NoteManipulation item) {
    return http.put(Uri.parse('http://10.0.2.2:8000/apis/v1/AddTourEvent/${noteID}/'), headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }



  Future<APIResponse<bool>> deleteNote(String noteID) {
    return http.delete(Uri.parse('http://10.0.2.2:8000/apis/v1/AddTourEvent/${noteID}/'), headers: headers).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

}
