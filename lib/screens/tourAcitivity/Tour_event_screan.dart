import 'package:flutter/material.dart';
import 'package:flutter_app/Services/TourEventService.dart';
import 'package:flutter_app/models/ToutEventModel.dart';
import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/screens/Complain/DeleteComplain.dart';
import 'package:get_it/get_it.dart';
import 'TourEventDetail.dart';

class TourEvent extends StatefulWidget {
  @override
  _ComplainsState createState() => _ComplainsState();
}

class _ComplainsState extends State<TourEvent> {
  TourEventService get service => GetIt.I<TourEventService>();

  APIResponse<List<TourEventForListing>> _apiResponse;
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

    _apiResponse = await service.getEventList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('List Of Tour Event')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => TourEventModify()))
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
                  key: ValueKey(_apiResponse.data[index].Event_name),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                        context: context, builder: (_) => NoteDelete());
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
                        _apiResponse.data[index].Event_name),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => TourEventModify(
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


