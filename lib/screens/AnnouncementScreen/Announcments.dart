import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/AnnouncementApi.dart';
import 'package:flutter_app/api/UserApi.dart';
import 'package:flutter_app/screens/AnnouncementScreen/Announce.dart';
import 'package:flutter_app/screens/read_more_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MyAnnouncementsApp extends StatelessWidget {
  String dis="";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>AnnouncmentProvider(),
      child: MaterialApp(
        title: 'Flutter Dem o',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:Announcements(),
      ),
    );
  }
}
class Announcements extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    final AnnP=Provider.of<AnnouncmentProvider>(context);
    return Scaffold(
     /* appBar: AppBar(
        title: Text("Announcements"),
        backgroundColor: Colors.black,
        toolbarHeight: 20,
        elevation: 15,
        centerTitle: true,
    //appBarTheme: AppBarTheme(
    //color: Color(0xFF151026),
     ),*/
      body:ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemCount: AnnP.todos.length,
          itemBuilder: (BuildContext context,int index){

            return ListTile(
              //trailing:IconButton(icon:Icon(Icons.delete,color: Colors.red) ,
                //onPressed:(){AnnP.deleteAnnouncment(AnnP.todos[index]);},) ,
              title: Align(
                alignment: Alignment.center,
                child: Text(AnnP.todos[index].Ann_Title),
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ReadMoreText(
                      (AnnP.todos[index].Ann_Dis),
                      trimLines: 2,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: '...Show more',
                      trimExpandedText: ' show less',
                    ),
                  ),

                  Align(
                    alignment: Alignment.topRight,
                    child: Text(AnnP.todos[index].Ann_By
                    ),
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