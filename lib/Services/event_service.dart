import 'dart:convert';

import 'package:flutter_app/models/EventModel.dart';
import 'package:flutter_app/models/HotelModel.dart';
import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/models/event.dart';
import 'package:flutter_app/models/hotel.dart';
import 'package:flutter_app/models/note.dart';
import 'package:flutter_app/models/note_for_listing.dart';
import 'package:flutter_app/models/note_insert.dart';
import 'package:http/http.dart' as http;

class EventService {
  static const API = 'http://10.0.2.2:8000/apis/v1/ListEvent?format=json';
  static const headers = {"Content-Type":"application/json"};


  Future<APIResponse<List<EventForListing>>> getEventList() {
    return http.get(Uri.parse(API), headers: headers).then((data) {
      if (data.statusCode ==  200) {
        final jsonData = json.decode(data.body);
        final eventModel = <EventForListing>[];
        for (var item in jsonData) {
          eventModel.add(EventForListing.fromJson(item));
        }
        return APIResponse<List<EventForListing>>(data: eventModel);
      }
      return APIResponse<List<EventForListing>>(error: true, errorMessage: 'An error occured1');
    })
        .catchError((_) => APIResponse<List<EventForListing>>(error: true, errorMessage: 'An error occured'));
  }




  Future<APIResponse<EventD_Model>> getEvent(String id) {

    return http.get(Uri.parse('http://10.0.2.2:8000/apis/v1/ListEvent/${id}/'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<EventD_Model>(data: EventD_Model.fromJson(jsonData));
      }
      return APIResponse<EventD_Model>(error: true, errorMessage: 'An error occured');
    })
    .catchError((_) => APIResponse<HotelD_Model>(error: true, errorMessage: 'An error occured'));
  }




  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http.post(Uri.parse('http://10.0.2.2:8000/apis/v1/ListEvent'), headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }




  Future<APIResponse<bool>> updateNote(String noteID, NoteManipulation item) {
    return http.put(Uri.parse('http://10.0.2.2:8000/apis/v1/ListEvent/${noteID}/'), headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }



  Future<APIResponse<bool>> deleteNote(String noteID) {
    return http.delete(Uri.parse('http://10.0.2.2:8000/apis/v1/ListEvent/${noteID}/'), headers: headers).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
    .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

}
