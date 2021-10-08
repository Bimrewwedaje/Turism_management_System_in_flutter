import 'package:flutter/material.dart';
import 'package:flutter_app/Services/hotel_service.dart';
import 'package:flutter_app/Services/notes_service.dart';
import 'package:flutter_app/models/hotel.dart';
import 'package:flutter_app/models/note.dart';
import 'package:flutter_app/models/note_insert.dart';
import 'package:get_it/get_it.dart';



class HotelModify extends StatefulWidget {

  final String id;
  HotelModify({this.id});

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<HotelModify> {
  bool get isEditing => widget.id != null;

  HotelService get hotelService => GetIt.I<HotelService>();

  String errorMessage;
  HotelD_Model hotel;
  TextEditingController _hoteltypeController = TextEditingController();
  TextEditingController _hoteldetailController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _hotelpriceController = TextEditingController();


  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      hotelService.getHotel(widget.id)
          .then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        hotel = response.data;
        _titleController.text = hotel.Hotel_name;
        _hoteltypeController.text = hotel.Hotel_type;
        _hoteldetailController.text = hotel.Hotel_detail;
        _contentController.text = hotel.Image;
        _hotelpriceController.text=hotel.Hotel_price;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Hotel Detail' : 'Create note')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : Column(
          children: <Widget>[
            TextField(
              enabled: false,
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Hotel Name",
                  hintText: 'Hotel title',
                      enabled: false,
              ),
            ),

            Container(height: 8),
           //Image.network("http//10.0.2.2:8000/media/Hotel_Image/"),
            Image.network(
              hotel.Image,
              width: 200,
              height: 200,
            ),
            TextField(
              enabled: false,
              controller: _hoteltypeController,
              decoration: InputDecoration(
                labelText: "Hotel Type",
                  hintText: 'Hotel type'
              ),
            ),

            TextField(
              enabled: false,
              controller: _hotelpriceController,
              decoration: InputDecoration(
                  labelText: "Hotel price per Day",
                  hintText: 'price'
              ),
            ),
            
            TextField(
              enabled: false,
              controller: _hoteldetailController,
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