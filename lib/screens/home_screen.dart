import 'package:flutter/material.dart';
import 'package:flutter_app/screens/AnnouncementScreen/Announcments.dart';
import 'package:flutter_app/screens/Candidates/Candidates.dart';
import 'package:flutter_app/screens/Candidates/Vote.dart';
import 'package:flutter_app/screens/Complain/Complains.dart';
import 'package:flutter_app/screens/Schedule/Schedules.dart';
import 'package:flutter_app/screens/account/SignUp_page.dart';
import 'package:flutter_app/screens/account/login_page.dart';
import 'package:flutter_app/screens/campaign/Campaigns.dart';
import 'package:flutter_app/screens/user/UserProfile.dart';
import 'package:flutter_app/screens/user/adduserscreen.dart';
import 'package:flutter_app/screens/user/userscreen.dart';

import 'HomeScreen.dart';
import 'hotel/hotelScrean.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tourism System")),
      body:HomeScreen(), //Center(child: Text(
      //'Wolkite university student union.',
      //style: TextStyle(fontSize: 20.0,),
      // )
      //),

      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Guragie"),
              accountEmail: Text("gurage@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.deepOrange,
                child: Text(
                  "Tour",
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            ),
            if(title!="")
            ListTile(
              leading: Icon(Icons.app_registration),
              title: Text("Profile"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder:
                    (ctx)=>UserProfilePage(title:title)));
              },
            ),
            ListTile(
              leading: Icon(Icons.app_registration),
              title: Text("Register"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder:
                    (ctx)=>AddUserScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.campaign_outlined),//
              title: Text("Tour Agent"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder:
                    (ctx)=>MyCampaignApp(title: title,)));
              },
            ),
           /* ListTile(
              leading: Icon(Icons.announcement_outlined),
              title: Text("Announcements"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder:
                    (ctx)=>MyAnnouncementsApp()));
              },
            ),*/
           if(title!="")
            ListTile(
              leading: Icon(Icons.comment_bank_outlined),
              title: Text("Tourist"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder:
                    (ctx)=>Complains()));
              },
            ),
            if(title!="")
            ListTile(
              leading: Icon(Icons.grade_outlined),
              title: Text("Adveret"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            //if(title=="")
            ListTile(
              leading: Icon(Icons.grade_outlined),
              title: Text("Tour Login"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder:
                    (ctx)=>LoginPage()));
              },
            ),
            if(title=="")
            ListTile(
              leading: Icon(Icons.grade_outlined),
              title: Text("SignUp"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder:
                    (ctx)=>SignUpPage()));
              },
            ),
           // if(title!="")
           //  ListTile(
           //    leading: Icon(Icons.grade_outlined),
           //    title: Text("Tour"),
           //    onTap: () {
           //      Navigator.of(context).push(MaterialPageRoute(builder:
           //          (ctx)=>HomePage()));
           //    },
           //  ),
           //  if(title!="")
           //  ListTile(
           //    leading: Icon(Icons.grade_outlined),
           //    title: Text("Hotel Detail"),
           //    onTap: () {
           //      Navigator.of(context).push(MaterialPageRoute(builder:
           //          (ctx)=>HotelScrean()));
           //    },
           //  ),
            if(title!="")
            ListTile(
              leading: Icon(Icons.grade_outlined),
              title: Text("Tour"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder:
                    (ctx)=>VoteingPage()));
              },
            ),
            // if(title!="")
            //   ListTile(
            //     leading: Icon(Icons.grade_outlined),
            //     title: Text("Schedules"),
            //     onTap: () {
            //       Navigator.of(context).push(MaterialPageRoute(builder:
            //           (ctx)=>SchedulesApp()));
            //     },
            //   ),
            if(title!="")
              ListTile(
                leading: Icon(Icons.grade_outlined),
                title: Text("Logout"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder:
                      (ctx)=>MyHomePage(title: "")));
                },
              ),
          ],
        ),
      ),
    );
  }
}




