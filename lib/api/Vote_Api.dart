import 'dart:convert';
import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/models/candidates.dart';
import 'package:http/http.dart' as http;
class CandidateService {
  static const API = 'http://10.0.2.2:8000/apis/v1/Candidates';
  static const headers = {"Content-Type":"application/json"};


  Future<APIResponse<List<Candidates>>> getCandidateList() {
    return http.get(Uri.parse(API), headers: headers).then((data) {
      if (data.statusCode ==  200) {
        final jsonData = json.decode(data.body);
        final  candidates = <Candidates>[];
          for (var item in jsonData) {
            candidates.add(Candidates.fromJson(item));
          }
        return APIResponse<List<Candidates>>(data: candidates);
      }
      return APIResponse<List<Candidates>>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<List<Candidates>>(error: true, errorMessage: 'An error occured'));
  }

/*


  Future<APIResponse<Candidate>> getNote(String noteID) {

    return http.get(Uri.parse('http://10.0.2.2:8000/apis/v1/notes/${noteID}/'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Candidate>(data: Candidate.fromJson(jsonData));
      }
      return APIResponse<Candidate>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<Candidate>(error: true, errorMessage: 'An error occured'));
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
  }*/

}
