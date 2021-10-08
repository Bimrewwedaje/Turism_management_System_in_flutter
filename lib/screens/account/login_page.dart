import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/screens/account/SignUp_page.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/screens/tourAcitivity/AddEvent.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent));
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
             //child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView(
            children: <Widget>[
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.65,
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
                  "Sign In",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Sign in with your username or email",
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
                                         builder: (ctx) => SignUpPage()));
                                   },
                                   child: Container(
                                     padding: EdgeInsets.only(top: 90),
                                     child: Text(
                                       "Create Account",
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

  signIn(String username, pass) async {
    if (!_formKey.currentState.validate()) {
      //invalid
      return;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'username': username,
      'password': pass
    };
    var jsonResponse = null;
    var response = await http.post(
        Uri.parse('http://10.0.2.2:8000/login/'), body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (BuildContext context) =>
                AddEvent()), (
            Route<dynamic> route) => false);
      }

    }
    else {
      setState(() {
        _isLoading = false;
      });
      var errorMessage = 'Authentication Failed';
      print(response.body);
      _showerrorDialog(errorMessage);
    }
  }

  Container buttonSection() {
    return Container(
      padding: EdgeInsets.only(top: 40),
      width: 140,
      child: RaisedButton(
          onPressed: UsernameController.text == "" || passwordController.text == ""
              ? null
              : () {
            setState(() {
              _isLoading = true;
            });
            signIn(UsernameController.text, passwordController.text);
          },
          shape: RoundedRectangleBorder(
            borderRadius:
            new BorderRadius.circular(10.0),
          ),
          child: Text(
            'Sign In',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.green),
    );
  }

  final TextEditingController UsernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: UsernameController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "username",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
            validator: (value) {
                  if (value.isEmpty || value.length < 3) {
                        return 'Invalid username';
              }
            },
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.vpn_key,
                color: Colors.white,
              ),
              hintText: "Password",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
            validator: (value) {
              if (value.isEmpty || value.length < 5) {
                return 'Password is too Short';
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
          'An Error Occurs',
          style: TextStyle(color: Colors.blue),
        ),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
