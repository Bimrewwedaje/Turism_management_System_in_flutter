import 'dart:convert';

import 'package:flutter_app/models/GasStation.dart';
import 'package:flutter_app/models/GasStationModel.dart';
import 'package:flutter_app/models/HotelModel.dart';
import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/models/hotel.dart';
import 'package:flutter_app/models/note.dart';
import 'package:flutter_app/models/note_for_listing.dart';
import 'package:flutter_app/models/note_insert.dart';
import 'package:http/http.dart' as http;

class GasStationService {
  static const API = 'http://10.0.2.2:8000/apis/v1/ListGasStation?format=json';
  static const headers = {"Content-Type":"application/json"};


  Future<APIResponse<List<GasStationForListing>>> getGasStationList() {
    return http.get(Uri.parse(API), headers: headers).then((data) {
      if (data.statusCode ==  200) {
        final jsonData = json.decode(data.body);
        final gasStationModel = <GasStationForListing>[];
        for (var item in jsonData) {
          gasStationModel.add(GasStationForListing.fromJson(item));
        }
        return APIResponse<List<GasStationForListing>>(data: gasStationModel);
      }
      return APIResponse<List<GasStationForListing>>(error: true, errorMessage: 'An error occured1');
    })
        .catchError((_) => APIResponse<List<GasStationForListing>>(error: true, errorMessage: 'An error occured'));
  }




  Future<APIResponse<GasStationD_Model>> getGasStation(String id) {

    return http.get(Uri.parse('http://10.0.2.2:8000/apis/v1/ListGasStation/${id}/'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<GasStationD_Model>(data: GasStationD_Model.fromJson(jsonData));
      }
      return APIResponse<GasStationD_Model>(error: true, errorMessage: 'An error occured');
    })
    .catchError((_) => APIResponse<GasStationD_Model>(error: true, errorMessage: 'An error occured'));
  }




  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http.post(Uri.parse('http://10.0.2.2:8000/apis/v1/ListGasStation'), headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }




  Future<APIResponse<bool>> updateNote(String noteID, NoteManipulation item) {
    return http.put(Uri.parse('http://10.0.2.2:8000/apis/v1/ListGasStation/${noteID}/'), headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }



  Future<APIResponse<bool>> deleteNote(String noteID) {
    return http.delete(Uri.parse('http://10.0.2.2:8000/apis/v1/ListGasStation/${noteID}/'), headers: headers).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    });
    //.catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

}
