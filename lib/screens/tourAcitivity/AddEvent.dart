import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'TourEventDetail.dart';
import 'imagepicker.dart';

class AddEvent extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<AddEvent> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _passwordController = new TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent));
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            // child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView(
            children: <Widget>[
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.80,
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
              Container(
                padding:
                EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(
                      "Add Event",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Add New Event ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            textSection(),

                            buttonSection(),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => MyPage()));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 90),
                                  child: Text(
                                    "choice image",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue,
                                        fontSize: 16),
                                  ),
                                ),
                              ),


                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => TourEventModify()));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 90),
                                  child: Text(
                                    "View Inserted Data",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue,
                                        fontSize: 16),
                                  ),
                                ),
                              ),


                            )


                          ],
                        ),
                      ),
                    ),  
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  SignUp(String eventName,eventType, eventLoc, eventDate,eventDetail,eventPrice) async {
    if (!_formKey.currentState.validate()) {
      //invalid
      return;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'eventName': eventName,
      'eventType': eventType,
      'eventLoc': eventLoc,
      'eventDate': eventDate,
      'eventDetail': eventDetail,
      'eventPrice': eventPrice
    };
    var response = await http.post(
        Uri.parse('http://10.0.2.2:8000/apis/v1/AddTourEvent'), body: data);
    if (response.statusCode == 201) {
      var errorMessage = 'Event Added Successfully';
      _showerrorDialog(errorMessage);
      setState(() {
        _isLoading = false;
      });
      // Navigator.of(context).push(MaterialPageRoute(builder:
      //     (ctx)=>AddEvent()));
    }
    else {
      setState(() {
        _isLoading = false;
      });
      var errorMessage = 'in valid data ';
      print(response.body);
      _showerrorDialog(errorMessage + " "+eventName+" "+eventType+" "+eventLoc+" "+eventDate+" "+eventDetail+" "+eventPrice);
    }
  }

  Container buttonSection() {
    return Container(
      padding: EdgeInsets.only(top: 40),
      width: 140,
      child: RaisedButton(
          onPressed: eventnameController.text == "" || eventlocController.text == "" || eventtypeController.text == "" || eventdateController.text == "" || eventdetailController.text=="" ||eventpriceController.text == ""
              ? null
              : () {
            setState(() {
              _isLoading = true;
            });
            SignUp(eventnameController.text, eventlocController.text, eventtypeController.text, eventdateController.text, eventdetailController.text, eventpriceController.text);
          },
          shape: RoundedRectangleBorder(
            borderRadius:
            new BorderRadius.circular(10.0),
          ),
          child: Text(
            'Add Event',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.green),
    );
  }//eventName eventType eventLoc eventDate  eventDetail
  final TextEditingController eventnameController = new TextEditingController();
  final TextEditingController eventlocController = new TextEditingController();
  final TextEditingController eventtypeController = new TextEditingController();
  final TextEditingController eventpriceController = new TextEditingController();
  final TextEditingController eventdateController = new TextEditingController();
  final TextEditingController eventdetailController = new TextEditingController();
  Container textSection() {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: eventnameController,
            // obscureText: true,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "Event Name",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
            validator: (value) {
              if (value.isEmpty || value.length < 3) {
                return 'Invalid Event';
              }
            },
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: eventlocController,
            // obscureText: true,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "Event Location",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
            validator: (value) {
              if (value.isEmpty || value.length < 3) {
                return 'Invalid Event';
              }
            },
          ),
          TextFormField(
            controller: eventtypeController,
            // obscureText: true,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "Event Type",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
            validator: (value) {
              if (value.isEmpty || value.length < 3) {
                return 'Invalid Event';
              }
            },
          ),
          TextFormField(
            controller: eventpriceController,
            // obscureText: true,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "Event price for full issue",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
            validator: (value) {
              if (value.isEmpty || value.length < 3) {
                return 'Invalid Event';
              }
            },
          ),
          TextFormField(
            controller: eventdateController,
            // obscureText: true,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "Event Date",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
            validator: (value) {
              if (value.isEmpty || value.length < 3) {
                return 'Invalid Event';
              }
            },
          ),
          TextFormField(
            controller: eventdetailController,
            // obscureText: true,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "Event Detail",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
            validator: (value) {
              if (value.isEmpty || value.length < 3) {
                return 'Invalid Event';
              }
            },
          ),



        ],
      ),
    );
  }

  void _showerrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Message',
          style: TextStyle(color: Colors.blue),
        ),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder:
                  (ctx)=>AddEvent()));
            },
          )
        ],
      ),
    );
  }
}
