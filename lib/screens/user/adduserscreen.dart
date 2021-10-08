import 'package:flutter/material.dart';
import 'package:flutter_app/api/UserApi.dart';
import 'package:flutter_app/models/UserModel.dart';
import 'package:provider/provider.dart';
class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final usernameController = TextEditingController();
  final FnameController = TextEditingController();
  final LnameController = TextEditingController();
  final GenderController = TextEditingController();
  final EmaileController = TextEditingController();
  final PhoneController= TextEditingController();
  final RoleController = TextEditingController();



  @override
//add method used to add user
  void onAdd() {
    //used to attribute validation
    final String username = usernameController.text;
    final String Fname = FnameController.text;
    final String Lname = LnameController.text;
    final String Gender = GenderController.text;
    final String Email = EmaileController.text;
    final String Phone = PhoneController.text;
    final String Role = RoleController.text;
    if (username.isNotEmpty&&Fname.isNotEmpty) {
      final User todo = User(username: username,
          User_Fname: Fname,
          User_Lname: Lname,
          User_Gender: Gender,
          User_Email: Email,
          User_Phone: Phone,
          User_Role: Role,
      );
      Provider.of<TodoProvider>(context, listen: false).AddUser(todo);
      Navigator.pop(context);
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User '),
      ),
      body: ListView(
        children: [
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
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  TextField(controller: usernameController, style: TextStyle(color: Colors.white70),
                    decoration: InputDecoration(hintText: 'Please enter your ID', hintStyle: TextStyle(color: Colors.white70),
                  ),
                    ),
                  TextField(controller:FnameController,decoration: InputDecoration(hintText: 'Please enter your First Name',
                      hintStyle: TextStyle(color: Colors.white70),
                  ),),
                  TextField(controller:LnameController,decoration: InputDecoration(hintText: 'Please enter your Last Name'
                    , hintStyle: TextStyle(color: Colors.white70),
                  ),),
                  TextField(controller:GenderController,decoration: InputDecoration(hintText: 'Please enter your Gender'
                    , hintStyle: TextStyle(color: Colors.white70),
                  ),),
                  TextField(controller:EmaileController,decoration: InputDecoration(hintText: 'Please enter your Email'
                    , hintStyle: TextStyle(color: Colors.white70),
                  ),),
                  TextField(controller:PhoneController,decoration: InputDecoration(hintText: 'Please enter your Role'
                    , hintStyle: TextStyle(color: Colors.white70),
                  ),),

                  // TextField(controller:RoleController,decoration: InputDecoration(hintText: 'Please enter your Role'
                  //   , hintStyle: TextStyle(color: Colors.white70),
                  // ),),
              Container(
                padding: EdgeInsets.only(top: 40),
                width: 140,
              ),
                  RaisedButton(child: Text("Add"), onPressed: onAdd,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      new BorderRadius.circular(10.0),
                    ),
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}
