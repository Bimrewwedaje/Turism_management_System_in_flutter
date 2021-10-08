import 'package:flutter/material.dart';
import 'package:flutter_app/Services/TouristService.dart';
import 'package:flutter_app/models/TouristJoin.dart';
import 'package:get_it/get_it.dart';

class TouristDetail extends StatefulWidget {
  final String id;
  TouristDetail({this.id});

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<TouristDetail> {
  bool get isEditing => widget.id != null;

  TouristService get eventService => GetIt.I<TouristService>();

  String errorMessage;
  TouristJoinD_Model event;//First_name Father_Name Event_name Dob Contact Fee
  TextEditingController _First_nameController = TextEditingController();
  TextEditingController __Father_NameController = TextEditingController();
  TextEditingController _Event_nameController = TextEditingController();
  TextEditingController _DobController = TextEditingController();
  TextEditingController _ContactController = TextEditingController();
  TextEditingController _FeeController = TextEditingController();
  // TextEditingController _contentController = TextEditingController();


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
        _First_nameController.text = event.First_name;
        __Father_NameController.text = event.Father_Name;
        _Event_nameController.text= event.Event_name;
        _DobController.text = event.Dob;
        _ContactController.text = event.Contact;
        _FeeController.text = event.Fee;
        // _contentController.text = event.Image;
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
              controller: _First_nameController,
              decoration: InputDecoration(
                labelText: "Tourist First Name",
                hintText: 'Event title',
                enabled: false,
              ),
            ),

            Container(height: 8),
            //Image.network("http//10.0.2.2:8000/media/Hotel_Image/"),
            // Image.network(
            //   event.Image,
            //   width: 200,
            //   height: 200,
            // ),
            TextField(
              enabled: false,
              controller: __Father_NameController,
              decoration: InputDecoration(
                  labelText: "Tourist Father Name",
                  hintText: 'Event type'
              ),
            ),

            TextField(
              enabled: false,
              controller: _Event_nameController,
              decoration: InputDecoration(
                  labelText: "Event Name",
                  hintText: 'Event Date'
              ),
            ),
            TextField(// _First_nameController __Father_NameController _Event_nameController _DobController _ContactController _FeeController
              enabled: false,
              controller: _DobController,
              decoration: InputDecoration(
                  labelText: "Tourist Date Of Birth",
                  hintText: 'Event Price For full Action'
              ),
            ),

            TextField(
              enabled: false,
              controller: _ContactController,
              decoration: InputDecoration(
                  labelText: "Tourist Contact",
                  hintText: 'Location'
              ),
            ),
            TextField(
              enabled: false,
              controller: _FeeController,
              decoration: InputDecoration(
                  labelText: "Tourist Fee",
                  hintText: 'Event detail'
              ),
            ),
          ],
        ),
      ),
    );
  }
}

