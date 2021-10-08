import 'package:flutter/material.dart';
import 'package:flutter_app/Services/Schedule_Service.dart';
import 'package:flutter_app/api/AnnouncementApi.dart';
import 'package:flutter_app/screens/AnnouncementScreen/Announce.dart';
import 'package:flutter_app/screens/read_more_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SchedulesApp extends StatelessWidget {
  String dis="";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>ScheduleProvider(),
      child: MaterialApp(
        title: 'Flutter Dem o',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:Schedule(),
      ),
    );
  }
}
class Schedule extends StatelessWidget{
  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
  @override
  Widget build(BuildContext context){

    final SchP=Provider.of<ScheduleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedules",
            style: TextStyle(
              // color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 36)),
        centerTitle: true,
     ),
      body:ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemCount: SchP.todos.length,
          itemBuilder: (BuildContext context,int index){
            return ListTile(
              //trailing:IconButton(icon:Icon(Icons.delete,color: Colors.red) ,
              //onPressed:(){AnnP.deleteAnnouncment(AnnP.todos[index]);},) ,
              title: Align(
                alignment: Alignment.center,
                child: Text(SchP.todos[index].action,style: TextStyle(
                  color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
              ),
              subtitle: Column(
                children: [
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.003,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.85,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(360),
                            bottomRight: Radius.circular(360)),
                        color: Colors.blue),
                  ),
                  Align(
                  alignment: Alignment.topCenter,
                  child: Text(" Start and End Date : "+SchP.todos[index].Start_date+"- to -"+SchP.todos[index].End_date,
                      style: TextStyle(
                         // color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20))
                   ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(" Scheduled Date : "+SchP.todos[index].Scheduled_date,
            style: TextStyle(
            // color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16))

                  ),
                ],
              ),
            );
          }
      ),
      floatingActionButton:FloatingActionButton(
        child: Icon(Icons.add,size: 30,),
        onPressed:(){
          Navigator.of(context).push(MaterialPageRoute(builder:
              (ctx)=>Announce()));
        },)
      ,
    );
  }
}