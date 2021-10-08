import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/screens/Candidates/Candidates.dart';
import 'package:flutter_app/screens/account/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VoteingPage extends StatefulWidget {

  final String id;

 const VoteingPage({Key key, this.id}) : super(key: key);

  @override
  _VoteingPageState createState() => _VoteingPageState();
}

class _VoteingPageState extends State<VoteingPage> {
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
            // child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView(
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
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      widget.id ==null ? "No Hotel Selected" :  widget.id,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
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
                                      builder: (ctx) => CandidatesList()));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 90),
                                  child: Text(
                                    "Back",
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

  Vote(String username, pro, pre, conf, strp, ans, tm) async {
    if (!_formKey.currentState.validate()) {
      //invalid
      return;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'id': username,
      'hotel_name': pro,
      'hotel_type': pre,
      'hotel_location': conf,
      'hotel_detail': pro,
      'hotel_price': ans,
      'picture': tm
    };
    /*class Hotel_model(models.Model):
    hotel_name = models.CharField(max_length=20)
    hotel_type = models.CharField(max_length=50)
    hotel_location = models.CharField(max_length=50)
    hotel_detail = models.TextField(max_length=1000)
    hotel_price = models.FloatField(default=0.0)
    picture = models.ImageField(upload_to="Hotel_Image", blank=True)*/
    var response = await http.put(
        Uri.parse('http://10.0.2.2:8000/apis/v1/ListHotel'), body: data);
    if (response.statusCode == 200) {
      var errorMessage = 'Evaluated Successfully';
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
      _showerrorDialog(errorMessage);
    }
  }

  Container buttonSection() {
    return Container(
      padding: EdgeInsets.only(top: 40),
      width: 140,
      child: RaisedButton(
          onPressed: protocolController.text == "" || protocolController.text == ""
              ?null: () {
            setState(() {
              _isLoading = true;
            });
            Vote(widget.id, protocolController.text, presentationController.text, confidenceController.text, StarategicController.text,
              AnsController.text, TmController.text,);
          },
          shape: RoundedRectangleBorder(
            borderRadius:
            new BorderRadius.circular(10.0),
          ),
          child: Text(
            'Evaluate',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.green),
    );
  }
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController protocolController = new TextEditingController();
  final TextEditingController presentationController = new TextEditingController();
  final TextEditingController confidenceController = new TextEditingController();
  final TextEditingController StarategicController = new TextEditingController();
  final TextEditingController AnsController = new TextEditingController();
  final TextEditingController TmController = new TextEditingController();


  Container textSection() {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: protocolController,
            // obscureText: true,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "Protocol 5%",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
            validator: (value) {
              if (value.isEmpty || double.parse(value)>5 ||double.parse(value)<0) {
                return 'protocol value must be >=0 and <=5';
              }
            },
          ),

          SizedBox(height: 10.0),
          TextFormField(
            controller: presentationController,
            // obscureText: true,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "Presentation skill 15%",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
            validator: (value) {
              if (value.isEmpty || double.parse(value)>5 ||double.parse(value)<0) {
                return 'Presentation value must be >=0 and <=15';
              }
            },
          ),


          SizedBox(height: 10.0),
          TextFormField(
            controller: confidenceController,
            // obscureText: true,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "Confidence 5%",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
            validator: (value) {
              if (value.isEmpty || double.parse(value)>5 ||double.parse(value)<0) {
                return 'Confidence value must be >=0 and <=5';
              }
            },
          ),

          SizedBox(height: 10.0),
          TextFormField(
            controller: StarategicController,
            // obscureText: true,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "Strategic plan 20%",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
            validator: (value) {
              if (value.isEmpty || double.parse(value)>5 ||double.parse(value)<0) {
                return 'Strategic value must be >=0 and <=20';
              }
            },
          ),

          SizedBox(height: 10.0),
          TextFormField(
            controller: AnsController,
            // obscureText: true,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "Answering 10%",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
            validator: (value) {
              if (value.isEmpty || double.parse(value)>5 ||double.parse(value)<0) {
                return 'Answering value must be >=0 and <=10';
              }
            },
          ),

          SizedBox(height: 10.0),
          TextFormField(
            controller: TmController,
            // obscureText: true,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "Time management plan 20%",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
            validator: (value) {
              if (value.isEmpty || double.parse(value)>5 ||double.parse(value)<0) {
                return 'Time management value must be >=0 and <=20';
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
