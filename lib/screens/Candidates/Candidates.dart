
import 'package:flutter/material.dart';
import 'package:flutter_app/api/Vote_Api.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/models/candidates.dart';
import 'package:flutter_app/screens/Candidates/Vote.dart';
import 'package:flutter_app/screens/account/login_page.dart';
import 'package:get_it/get_it.dart';


class CandidatesList extends StatefulWidget {
  @override
  _CandidatesListState createState() => _CandidatesListState();
}

class _CandidatesListState extends State<CandidatesList> {
  CandidateService get service => GetIt.I<CandidateService>();

  APIResponse<List<Candidates>> _apiResponse;
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

    _apiResponse = await service.getCandidateList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Candidates')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => MyApp()))
                .then((_) {
              _fetchNotes();
            });
          },
          child: Text('Back'),
        ),
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
                  key: ValueKey(_apiResponse.data[index].id),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                        context: context, builder: (_) => LoginPage());

                    if (result) {
                    /* final deleteResult =  await service.LoginPage(_apiResponse.data[index].noteID);

                      var message;
                      if (deleteResult != null && deleteResult.data == true) {
                        message = 'The note was deleted successfully';
                      } else {
                        message = deleteResult?.errorMessage ?? 'An error occured';
                      }*/

                      showDialog(
                          context: context, builder: (_) => AlertDialog(
                        title: Text('Done'),
                        content: Text("message"),
                        actions: <Widget>[
                          FlatButton(child: Text('Ok'), onPressed: () {
                            Navigator.of(context).pop();
                          })
                        ],
                      ));

                      return false; //deleteResult?.data ?? false;
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
                      _apiResponse.data[index].id,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Text(_apiResponse.data[index].User_Fname +" "+ _apiResponse.data[index].User_Lname),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => VoteingPage(id:_apiResponse.data[index].id))).then((data) {
                        _fetchNotes();
                      });
                    },
                  ),
                );
              },
              itemCount: _apiResponse.data.length,
            );
          },
        ));
  }
}


