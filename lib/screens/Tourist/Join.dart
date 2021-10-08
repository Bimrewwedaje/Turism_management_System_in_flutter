import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Join extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<Join> {
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
                      "Register Tourist",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Add New Tourist ",
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
                            // Align(
                            //   alignment: Alignment.bottomRight,
                            //   child: InkWell(
                            //     onTap: () {
                            //       Navigator.of(context).push(MaterialPageRoute(
                            //           builder: (ctx) => TourEventModify()));
                            //     },
                            //     child: Container(
                            //       padding: EdgeInsets.only(top: 90),
                            //       child: Text(
                            //         "View Inserted Data",
                            //         style: TextStyle(
                            //             decoration: TextDecoration.underline,
                            //             color: Colors.blue,
                            //             fontSize: 16),
                            //       ),
                            //     ),
                            //   ),
                            //
                            // )
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
  SignUp(String First_name,Father_Name, Event_name, Dob,Contact,Fee) async {
    if (!_formKey.currentState.validate()) {
      //invalid
      return;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'First_name': First_name,
      'Father_Name': Father_Name,
      'Event_name': Event_name,
      'Dob': Dob,
      'Contact': Contact,
      'Fee': Fee
    };
    var response = await http.post(
        Uri.parse('http://10.0.2.2:8000/apis/v1/Registertourist'), body: data);
    if (response.statusCode == 201) {
      var errorMessage = 'Registered Successfully';
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
      _showerrorDialog(errorMessage + " "+First_name+" "+Father_Name+" "+Event_name+" "+Dob+" "+Contact+" "+Fee);
    }
  }

  Container buttonSection() {
    return Container(
      padding: EdgeInsets.only(top: 40),
      width: 140,
      child: RaisedButton(
          onPressed: fistnameController.text == "" || lastnameController.text == "" || eventnameController.text == "" || contactController.text == "" || dobController.text=="" ||feeController.text == ""
              ? null
              : () {
            setState(() {
              _isLoading = true;
            });
            SignUp(fistnameController.text, lastnameController.text, eventnameController.text, contactController.text, dobController.text, feeController.text);
          },
          shape: RoundedRectangleBorder(
            borderRadius:
            new BorderRadius.circular(10.0),
          ),
          child: Text(
            'Register Tourist',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.green),
    );
  }//fistnameController lastnameController eventnameController contactController dobController feeController
  final TextEditingController fistnameController = new TextEditingController();
  final TextEditingController lastnameController = new TextEditingController();
  final TextEditingController eventnameController = new TextEditingController();
  final TextEditingController contactController = new TextEditingController();
  final TextEditingController dobController = new TextEditingController();
  final TextEditingController feeController = new TextEditingController();
  Container textSection() {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: fistnameController,
            // obscureText: true,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "Tourist First Name",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
            validator: (value) {
              if (value.isEmpty || value.length < 3) {
                return 'Invalid Tourist';
              }
            },
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: lastnameController,
            // obscureText: true,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "Tourist last Name",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
            validator: (value) {
              if (value.isEmpty || value.length < 3) {
                return 'Invalid Tourist';
              }
            },
          ),
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
            },//fistnameController lastnameController eventnameController contactController dobController feeController
          ),
          TextFormField(
            controller: dobController,
            // obscureText: true,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,//First_name Father_Name Event_name Dob Contact Fee
              ),
              hintText: "Dob",
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
            controller: contactController,
            // obscureText: true,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "Contact",
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
            controller: feeController,
            // obscureText: true,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "Fee That preceded from above",
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
                  (ctx)=>Join()));
            },
          )
        ],
      ),
    );
  }
}
