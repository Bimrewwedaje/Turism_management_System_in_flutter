import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_app/api/UserApi.dart';
import 'package:flutter_app/screens/user/adduserscreen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final todop=Provider.of<TodoProvider>(context);
    final urlImage = "http://10.0.2.2:8000/media/Hotel_Image/sl.jfif";
    return Scaffold(
      appBar: AppBar(
        title: Text("Hotel View "),
      ),
    //   body:Center(
    //    child: Container(
    //      child: Image.network("https://media.istockphoto.com/photos/hotel-room-suite-with-view-picture-id627892060"),
    // ),
    // )
      body:ListView.separated(
          itemCount: todop.todos.length,
          separatorBuilder: (_, __) =>
              Divider(height: 1, color: Colors.black),
          itemBuilder: (BuildContext context,int index){
            return ListTile(
              // trailing:IconButton(icon:Icon(Icons.delete,color: Colors.red) ,
              //   onPressed:(){todop.deleteUser(todop.todos[index]);},) ,
              //title: Text("Username :" +todop.todos[index].username,style: TextStyle(color: Theme.of(context).primaryColor)),
              subtitle: Column(
                children: [
                Align(
                alignment: Alignment.topLeft,
                    child: Text(/*"Name : "+ todop.todos[index].User_Fname+" "+todop.todos[index].User_Lname,*/ "Hotel",style: TextStyle(
                    // color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                       wordSpacing: 10,
                )
                )
                ),
              Align(
                child: Image.network(
                  urlImage,
                  height: 300,
                  width: 300,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child:Text("Detail : "/*+todop.todos[index].User_Email*/,style: TextStyle(
                    // color: Colors.white,
                     backgroundColor: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16))),

                  //Text(todop.todos[index].User_Email),
                 // Text(todop.todos[index].User_Phone),
                 // Text(todop.todos[index].User_Role),
                 // Text(todop.todos[index].User_Fp),

                ],
             ),
            );
          }
      ),
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





