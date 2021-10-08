import 'package:flutter/material.dart';
import 'package:flutter_app/Services/GasStationService.dart';
import 'package:flutter_app/Services/hotel_service.dart';
import 'package:flutter_app/Services/notes_service.dart';
import 'package:flutter_app/models/GasStation.dart';
import 'package:flutter_app/models/hotel.dart';
import 'package:flutter_app/models/note.dart';
import 'package:flutter_app/models/note_insert.dart';
import 'package:get_it/get_it.dart';



class GasStationModify extends StatefulWidget {

  final String id;
  GasStationModify({this.id});

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<GasStationModify> {
  bool get isEditing => widget.id != null;

  GasStationService get gasStationService => GetIt.I<GasStationService>();

  String errorMessage;
  GasStationD_Model gasStation;
  TextEditingController _GasStationdetailController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _gasStationLocController = TextEditingController();
  // TextEditingController _GasStationpriceController = TextEditingController();


  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      gasStationService.getGasStation(widget.id)
          .then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        gasStation = response.data;
        _titleController.text = gasStation.GasStation_name;
        _GasStationdetailController.text = gasStation.GasStation_detail;
        _contentController.text = gasStation.Image;
        _gasStationLocController.text = gasStation.GasStation_location;
        // _GasStationpriceController.text=GasStation.Hotel_price;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Gas Station Detail' : 'Create note')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : Column(
          children: <Widget>[
            TextField(
              enabled: false,
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Gas Station Name",
                hintText: 'Gas Station title',
                enabled: false,
              ),
            ),

            Container(height: 8),
            Image.network(
              gasStation.Image,
              width: 200,
              height: 200,
            ),
            TextField(
              enabled: false,
              controller: _gasStationLocController,
              decoration: InputDecoration(
                  labelText: "Gas Station Location",
                  hintText: 'Gas Station Location'
              ),
            ),

            // TextField(
            //   enabled: false,
            //   controller: _GasStationpriceController,
            //   decoration: InputDecoration(
            //       labelText: "Hotel price per Day",
            //       hintText: 'price'
            //   ),
            // ),

            TextField(
              enabled: false,
              controller: _GasStationdetailController,
              decoration: InputDecoration(
                  labelText: "Hotel Detail",
                  hintText: 'Hotel detail'
              ),
            ),




          ],
        ),
      ),
    );
  }
}