import 'package:flutter/material.dart';
import 'package:flutter_app/Services/GasStationService.dart';
import 'package:flutter_app/models/GasStationModel.dart';

import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/models/note_for_listing.dart';
import 'package:flutter_app/screens/Complain/DeleteComplain.dart';
import 'package:get_it/get_it.dart';
import 'AddGasStation.dart';

class GasStation extends StatefulWidget {
  @override
  _ComplainsState createState() => _ComplainsState();
}

class _ComplainsState extends State<GasStation> {
  GasStationService get service => GetIt.I<GasStationService>();

  APIResponse<List<GasStationForListing>> _apiResponse;
  bool _isLoading = false;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
  // final urlHotel = Image;
  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getGasStationList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('List Of Gas Station')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => GasStationModify()))
                .then((_) {
              _fetchNotes();
            });
          },
          child: Icon(Icons.add),
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
                  key: ValueKey(_apiResponse.data[index].GasStation_name),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                        context: context, builder: (_) => NoteDelete());

                    if (result) {
                      final deleteResult = await service.deleteNote(_apiResponse.data[index].GasStation_name);

                      var message;
                      if (deleteResult != null && deleteResult.data == true) {
                        message = 'The note was deleted successfully';
                      } else {
                        message = deleteResult?.errorMessage ?? 'An error occured';
                      }

                      // showDialog(
                      //     context: context, builder: (_) => AlertDialog(
                      //   title: Text('Done'),
                      //   content: Text(message),
                      //   actions: <Widget>[
                      //     FlatButton(child: Text('Ok'), onPressed: () {
                      //       Navigator.of(context).pop();
                      //     })
                      //   ],
                      // ));

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
                        _apiResponse.data[index].GasStation_name),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => GasStationModify(
                              id: _apiResponse.data[index].id))).then((data) {
                        _fetchNotes();
                      });
                    },
                    subtitle: Column(
                      children: [
                        Align(
                          child: Image.network(
                            _apiResponse.data[index].Image,
                            width: 200,
                            height: 200,
                          ),
                        ),

                        Align(
                            alignment: Alignment.center,
                            child:Text("Detail : "/*+todop.todos[index].User_Email*/,style: TextStyle(
                              // color: Colors.white,
                                backgroundColor: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16))),

                        //Text(todop.todos[index].User_Email),
                        // Text(todop.todos[index].User_Phone),
                        // Text(todop.todos[index].User_Role),
                        // Text(todop.todos[index].User_Fp),

                      ],
                    ),

                  ),
                );
              },
              itemCount: _apiResponse.data.length,
            );
          },
        ));
  }
}

