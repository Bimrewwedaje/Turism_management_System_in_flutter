import 'dart:convert';

import 'package:flutter_app/models/HotelModel.dart';
import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/models/hotel.dart';
import 'package:flutter_app/models/note_insert.dart';
import 'package:http/http.dart' as http;

class HotelService {
  static const API = 'http://10.0.2.2:8000/apis/v1/ListHotel?format=json';
  static const headers = {"Content-Type":"application/json"};


  Future<APIResponse<List<HotelForListing>>> getHotelList() {
    return http.get(Uri.parse(API), headers: headers).then((data) {
      if (data.statusCode ==  200) {
        final jsonData = json.decode(data.body);
        final hotelModel = <HotelForListing>[];
        for (var item in jsonData) {
          hotelModel.add(HotelForListing.fromJson(item));
        }
        return APIResponse<List<HotelForListing>>(data: hotelModel);
      }
      return APIResponse<List<HotelForListing>>(error: true, errorMessage: 'An error occured1');
    })
     .catchError((_) => APIResponse<List<HotelForListing>>(error: true, errorMessage: 'An error occured'));
  }




  Future<APIResponse<HotelD_Model>> getHotel(String id) {

    return http.get(Uri.parse('http://10.0.2.2:8000/apis/v1/ListHotel/${id}/'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<HotelD_Model>(data: HotelD_Model.fromJson(jsonData));
      }
      return APIResponse<HotelD_Model>(error: true, errorMessage: 'An error occured');
    });
        //.catchError((_) => APIResponse<HotelD_Model>(error: true, errorMessage: 'An error occured'));
  }




  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http.post(Uri.parse('http://10.0.2.2:8000/apis/v1/ListHotel'), headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }




  Future<APIResponse<bool>> updateNote(String noteID, NoteManipulation item) {
    return http.put(Uri.parse('http://10.0.2.2:8000/apis/v1/ListHotel/${noteID}/'), headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }



  Future<APIResponse<bool>> deleteNote(String noteID) {
    return http.delete(Uri.parse('http://10.0.2.2:8000/apis/v1/ListHotel/${noteID}/'), headers: headers).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    });
        //.catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

}
