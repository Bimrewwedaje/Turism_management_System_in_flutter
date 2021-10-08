import 'package:flutter/material.dart';
import 'package:flutter_app/Services/Campaign_service.dart';
import 'package:flutter_app/screens/AnnouncementScreen/Announce.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/screens/read_more_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MyCampaignApp extends StatelessWidget {
  String title;
  MyCampaignApp({Key key, this.title}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>CampaignProvider(),
      child: MaterialApp(
        title: 'Flutter Dem o',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:Campaigns(),
      ),
    );
  }
}
class Campaigns extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    final AnnP=Provider.of<CampaignProvider>(context);
    return Scaffold(
       appBar: AppBar(
        title: Text("Tourist"),
        centerTitle: true,
    //appBarTheme: AppBarTheme(
    //color: Color(0xFF151026),
     ),
      body:ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemCount: AnnP.todos.length,
          itemBuilder: (BuildContext context,int index){

            return ListTile(
              //trailing:IconButton(icon:Icon(Icons.delete,color: Colors.red) ,
              //onPressed:(){AnnP.deleteAnnouncment(AnnP.todos[index]);},) ,
              title: Align(
                alignment: Alignment.center,
                child: Text(AnnP.todos[index].camp_title,
                    style: TextStyle(
                      color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 24)),
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
                      (AnnP.todos[index].camp_dis),style: TextStyle(
                          // color: Colors.white,
                          //fontWeight: FontWeight.bold,
                          fontSize: 18),
                      trimLines: 2,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: '...Show more',
                      trimExpandedText: ' show less',
                    ),
                  ),

                  Align(
                    alignment: Alignment.topRight,
                    child: Text("Toured by "+AnnP.todos[index].camp_by,
                        style: TextStyle(
                        // color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text("Toured  date "+AnnP.todos[index].camp_date,
                        style: TextStyle(
                        // color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)
                    ),
                  ),
                ],
              ),
            );
          }
      ),
      floatingActionButton:FloatingActionButton(
        child: Text("back"),
        onPressed:(){
          Navigator.of(context).push(MaterialPageRoute(builder:
              (ctx)=>MyHomePage(title:"user")));
        },)
      ,
    );
  }
}