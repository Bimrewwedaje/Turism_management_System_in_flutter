import 'package:flutter/foundation.dart';

class NoteManipulation {
  String noteID;
  String noteTitle;
  String noteContent;

  NoteManipulation(
      {
        @required this.noteID,
        @required this.noteTitle,
        @required this.noteContent,
      }
      );

  Map<String, dynamic> toJson() {
    return {
      "noteID":noteID,
      "noteTitle": noteTitle,
      "noteContent": noteContent
    };
  }
}