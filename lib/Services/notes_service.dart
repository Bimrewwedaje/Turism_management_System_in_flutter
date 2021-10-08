import 'dart:convert';

import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/models/note.dart';
import 'package:flutter_app/models/note_for_listing.dart';
import 'package:flutter_app/models/note_insert.dart';
import 'package:http/http.dart' as http;

class NotesService {
  static const API = 'http://10.0.2.2:8000/apis/v1/ListSite?format=json';
  static const headers = {"Content-Type":"application/json"};




  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(Uri.parse(API), headers: headers).then((data) {
      if (data.statusCode ==  200) {
        final jsonData = json.decode(data.body);
        final Site_model = <NoteForListing>[];
          for (var item in jsonData) {
            Site_model.add(NoteForListing.fromJson(item));
          }
        return APIResponse<List<NoteForListing>>(data: Site_model);
      }
      return APIResponse<List<NoteForListing>>(error: true, errorMessage: 'An error occured1');
    });
       // .catchError((_) => APIResponse<List<NoteForListing>>(error: true, errorMessage: 'An error occured'));
  }




  Future<APIResponse<SiteD_model>> getNote(String id) {

    return http.get(Uri.parse('http://10.0.2.2:8000/apis/v1/ListSite/${id}/'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<SiteD_model>(data: SiteD_model.fromJson(jsonData));
      }
      return APIResponse<SiteD_model>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<SiteD_model>(error: true, errorMessage: 'An error occured'));
  }




  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http.post(Uri.parse('http://10.0.2.2:8000/apis/v1/ListSite'), headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }




  Future<APIResponse<bool>> updateNote(String noteID, NoteManipulation item) {
    return http.put(Uri.parse('http://10.0.2.2:8000/apis/v1/ListSite/${noteID}/'), headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }



  Future<APIResponse<bool>> deleteNote(String noteID) {
    return http.delete(Uri.parse('http://10.0.2.2:8000/apis/v1/ListSite/${noteID}/'), headers: headers).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

}
