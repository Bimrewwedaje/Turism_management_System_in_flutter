

import 'dart:convert';

import 'package:flutter_app/api/AnnouncementApi.dart';
import 'package:flutter_app/models/AnnouncementModel.dart';
import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/screens/AnnouncementScreen/Announcements.dart';
import 'package:http/http.dart' as http;

class Annoucement_Service{

static const API='http://10.0.2.2:8000/apis/Announcements?format=json';
static const headers={'Content-Type: application/json'};
  Future<APIResponse<List<AnnouncementModel>>> getAnnouncements() async {
   return await http.get(Uri.parse(API),headers: {"Content-Type":"application/json"})
       .then((data) {
         if(data.statusCode==200){
           final jsonData=json.decode(data.body);
           final Announcements=<AnnouncementModel>[];
           for (var item in jsonData){
             final Announcement=AnnouncementModel(
                  AnnID:item['id'],
                  Ann_By:item['Ann_By'],
                  Ann_Title:item['Ann_Title'],
                  Ann_Dis:item['Ann_Dis']);
             Announcements.add(Announcement);

           }
          return APIResponse<List<AnnouncementModel>>(
            data: Announcements

          );
         }
         return APIResponse<List<AnnouncementModel>>(
             error: true,errorMessage:'An error occured1');
   })
       .catchError((_)=>APIResponse<List<AnnouncementModel>>(
       error: true,errorMessage:'An error occured2'));


  }
}