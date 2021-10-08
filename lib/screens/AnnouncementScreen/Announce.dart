import 'package:flutter/material.dart';

class Announce extends StatelessWidget {

  final int AnnID;
  bool get isEditing => AnnID != null;

  Announce({this.AnnID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Announcement' : 'Announce')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  hintText: 'Announced By'
              ),
            ),

            TextField(
              decoration: InputDecoration(
                  hintText: 'Announcement title'
              ),
            ),

            Container(height: 8),

            TextField(
              decoration: InputDecoration(
                  hintText: 'Announcement content'
              ),
            ),

            Container(height: 16),

            SizedBox(
              width: double.infinity,
              height: 35,
              child: RaisedButton(
                child: Text('Submit', style: TextStyle(color: Colors.white)),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}