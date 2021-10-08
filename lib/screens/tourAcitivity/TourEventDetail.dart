import 'package:flutter/material.dart';
import 'package:flutter_app/Services/TourEventService.dart';
import 'package:flutter_app/models/TourEvent.dart';
import 'package:flutter_app/screens/Tourist/Join.dart';
import 'package:get_it/get_it.dart';

class TourEventModify extends StatefulWidget {
  final String id;
  TourEventModify({this.id});

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<TourEventModify> {
  bool get isEditing => widget.id != null;

  TourEventService get eventService => GetIt.I<TourEventService>();

  String errorMessage;
  TourEventD_Model event;
  TextEditingController _EventtypeController = TextEditingController();
  TextEditingController __EventlocationController = TextEditingController();
  TextEditingController _EventdetailController = TextEditingController();
  TextEditingController _EventpriceController = TextEditingController();
  TextEditingController _EventdateController = TextEditingController();
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
        _EventdateController.text = event.Event_Date;
        _EventdetailController.text = event.Event_Detail;
        _EventpriceController.text = event.Event_Price;
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
              controller: _EventdateController,
              decoration: InputDecoration(
                  labelText: "Event Date",
                  hintText: 'Event Date'
              ),
            ),
            TextField(
              enabled: false,
              controller: _EventpriceController,
              decoration: InputDecoration(
                  labelText: "Event Price For full Action",
                  hintText: 'Event Price For full Action'
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
            TextField(
              enabled: false,
              controller: _EventdetailController,
              decoration: InputDecoration(
                  labelText: "Event Detail",
                  hintText: 'Event detail'
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => Join()));
                },
                child: Container(
                  padding: EdgeInsets.only(top: 90),
                  child: Text(
                    "Join To Event",
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
    );
  }
}

