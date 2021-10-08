import 'package:flutter/material.dart';
import 'package:flutter_app/Services/hotel_service.dart';
import 'package:flutter_app/Services/notes_service.dart';
import 'package:flutter_app/models/hotel.dart';
import 'package:flutter_app/models/note.dart';
import 'package:flutter_app/models/note_insert.dart';
import 'package:get_it/get_it.dart';



class NoteModify extends StatefulWidget {

  final String id;
  NoteModify({this.id});

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.id != null;

  NotesService get siteService => GetIt.I<NotesService>();

  String errorMessage;
  SiteD_model site;
  TextEditingController _sitetypeController = TextEditingController();
  TextEditingController _sitedetailController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _sitepriceController = TextEditingController();


  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      siteService.getNote(widget.id)
          .then((response) {
        setState(() {
          _isLoading = false;
        });
        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        site = response.data;
        _titleController.text = site.site_name;
        _sitetypeController.text = site.site_type;
        _sitedetailController.text = site.site_detail;
        _contentController.text = site.picture;
        _sitepriceController.text = site.site_location;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Site Detail' : 'Create note')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : Column(
          children: <Widget>[
            TextField(
              enabled: false,
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Site Name',
                hintText: 'Site Name',
                enabled: false,
              ),
            ),

            Container(height: 8),
            //Image.network("http//10.0.2.2:8000/media/Hotel_Image/"),
            Image.network(

              site.picture,
              width: 200,
              height: 200,
            ),
            TextField(
              enabled: false,
              controller: _sitetypeController,
              decoration: InputDecoration(
                labelText: 'Site type',
                  hintText: 'Site type'
              ),
            ),

            TextField(
              enabled: false,
              controller: _sitepriceController,
              decoration: InputDecoration(
                  labelText: "Location",
                  hintText: 'price'
              ),
            ),
            

            TextField(
              enabled: false,
              controller: _sitedetailController,
              decoration: InputDecoration(
                  labelText: "Site detail",
                  hintText: 'Site detail'
              ),
            ),

          ],
        ),
      ),
    );
  }
}

//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_app/Services/notes_service.dart';
// import 'package:flutter_app/models/note.dart';
// import 'package:flutter_app/models/note_insert.dart';
// import 'package:get_it/get_it.dart';
//
//
//
// class NoteModify extends StatefulWidget {
//
//   final String id;
//   NoteModify({this.id});
//
//   @override
//   _NoteModifyState createState() => _NoteModifyState();
// }
//
// class _NoteModifyState extends State<NoteModify> {
//   bool get isEditing => widget.id != null;
//
//   NotesService get notesService => GetIt.I<NotesService>();
//
//   String errorMessage;
//   SiteD_model Site;
//
//   TextEditingController _titleController = TextEditingController();
//   TextEditingController _contentController = TextEditingController();
//
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     if (isEditing) {
//       setState(() {
//         _isLoading = true;
//       });
//       notesService.getNote(widget.id)
//           .then((response) {
//         setState(() {
//           _isLoading = false;
//         });
//
//         if (response.error) {
//           errorMessage = response.errorMessage ?? 'An error occurred';
//         }
//         Site = response.data;
//         _titleController.text = Site.site_name;
//         _contentController.text = Site.site_detail;
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(isEditing ? 'Site  Detail' : 'Create note')),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: _isLoading ? Center(child: CircularProgressIndicator()) : Column(
//           children: <Widget>[
//             TextField(
//               controller: _titleController,
//               decoration: InputDecoration(
//                   hintText: 'Site Name'
//               ),
//             ),
//
//             Container(height: 8),
//
//             TextField(
//               controller: _contentController,
//               decoration: InputDecoration(
//                   hintText: 'Note content'
//               ),
//             ),
//
//             Container(height: 16),
//
//             SizedBox(
//               width: double.infinity,
//               height: 35,
//               child: RaisedButton(
//                 /*child: Text('Submit', style: TextStyle(color: Colors.white)),
//                 color: Theme.of(context).primaryColor,*/
//                 onPressed: () async {
//                   // if (isEditing) {
//                   //   setState(() {
//                   //     _isLoading = true;
//                   //   });
//                   //   final note = NoteManipulation(
//                   //       noteTitle: _titleController.text,
//                   //       noteContent: _contentController.text
//                   //   );
//                   //   final result = await notesService.updateNote(widget.id, note);
//                   //
//                   //   setState(() {
//                   //     _isLoading = false;
//                   //   });
//                   //
//                   //   final title = 'Done';
//                   //   final text = result.error ? (result.errorMessage ?? 'An error occurred') : 'Your note was updated';
//                   //
//                   //   showDialog(
//                   //       context: context,
//                   //       builder: (_) => AlertDialog(
//                   //         title: Text(title),
//                   //         content: Text(text),
//                   //         actions: <Widget>[
//                   //           FlatButton(
//                   //             child: Text('Ok'),
//                   //             onPressed: () {
//                   //               Navigator.of(context).pop();
//                   //             },
//                   //           )
//                   //         ],
//                   //       )
//                   //   )
//                   //       .then((data) {
//                   //     if (result.data) {
//                   //       Navigator.of(context).pop();
//                   //     }
//                   //   });
//                   //
//                   // } else {
//                   //
//                   //   setState(() {
//                   //     _isLoading = true;
//                   //   });
//                   //   final note = NoteManipulation(
//                   //       noteTitle: _titleController.text,
//                   //       noteContent: _contentController.text
//                   //   );
//                   //   final result = await notesService.createNote(note);
//                   //
//                   //   setState(() {
//                   //     _isLoading = false;
//                   //   });
//                   //
//                   //   final title = 'Done';
//                   //   final text = result.error ? (result.errorMessage ?? 'An error occurred') : 'Your note was created';
//                   //
//                   //   showDialog(
//                   //       context: context,
//                   //       builder: (_) => AlertDialog(
//                   //         title: Text(title),
//                   //         content: Text(text),
//                   //         actions: <Widget>[
//                   //           FlatButton(
//                   //             child: Text('Ok'),
//                   //             onPressed: () {
//                   //               Navigator.of(context).pop();
//                   //             },
//                   //           )
//                   //         ],
//                   //       )
//                   //   )
//                   //       .then((data) {
//                   //     if (result.data) {
//                   //       Navigator.of(context).pop();
//                   //     }
//                   //   });
//                   // }
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }