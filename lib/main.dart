import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/Services/notes_service.dart';
import 'package:flutter_app/api/Vote_Api.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_app/api/UserApi.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'Services/TourEventService.dart';
import 'Services/event_service.dart';
import 'Services/hotel_service.dart';
import 'Services/user_service.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => CandidateService());
  GetIt.I.registerLazySingleton(() => NotesService());
  GetIt.I.registerLazySingleton(() => userService());
  GetIt.I.registerLazySingleton(() => HotelService());
  GetIt.I.registerLazySingleton(() => EventService());
  GetIt.I.registerLazySingleton(() => TourEventService());


}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String title1="";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>TodoProvider(),
      child: MaterialApp(
        title: 'Tourism System',

        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        home:MyHomePage(title: title1),
      ),
    );

  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}



