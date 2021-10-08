
import 'package:flutter/material.dart';
import 'package:flutter_app/Services/event_service.dart';
import 'package:flutter_app/Services/hotel_service.dart';
import 'package:flutter_app/Services/notes_service.dart';
import 'package:flutter_app/models/event.dart';
import 'package:flutter_app/models/hotel.dart';
import 'package:flutter_app/models/note.dart';
import 'package:flutter_app/models/note_insert.dart';
import 'package:get_it/get_it.dart';

class EventModify extends StatefulWidget {

  final String id;
  EventModify({this.id});

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<EventModify> {
  bool get isEditing => widget.id != null;

  EventService get eventService => GetIt.I<EventService>();

  String errorMessage;
  EventD_Model event;
  TextEditingController _EventtypeController = TextEditingController();
  TextEditingController __EventlocationController = TextEditingController();
  TextEditingController _EventdetailController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();


  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      eventService.getEvent(widget.id)
          .then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        event = response.data;
        _titleController.text = event.Event_name;
        _EventtypeController.text = event.Event_type;
        __EventlocationController.text= event.Event_location;
        _EventdetailController.text = event.Event_detail;
        _contentController.text = event.Image;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Event Detail' : 'Create note')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : Column(
          children: <Widget>[
            TextField(
              enabled: false,
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Event Name",
                hintText: 'Event title',
                enabled: false,
              ),
            ),

            Container(height: 8),
            //Image.network("http//10.0.2.2:8000/media/Hotel_Image/"),
            Image.network(
              event.Image,
              width: 200,
              height: 200,
            ),
            TextField(
              enabled: false,
              controller: _EventtypeController,
              decoration: InputDecoration(
                  labelText: "Event Type",
                  hintText: 'Event type'
              ),
            ),

            TextField(
              enabled: false,
              controller: _EventdetailController,
              decoration: InputDecoration(
                  labelText: "Event Detail",
                  hintText: 'Event detail'
              ),
            ),


            TextField(
              enabled: false,
              controller: __EventlocationController,
              decoration: InputDecoration(
                  labelText: "Event Location",
                  hintText: 'Location'
              ),
            ),

          ],
        ),
      ),
    );
  }
}

