
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_app/api/UserApi.dart';
import 'package:flutter_app/screens/tourAcitivity/Tour_event_screan.dart';
import 'package:flutter_app/screens/user/adduserscreen.dart';
import 'package:provider/provider.dart';
import 'Complain/Complains.dart';
import 'gasStation/GasStationScrean.dart';
import 'hotel/hotelScrean.dart';
import 'event/eventScrean.dart';


class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final todop=Provider.of<TodoProvider>(context);
    final urlImage = "http://10.0.2.2:8000/media/Hotel_Image/hotel.jpg";
    final urlSite = "http://10.0.2.2:8000/media/lalibelasite.jpg";
    final urlEvent = "http://10.0.2.2:8000/media/Event_Image/event.jpg";
    final urlGas = "http://10.0.2.2:8000/media/Event_Image/event.jpg";
    return Scaffold(
      body: Table(
        children: [
          TableRow(
            children: [
              Align(
                  alignment: Alignment.center,
                  child:Text("Hotel Page : ",style: TextStyle(
                     color: Colors.white,
                      backgroundColor: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 36))),

              Align(

                  alignment: Alignment.center,
                  child:RaisedButton(
                    child: Image.network(
                      urlImage,
                      height: 90,
                      width: 90,
                    ),
                    onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(builder:
                          (ctx)=>Hotel()));
                    },)

              ),
              Align(
                  alignment: Alignment.center,
                  child:Text("Site Page : "/*+todop.todos[index].User_Fname*/,style: TextStyle(
                    // color: Colors.white,
                      backgroundColor: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 36))),
              Align(
                  alignment: Alignment.center,
                  child:RaisedButton(
                    child: Image.network(
                      urlSite,
                      height: 90,
                      width: 90,

                    ),
                    onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(builder:
                          (ctx)=>Complains()));
                    },)

              ),
            ]
          ),
          TableRow(
            children: [
              Align(
                  alignment: Alignment.center,
                  child:Text("Event Page : "/*+todop.todos[index].User_Fname*/,style: TextStyle(
                    // color: Colors.white,
                      backgroundColor: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 36))),

              Align(
                  alignment: Alignment.center,
                  child:RaisedButton(
                    child: Image.network(
                      urlEvent,
                      height: 90,
                      width: 90,
                    ),
                    onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(builder:
                          (ctx)=>Event()));
                    },)

              ),

              Align(
                  alignment: Alignment.center,
                  child:Text("Gas Station Page : "/*+todop.todos[index].User_Fname*/,style: TextStyle(
                    // color: Colors.white,
                      backgroundColor: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 36))),

              Align(
                  alignment: Alignment.center,
                  child:RaisedButton(
                    child: Image.network(
                      urlGas,
                      height: 90,
                      width: 90,
                    ),
                    onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(builder:
                          (ctx)=>GasStation()));
                    },)

              ),
              Align(
                  alignment: Alignment.center,
                  child:Text("Tour Event Page : "/*+todop.todos[index].User_Fname*/,style: TextStyle(
                    // color: Colors.white,
                      backgroundColor: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 36))),

              Align(
                  alignment: Alignment.center,
                  child:RaisedButton(
                    child: Image.network(
                      urlGas,
                      height: 90,
                      width: 90,
                    ),
                    onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(builder:
                          (ctx)=>TourEvent()));
                    },)

              ),
              Align(
                  alignment: Alignment.center,
                  child:Text("Tour Event Page : "/*+todop.todos[index].User_Fname*/,style: TextStyle(
                    // color: Colors.white,
                      backgroundColor: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 36))),

              Align(
                  alignment: Alignment.center,
                  child:RaisedButton(
                    child: Image.network(
                      urlGas,
                      height: 90,
                      width: 90,
                    ),
                    onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(builder:
                          (ctx)=>TourEvent()));
                    },)

              ),
            ]
          ),

        ],
      ),
      // body:ListView.separated(
      //
      //     itemCount:1,
      //     separatorBuilder: (_, __) =>
      //         Divider(height: 1, color: Colors.black),
      //     itemBuilder: (BuildContext context,int index){
      //       return ListTile(
      //       subtitle: Row(
      //           Align(
      //                       alignment: Alignment.center,
      //                       child:Text("Site Page : "/*+todop.todos[index].User_Fname*/,style: TextStyle(
      //                         // color: Colors.white,
      //                           backgroundColor: Colors.blue,
      //                           fontWeight: FontWeight.bold,
      //                           fontSize: 36))),
      //                   Align(
      //                       alignment: Alignment.center,
      //                       child:RaisedButton(
      //                         child: Image.network(
      //                           urlSite,
      //                           height: 200,
      //                           width: 450,
      //
      //                         ),
      //                         onPressed:(){
      //                           Navigator.of(context).push(MaterialPageRoute(builder:
      //                               (ctx)=>Complains()));
      //                         },)
      //
      //                   ),  children: [

      //             // Align(
      //             //     alignment: Alignment.topRight,
      //             //     child:Text("Detail : "+todop.todos[index].User_Fname,style: TextStyle(
      //             //       // color: Colors.white,
      //             //         backgroundColor: Colors.blue,
      //             //         fontWeight: FontWeight.bold,
      //             //         fontSize: 16)),
      //             //   // onPressed:(){
      //             //   //   Navigator.of(context).push(MaterialPageRoute(builder:
      //             //   //       (ctx)=>Complains()));
      //             //   // },
      //             // ),
      //             Align(
      //                 alignment: Alignment.center,
      //                 child:Text("Hotel Page : "/*+todop.todos[index].User_Fname*/,style: TextStyle(
      //                   // color: Colors.white,
      //                     backgroundColor: Colors.blue,
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 36))),
      //
      //             Align(
      //
      //                 alignment: Alignment.center,
      //                 child:RaisedButton(
      //                   child: Image.network(
      //                     urlImage,
      //                   height: 200,
      //                   width: 450,
      //                 ),
      //                    onPressed:(){
      //                   Navigator.of(context).push(MaterialPageRoute(builder:
      //                       (ctx)=>Hotel()));
      //            },)
      //
      //             ),
      //             // Align(
      //             //     alignment: Alignment.topRight,
      //             //     child:Text("Detail : "+todop.todos[index].User_Fname,style: TextStyle(
      //             //       // color: Colors.white,
      //             //         backgroundColor: Colors.blue,
      //             //         fontWeight: FontWeight.bold,
      //             //         fontSize: 16))),
      //             Align(
      //                 alignment: Alignment.center,
      //                 child:Text("Event Page : "/*+todop.todos[index].User_Fname*/,style: TextStyle(
      //                   // color: Colors.white,
      //                     backgroundColor: Colors.blue,
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 36))),
      //
      //             Align(
      //                 alignment: Alignment.center,
      //                 child:RaisedButton(
      //                   child: Image.network(
      //                     urlEvent,
      //                     height: 200,
      //                     width: 450,
      //                   ),
      //                   onPressed:(){
      //                     Navigator.of(context).push(MaterialPageRoute(builder:
      //                         (ctx)=>Event()));
      //                   },)
      //
      //             ),
      //             Align(
      //                 alignment: Alignment.center,
      //                 child:Text("Gas Station Page : "/*+todop.todos[index].User_Fname*/,style: TextStyle(
      //                   // color: Colors.white,
      //                     backgroundColor: Colors.blue,
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 36))),
      //
      //             Align(
      //                 alignment: Alignment.center,
      //                 child:RaisedButton(
      //                   child: Image.network(
      //                     urlGas,
      //                     height: 200,
      //                     width: 450,
      //                   ),
      //                   onPressed:(){
      //                     Navigator.of(context).push(MaterialPageRoute(builder:
      //                         (ctx)=>GasStation()));
      //                   },)
      //
      //             ),
      //             Align(
      //                 alignment: Alignment.center,
      //                 child:Text("Tour Event Page : "/*+todop.todos[index].User_Fname*/,style: TextStyle(
      //                   // color: Colors.white,
      //                     backgroundColor: Colors.blue,
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 36))),
      //
      //             Align(
      //                 alignment: Alignment.center,
      //                 child:RaisedButton(
      //                   child: Image.network(
      //                     urlGas,
      //                     height: 200,
      //                     width: 450,
      //                   ),
      //                   onPressed:(){
      //                     Navigator.of(context).push(MaterialPageRoute(builder:
      //                         (ctx)=>TourEvent()));
      //                   },)
      //
      //             ),
      //
      //             //
      //             // //Text(todop.todos[index].User_Email),
      //             // // Text(todop.todos[index].User_Phone),
      //             // // Text(todop.todos[index].User_Role),
      //             // // Text(todop.todos[index].User_Fp),
      //
      //           ],
      //         ),
      //       );
      //     }
      // ),
      floatingActionButton:FloatingActionButton(
        child: Icon(Icons.add,size: 30,),
        onPressed:(){
          Navigator.of(context).push(MaterialPageRoute(builder:
              (ctx)=>AddUserScreen()));
        },)
      ,
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





















