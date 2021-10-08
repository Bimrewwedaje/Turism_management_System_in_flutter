import 'package:flutter/material.dart';
import 'package:flutter_app/Services/notes_service.dart';
import 'package:flutter_app/Services/user_service.dart';
import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/models/note_for_listing.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/Complain/DeleteComplain.dart';
import 'package:get_it/get_it.dart';

class UserProfilePage extends StatefulWidget {
  @override
  final String title;
   UserProfilePage({Key key, this.title}) : super(key: key);
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  userService get service => GetIt.I<userService>();

  APIResponse<User> _apiResponse;
  bool _isLoading = false;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getUser(widget.title);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Profile')),
       /* floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => NoteModify()))
                .then((_) {
              _fetchNotes();
            });
          },
          child: Icon(Icons.add),
        ),*/
        body: Builder(
          builder: (_) {
            if (_isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (_apiResponse.error) {
              return Center(child: Text(_apiResponse.errorMessage));
            }

            return ListView.separated(
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: Colors.green),
              itemBuilder: (_, index) {
                return Dismissible(
                  key: ValueKey(_apiResponse.data.username),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                        context: context, builder: (_) => NoteDelete());

                    if (result) {
                      final deleteResult = await service.deleteNote(_apiResponse.data.User_Fname);

                      var message;
                      if (deleteResult != null && deleteResult.data == true) {
                        message = 'The note was deleted successfully';
                      } else {
                        message = deleteResult?.errorMessage ?? 'An error occured';
                      }

                      showDialog(
                          context: context, builder: (_) => AlertDialog(
                        title: Text('Done'),
                        content: Text(message),
                        actions: <Widget>[
                          FlatButton(child: Text('Ok'), onPressed: () {
                            Navigator.of(context).pop();
                          })
                        ],
                      ));

                      return deleteResult?.data ?? false;
                    }
                    print(result);
                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.only(left: 16),
                    child: Align(
                      child: Icon(Icons.delete, color: Colors.white),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      _apiResponse.data.username,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Column(
                    children: [
                      Text(_apiResponse.data.User_Fname),
                      Text(_apiResponse.data.User_Lname),
                      Text(_apiResponse.data.User_Gender),
                      Text(_apiResponse.data.User_Email),
                      Text(_apiResponse.data.User_Phone),
                      Text(_apiResponse.data.User_Role),
                    ],),


                    /*onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => NoteModify(
                              noteID: _apiResponse.data[index].noteID))).then((data) {
                        _fetchNotes();
                      });
                    },*/
                  ),
                );
              },
             itemCount: 1,
            );
          },
        ));
  }
}


























