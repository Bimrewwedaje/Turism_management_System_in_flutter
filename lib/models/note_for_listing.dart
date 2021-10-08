

import 'dart:ui';

class NoteForListing {
  String id;
  String site_name;
  String site_type;
  String site_location;
  String site_detail;
  String picture;

  NoteForListing({this.id,this.site_name, this.site_location, this.site_type, this.site_detail , this.picture});

  factory NoteForListing.fromJson(Map<String, dynamic> item) {
    return NoteForListing(
      id:(item['id']).toString(),
      site_name: item['site_name'],
      site_type: item['site_type'],
      site_location: item['site_location'],
      site_detail: item['site_detail'],
      picture: item['picture'].toString(),
    );
  }

}