import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/screens/account/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                    .height * 0.70,
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
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Sing Up in with your username and  email",
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
                                      builder: (ctx) => LoginPage()));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 90),
                                  child: Text(
                                    "Sign In",
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

  SignUp(String username,email, pass) async {
    if (!_formKey.currentState.validate()) {
      //invalid
      return;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'username': username,
      'email': email,
      'password': pass
    };
    var response = await http.post(
        Uri.parse('http://10.0.2.2:8000/accounts/api/register/'), body: data);
    if (response.statusCode == 200) {
      var errorMessage = 'Account Created Successfully';
      _showerrorDialog(errorMessage);
        setState(() {
          _isLoading = false;
        });
      Navigator.of(context).push(MaterialPageRoute(builder:
          (ctx)=>LoginPage()));
      }
    else {
      setState(() {
        _isLoading = false;
      });
      var errorMessage = 'in valid data ';
      print(response.body);
      _showerrorDialog(errorMessage + " "+username+" "+email+" "+pass);
    }
  }

  Container buttonSection() {
    return Container(
      padding: EdgeInsets.only(top: 40),
      width: 140,
      child: RaisedButton(
          onPressed: emailController.text == "" || passwordController.text == ""
              ? null
              : () {
            setState(() {
              _isLoading = true;
            });
            SignUp(usernameController.text, emailController.text, passwordController.text);
          },
          shape: RoundedRectangleBorder(
            borderRadius:
            new BorderRadius.circular(10.0),
          ),
          child: Text(
            'Sign Up',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.green),
    );
  }
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: usernameController,
           // obscureText: true,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "Username",
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
            controller: emailController,
            //obscureText: true,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: "Email",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
            validator: (value) {
              if (value.isEmpty || !value.contains('@')||!value.contains('.')) {
                return 'Invalid Email';
              }
            },
          ),




          SizedBox(height: 30.0),
          TextFormField(
            controller: _passwordController,
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
              hintText: "Confirm Password",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
              validator: (value) {
                if (value != _passwordController.text) {
                  return 'Password doesnot match';
                }
              }
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
